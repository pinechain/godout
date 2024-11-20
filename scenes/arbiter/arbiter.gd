extends Node2D


var _score := 0
var _hiscore := 0
var _current_lives := Globals.MAX_LIVES


func _init():
	EventBus.on_tile_broken.sub(_increase_score)
	EventBus.on_ball_lost.sub(_lose_life)
	EventBus.on_game_restarted.sub(_reset)
	EventBus.on_last_tile_broken.sub(_trigger_victory)


func generate_persist_data():
	return {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"_hiscore" : _hiscore
	}


func _increase_score(added_score: int):
	_score += added_score
	EventBus.on_score_changed.trigger(_score)


func _lose_life():
	_current_lives -= 1
	if _current_lives == 0:
		_trigger_defeat()
	else:
		EventBus.on_lives_changed.trigger(_current_lives)
		EventBus.on_respawn_requested.trigger()


func _reset():
	_score = 0
	_current_lives = Globals.MAX_LIVES


func _trigger_defeat():
	_update_hiscore()
	EventBus.on_game_over.trigger(false)


func _trigger_victory():
	_update_hiscore()
	EventBus.on_game_over.trigger(true)


func _update_hiscore():
	if _hiscore < _score:
		_hiscore = _score
	
	EventBus.on_hiscore_updated.trigger(_hiscore)
