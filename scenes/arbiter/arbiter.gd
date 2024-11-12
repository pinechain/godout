extends Node2D


var _score := 0
var _current_lives := Globals.MAX_LIVES


func _ready():
	EventBus.on_tile_broken.sub(_increase_score)
	EventBus.on_ball_lost.sub(_lose_life)
	EventBus.on_game_restarted.sub(_reset)


func _increase_score(added_score: int):
	_score += added_score
	EventBus.on_score_changed.trigger(_score)


func _lose_life():
	_current_lives -= 1
	if _current_lives == 0:
		EventBus.on_game_over.trigger(false)
	else:
		EventBus.on_lives_changed.trigger(_current_lives)
		EventBus.on_respawn_requested.trigger()


func _reset():
	_score = 0
	_current_lives = Globals.MAX_LIVES