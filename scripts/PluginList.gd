extends ItemList

export var _project_panel_node_path : NodePath

var _plugins : Array
var _project_panel : ProjectPanel

func _ready():
	_project_panel = get_node(_project_panel_node_path)
	_plugins = Global._plugins
	var i = 0
	for plugin in _plugins:
		self.add_item(plugin)

func _on_PluginList_item_selected(index):
	var item = items[index*3]
	_project_panel.setPlugin(item)
