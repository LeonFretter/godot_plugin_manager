extends VBoxContainer

class_name ProjectPanel

export var _packed_project_item : PackedScene

var _list_node : VBoxContainer
var _projects : Array
var _projects_plugins_installed : Dictionary
var _project_items : Array
var _plugin : String

func _ready():
	_list_node = get_node("ProjectList")
	_projects = Global._projects
	_projects_plugins_installed = Global._projects_plugins_installed
	
	for project in _projects:
		var project_item = _packed_project_item.instance()
		project_item.setLabel(str(project))
		_project_items.append(project_item)
		_list_node.add_child(project_item)
	
# sets the active plugin
func setPlugin(plugin : String) -> void:
	_plugin = plugin
	var i=0
	for project_key in _projects_plugins_installed:
		var installed_plugins = _projects_plugins_installed[project_key]
		var is_installed = installed_plugins.has(plugin)
		_project_items[i].setEnabled(true)
		_project_items[i].setChecked(is_installed)
		i += 1

func install(plugin : String, project : String):
	var source_path = Global._plugin_folder_path+plugin+"/bin/"
	var target_path = Global._project_folder_path+project+"/bin/plugins/"+plugin
	
	var dir = Directory.new()
	dir.open("")
	var root_path = dir.get_current_dir()
	
	source_path = root_path + "/" + source_path.split("res://")[1]
	target_path = root_path + "/" + target_path.split("res://")[1]
	
	Installer.source_path = source_path
	Installer.target_path = target_path
	
	Installer.copyDirectory()

func _on_UpdateButton_pressed():
	for i in range(_projects.size()):
		var item = _project_items[i]
		var label = _projects[i]	
		var checked = item.getChecked()
		if !checked:
			continue
		else:
			print("installing " + _plugin + " to " + label)
			install(_plugin, label)
