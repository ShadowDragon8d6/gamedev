extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -800.0
const GROUND_FRICTION = 0.09
const AIR_RESIST = 0.9
const GRAVITY = 1800
const DASH_SPEED = 1000.0
const DASH_TIME = 0.2
const DASH_COOLDOWN = 0.5

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0

var falling = false
var jumping  = false

var coyote_frames = 6
var coyote = false
var last_floor = false

var facing_direction = 1

var jump_counter = 0
var max_jumps = 1

var axe_gotten = false
var double_jump_got = false
var hover_got = false

# things to implement:
# hover


func _physics_process(delta):
	
	# movement code
	
	# gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		falling = true
		
	if is_on_floor():
		jump_counter = 0
		
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote or max_jumps > jump_counter):
		velocity.y = JUMP_VELOCITY*(0.7**jump_counter)
		jumping = true
		jump_counter += 1
	
	# direction
	var direction = Input.get_axis("left", "right")
	
	if direction:
		facing_direction = direction
		$sprite.flip_h = direction==-1
		velocity.x = direction * SPEED
	else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, SPEED * GROUND_FRICTION)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED * AIR_RESIST * delta)
	if is_on_floor():
		if axe_gotten:
			if Input.is_action_pressed("interact"):
				$sprite.play("axe")
			elif direction == 0:
				$sprite.play("idle")
			else:
				$sprite.play("run")
		elif direction == 0:
			$sprite.play("idle")
		else:
			$sprite.play("run")
		
	else:
		$sprite.play("jump")

	if hover_got:
		if Input.is_action_just_pressed("shift") and !is_dashing and dash_cooldown_timer <= 0:
			is_dashing = true
			dash_timer = DASH_TIME
			dash_direction = sign(Input.get_axis("left", "right"))
			if dash_direction == 0:
				dash_direction = facing_direction  # dash in facing direction if no input

		if is_dashing:
			velocity.x = dash_direction * DASH_SPEED
			velocity.y = 0  # freeze vertical movement during dash
			dash_timer -= delta
			if dash_timer <= 0:
				is_dashing = false
				dash_cooldown_timer = DASH_COOLDOWN
		else:
			# cooldown count down
			if dash_cooldown_timer > 0:
				dash_cooldown_timer -= delta
		get_node("/root/main/canvas/dash_meter").value = dash_cooldown_timer
	
	last_floor = is_on_floor()

	move_and_slide()
	
	# handle coyote jump
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$coyoteTimer.start()
		print("coyote jump")
	


func _on_coyote_timer_timeout():
	coyote = false
	

func _on_dialogue_box_got_axe():
	axe_gotten = true


func _on_dialogue_box_got_double_jump():
	max_jumps = 2
	double_jump_got = true


func _on_dialogue_box_got_hover():
	hover_got = true
