class_name Tile
extends StaticBody2D


@export var tile_textures: Array[Texture2D]


@onready var tier: int


func build(index: int):
	($TileColor as Sprite2D).texture = tile_textures[index]
	tier = index + 1


func width():
	return ($TileColor as Sprite2D).texture.get_width()


func height():
	return ($TileColor as Sprite2D).texture.get_height()


func destroy():
	EventBus.on_tile_broken.trigger(tier)
	queue_free()
