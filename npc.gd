
extends RigidBody2D

signal start_convo
@export var sprite_path = ""

func _ready():
	var sprite = load(sprite_path)
	$Sprite2D.texture = sprite


func _on_dialogue_area_body_entered(body):
	start_convo.emit(body)
