tool
extends VBoxContainer

export var _label : String

onready var _node_label = get_node("Label")

func _ready():
	_node_label.text = _label
