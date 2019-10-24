tool
extends VBoxContainer

export var _label : String setget setLabel, getLabel

onready var _elem_label = get_node("Label")
onready var _elem_line_edit = get_node("LineEdit")


func _ready():
	pass

func setLabel(label : String) -> void:
	_label = label
	if Engine.editor_hint:
		_elem_label = get_node("Label")
		_elem_label.text = _label
	
func getLabel() -> String:
	return _label

func getInput() -> String:
	return _elem_line_edit.text
