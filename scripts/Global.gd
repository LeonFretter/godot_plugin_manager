extends Node

export var _plugin_folder_path = "res://plugins/"
export var _project_folder_path = "res://projects/"

export var _plugins : Array
export var _projects : Array
export var _projects_plugins_installed : Dictionary

func _ready():
	createFolderArray(_plugins, _plugin_folder_path)
	createFolderArray(_projects, _project_folder_path)
	checkProjectsForPlugins()

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
