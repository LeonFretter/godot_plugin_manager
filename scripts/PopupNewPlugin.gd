extends ConfirmationDialog

export var _path_input : NodePath

var _node_input : Node

func _ready():
	_node_input = get_node(_path_input)

func _on_PopupNewPlugin_confirmed():
	var plugin_name = _node_input.getInput()
	var plugins = Global._plugins
	
	for plugin in plugins:
		if plugin == plugin_name:
			print('Plugin already exists')
			return

	var plugin_template_path = Global._template_plugin_path_abs
	var plugin_path = Global._plugin_folder_path_abs+plugin_name

	Installer.plugin_template_path = plugin_template_path
	Installer.createPlugin(plugin_path)
