class_name Tile
extends StaticBody2D


@export var tile_textures: Array[Texture2D]


func paint(index: int):
	($TileColor as Sprite2D).texture = tile_textures[index]


func width():
	return ($TileColor as Sprite2D).texture.get_width()


func height():
	return ($TileColor as Sprite2D).texture.get_height()


func destroy():
	queue_free()
