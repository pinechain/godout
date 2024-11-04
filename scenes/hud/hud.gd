extends Control


func _ready():
	EventBus.on_score_changed.sub(_update_score)

func _update_score(new_score: int):
	($Score as Label).text = str(new_score)