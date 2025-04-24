extends Node2D

var shown_axe = false
var shown_double = false
var shown_hover = false
var shown_tummy = false
var shown_window = false
var shown_doctor = false

var fell = false

var people = 4

func _ready():
	$canvas/title.show()
	$double_man/dialogueArea/areaShape.disabled = true
	$hover_man/dialogueArea/areaShape.disabled = true
	$door/CollisionShape2D.disabled = true


func _on_dialogue_box_rescued(ind):
	people -= 1


func _on_virus_timer_timeout():
	game_over()
	

func game_over():
	$canvas/game_over.show()
	$canvas/timer_label/virus_timer.stop()
	if fell:
		$canvas/game_over/lost.show()
		$canvas/game_over/lost.text = "you fell down D:"
	elif people > 0:
		$canvas/game_over/lost.show()
		$canvas/game_over/lost.text = "you missed " + str(people) + " people :((("
	elif $canvas/timer_label/virus_timer.time_left <= 0:
		$canvas/game_over/lost.show()
		$canvas/game_over/lost.text = "you ran out of time :c"
	else:
		$canvas/game_over/won.show()


func _on_title_start():
	$canvas/title.hide()
	$canvas/timer_label/virus_timer.start()
	

func _on_axe_man_start_convo(body):
	if body is CharacterBody2D && !shown_axe:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.axeman()
		shown_axe = true


func _on_double_man_start_convo(body):
	if body is CharacterBody2D && !shown_double:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.doubleman()
		shown_double = true


func _on_hover_man_start_convo(body):
	if body is CharacterBody2D && !shown_hover:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.hoverman()
		shown_hover = true


func _on_tummy_man_start_convo(body):
	if body is CharacterBody2D && !shown_tummy:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.tummyhurtman()
		shown_tummy = true


func _on_window_man_start_convo(body):
	if body is CharacterBody2D && !shown_window:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.windowman()
		shown_window = true


func _on_doctor_start_convo(body):
	if body is CharacterBody2D && !shown_doctor:
		$canvas/dialogue_box.show()
		$canvas/dialogue_box.doctor()
		shown_doctor = true
		


func _on_debris_1_broke1() -> void:
	$double_man/dialogueArea/areaShape.disabled = false
	$debris1.hide()

func _on_debris_2_broke2() -> void:
	$hover_man/dialogueArea/areaShape.disabled = false
	$debris2.hide()

func _on_debris_3_broke3() -> void:
	$door/CollisionShape2D.disabled = false
	$debris3.hide()

func _on_door_body_entered(body: Node2D) -> void:
	game_over()


func _on_debris_1_broke(num) -> void:
	print("hi", num)
	if num == "1":
		_on_debris_1_broke1()


func _on_debris_2_broke(num) -> void:
	if num == "2":
		_on_debris_2_broke2()


func _on_debris_3_broke(num) -> void:
	if num == "3":
		_on_debris_3_broke3()


func _on_level_die() -> void:
	fell = true
	game_over()
