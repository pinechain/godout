extends Node


var on_tile_broken := ParamEvent.new()
var on_score_changed := ParamEvent.new()
var on_hiscore_updated := ParamEvent.new()


var on_ball_lost := Event.new()
var on_lives_changed := ParamEvent.new()
var on_respawn_requested := Event.new()


var on_last_tile_broken := Event.new()


var on_game_over := ParamEvent.new()
var on_game_restarted := Event.new()
var on_game_exited := Event.new()


var on_save_finished := Event.new()