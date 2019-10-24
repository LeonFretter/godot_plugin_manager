extends Control

var _check_box : CheckBox
var _label : String
var _default_status : bool
var _panel_container : PanelContainer

export var _default_color : Color
export var _warning_color : Color
export var _success_color : Color

func _ready():
	_panel_container = get_node("PanelContainer")
	setColor(_default_color)
	
	_check_box = get_node("PanelContainer/ProjectStatus")
	_check_box.text = _label

func setEnabled(enable : bool) -> void:
	_check_box.disabled = !enable

func setDefaultStatus(status : bool) -> void:
	_default_status = status

func setLabel(label : String) -> void:
	_label = label
	if _check_box != null:
		_check_box.text = label

func setChecked(checked : bool) -> void:
	_check_box.pressed = checked
	
func getChecked() -> bool:
	return _check_box.pressed

func setColor(color : Color) -> void:
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = color
	_panel_container.add_stylebox_override("panel", style_box)

func _on_ProjectStatus_pressed():
	var status = _check_box.pressed
	
	if status == false and _default_status == true:
		setColor(_warning_color)
	elif status == true and _default_status == false:
		setColor(_success_color)
	else:
		setColor(_default_color)
