extends Node2D

signal die

func _on_deathbox_body_entered(body: Node2D) -> void:
	if body.name == "player":
		die.emit()
