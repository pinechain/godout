extends Node2D


@export var tile_reference: PackedScene


@export var _first_spawn := 500


func _ready():
	# THIS HERE IS A GAMBIARRA SO THAT I DONT NEED TO CALCULATE EVERYTHING EVERYTIME
	# AND I AM PROUD OF IT
	var ref = tile_reference.instantiate() as Tile
	var tile_height = ref.height()
	var tile_width = ref.width()
	ref.queue_free()

	for row in range(0, 8):
		for column in range(0, 16):
			var pos_y = _determine_tile_pos_y(tile_height, row)
			var pos_x = _determine_tile_pos_x(tile_width, column, row)
			var tile = tile_reference.instantiate() as Tile
			tile.position = Vector2(pos_x, pos_y)
			tile.build(row)
			add_child(tile)	


func _determine_tile_pos_y(height: int, row: int):
	var y_offset = row * (height + Globals.TILE_MARGIN_Y)
	return _first_spawn - y_offset


func _determine_tile_pos_x(width: int, column: int, row: int):
	var x_offset = column * (width + Globals.TILE_MARGIN_X)
	var is_even = row % 2 == 0
	if is_even:
		return x_offset
	else:
		return x_offset - width/2
	
