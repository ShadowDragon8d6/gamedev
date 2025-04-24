extends Control

var script_dict = {}

signal got_axe
signal got_double_jump
signal got_hover
signal rescued

# Called when the node enters the scene tree for the first time.
func _ready():
	script_dict = read_json()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func read_json():
	var file = "res://script.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict


func typewriter():
	var type_tween = create_tween()
	$label.visible_ratio = 0.0
	type_tween.tween_property($label, "visible_ratio", 1.0, 1.5)
	

func axeman():
	for i in range(1):
		$label.text = script_dict["axe man"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	got_axe.emit()


func doubleman():
	for i in range(1):
		$label.text = script_dict["double jump man"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	got_double_jump.emit()
	rescued.emit(0)


func hoverman():
	for i in range(1):
		$label.text = script_dict["hover man"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	got_hover.emit()
	rescued.emit(1)

func tummyhurtman():
	for i in range(1):
		$label.text = script_dict["tummy hurt man"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	rescued.emit(2)

func windowman():
	for i in range(1):
		$label.text = script_dict["window man"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	rescued.emit(3)

func doctor():
	for i in range(1):
		$label.text = script_dict["doctor"][i]
		typewriter()
		await get_tree().create_timer(3.5).timeout
	self.hide()
	rescued.emit(4)
	


func _on_got_axe() -> void:
	pass # Replace with function body.
