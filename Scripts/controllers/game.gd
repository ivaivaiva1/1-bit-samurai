extends Node2D
class_name Game

var game_state: String 
@onready var blur_color_rect: ColorRect = %shader_rect
@onready var game_window: SubViewport = %game_window
@onready var battle_window_container: SubViewportContainer = %battle_container


func _init() -> void:
	GameManager.game = self
	game_state = GAME_STATE.EXPLORE


func start_battle():
	battle_window_container.visible = true
	blur_screen(true)
	GameStateHandler.start_battle()


func end_battle():
	battle_window_container.visible = false
	blur_screen(false)
	GameManager.player.kill_enemy()



func blur_screen(condition: bool):
	var target_strenght: float
	var tween_time: float
	if condition == true:
		target_strenght = 3.0
		tween_time = 0.4
	else:
		target_strenght = 0.0
		tween_time = 0.2
	
	var blur_material: ShaderMaterial = blur_color_rect.material
	var tween = blur_color_rect.create_tween()
	tween.tween_property(blur_material, "shader_parameter/strength", target_strenght, tween_time)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)



const GAME_STATE = {
	EXPLORE = "explore",
	BATTLE = "battle",
	PAUSED = "pause"
}
