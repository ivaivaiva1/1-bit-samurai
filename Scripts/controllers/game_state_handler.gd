extends Node

@onready var game: Game = GameManager.game


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("end_battle"):
		end_battle()


func start_battle():
	if game.game_state != game.GAME_STATE.EXPLORE: return
	game.game_state = game.GAME_STATE.BATTLE
	get_tree().paused = true


func end_battle():
	if game.game_state != game.GAME_STATE.BATTLE: return
	game.game_state = game.GAME_STATE.EXPLORE
	get_tree().paused = false
	game.end_battle()
