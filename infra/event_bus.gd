extends Node


var on_tile_broken := ParamEvent.new()
var on_score_changed := ParamEvent.new()


var on_ball_lost := Event.new()
var on_lives_changed := ParamEvent.new()
var on_respawn_requested := Event.new()


var on_game_over := ParamEvent.new()


var on_game_restarted := Event.new()