extends Node2D


func _ready():
	EventBus.on_score_changed.sub(_update_score)
	EventBus.on_lives_changed.sub(_update_lives)

	($Control/Lives as Label).text = str(Globals.MAX_LIVES)


func _update_score(new_score: int):
	($Score as Label).text = str(new_score)


func _update_lives(new_lives: int):
	($Control/Lives as Label).text = str(new_lives)
