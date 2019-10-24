extends Node

class_name ProjectStatus

export var _label : String
export var _is_installed : bool
export var _do_install : bool

func hasChanges() -> bool:
	return _is_installed != _do_install
