extends Node2D


func _ready():
	EventBus.on_game_exited.sub(save_game_data)
	load_game_data()


func save_game_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)

	for percy in get_tree().get_nodes_in_group(Globals.SAVE_TAG):
		if percy.has_method("generate_persist_data"):
			if percy.scene_file_path.is_empty():
				print("persistent node '%s' is not an instanced scene, skipped" % percy.name)
				continue

			if !percy.has_method("generate_persist_data"):
				print("persistent node '%s' is missing a generate_persist_data() function, skipped" % percy.name)
				continue

			var save_data = JSON.stringify(percy.call("generate_persist_data"))
			save_file.store_line(save_data)
	
	EventBus.on_save_finished.trigger()


func load_game_data():
	if not FileAccess.file_exists("user://savegame.save"):
		return

	var save_nodes = get_tree().get_nodes_in_group(Globals.SAVE_TAG)
	for i in save_nodes:
		i.queue_free()

	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.data
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
