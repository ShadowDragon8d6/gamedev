extends Node2D

@onready var got_axe = false
@onready var in_range = false

signal broke


func _on_dialogue_box_got_axe() -> void:
	got_axe = true


func _on_area_2d_body_entered(body: Node2D):
	print("inside of range")
	if body.name == "player":
		in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("out of range")
	if body.name == "player":
		in_range = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and got_axe and in_range:
		await get_tree().create_timer(1).timeout
		print("broke through", got_axe, in_range, name)
		
		var number = name.substr(len(name)-1)
		print(number)
		broke.emit(number)
