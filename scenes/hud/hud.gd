extends Node2D


func _ready():
	EventBus.on_score_changed.sub(_update_score)
	EventBus.on_lives_changed.sub(_update_lives)
	EventBus.on_game_over.sub(_on_game_over)
	EventBus.on_save_finished.sub(_exit)
	EventBus.on_hiscore_updated.sub(_update_hiscore)
	
	($GameOver/Exit as Button).pressed.connect(_start_exit)
	($GameOver/Restart as Button).pressed.connect(_reset)

	($Gameplay/Lives as Label).text = str(Globals.MAX_LIVES)
	_show($Gameplay)


func _update_score(new_score: int):
	($Gameplay/Score as Label).text = str(new_score)


func _update_lives(new_lives: int):
	($Gameplay/Lives as Label).text = str(new_lives)


func _update_hiscore(new_hiscore: int):
	($GameOver/Hiscore as Label).text = str(new_hiscore)


func _on_game_over(is_victory: bool):
	var game_over_text = ""
	if is_victory:
		game_over_text = Globals.GAME_WON
	else:
		game_over_text = Globals.GAME_LOST
	
	_show($GameOver)
	($GameOver/GameOverText as Label).text = game_over_text
	($GameOver/Score as Label).text = ($Gameplay/Score as Label).text


func _show(node: Node):
	for child in get_children():
		if child == node:
			child.visible = true
		else:
			child.visible = false


func _start_exit():
	EventBus.on_game_exited.trigger()


func _exit():
	get_tree().quit()


func _reset():
	EventBus.on_game_restarted.trigger()
	_update_lives(Globals.MAX_LIVES)
	_update_score(0)
	_show($Gameplay)
