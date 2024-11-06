extends Node


var on_tile_broken := ParamEvent.new()
var on_score_changed := ParamEvent.new()


var on_ball_lost := Event.new()
var on_lives_changed := ParamEvent.new()


var on_game_lost := Event.new()
var on_game_won := Event.new()