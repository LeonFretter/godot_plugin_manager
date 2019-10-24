extends Button

export var _popup_packed : PackedScene

var _popup : Popup

func _ready():
	_popup = _popup_packed.instance()
	var root = get_tree().get_root()
	root.call_deferred("add_child", _popup)

func _on_NewButton_pressed():
	_popup.popup()
