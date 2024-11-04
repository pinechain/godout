extends Node2D


var _score := 0


func _ready():
	EventBus.on_tile_broken.sub(_increase_score)

func _increase_score(added_score: int):
	_score += added_score
	print(added_score)
	EventBus.on_score_changed.trigger(_score)
