extends Node

export var _plugin_folder_path = "res://plugins/"
export var _project_folder_path = "res://projects/"
export var _template_plugin_path = "res://plugin_template/"

export var _plugins : Array
export var _projects : Array
export var _projects_plugins_installed : Dictionary

var _plugin_folder_path_abs : String
var _project_folder_path_abs : String
var _template_plugin_path_abs : String

func _ready():
	createFolderArray(_plugins, _plugin_folder_path)
	createFolderArray(_projects, _project_folder_path)
	checkProjectsForPlugins()
	var dir = Directory.new()
	dir.open("")
	var root_path = dir.get_current_dir()
	
	_plugin_folder_path_abs = makeAbsolutePath(root_path, _plugin_folder_path)
	_project_folder_path_abs = makeAbsolutePath(root_path, _project_folder_path)
	_template_plugin_path_abs = makeAbsolutePath(root_path, _template_plugin_path)

func makeAbsolutePath(root_path : String, rel_path : String) -> String:
	return root_path + "/" + rel_path.split("res://")[1]

# gets all folders in path, adds them to array
func createFolderArray(arr : Array, path : String) -> void:
	arr.clear()
	var folder = Directory.new()
	folder.open(path)
	folder.list_dir_begin()
	
	while true:
		var file = folder.get_next()
		if file == "":
			break
		elif folder.dir_exists(file) and file != "." and file != "..":
			arr.append(file)

func checkProjectsForPlugins() -> void:
	for project in _projects:
		var project_path = _project_folder_path+project+"/"
		var dir = Directory.new()
		
		dir.open(project_path)
		if not dir.dir_exists("bin") or not dir.dir_exists("bin/plugins/"):
			dir.make_dir_recursive("bin/plugins/")
		
		_projects_plugins_installed[project] = []
		var plugin_path = project_path+"bin/plugins/" 
		
		createFolderArray(_projects_plugins_installed[project], plugin_path)
