extends CharacterBody2D
class_name Player


var moveSpeed:float = 200
@onready var animated_sprite = %Sprite
var battle_enemy: Enemy

func _init() -> void:
	GameManager.player = self


func _physics_process(_delta: float) -> void:
	#if GameManager.game.game_state != GameManager.game.GAME_STATE.EXPLORE: return
	
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	if input_vector == Vector2.ZERO:
		animated_sprite.play("idlePlayer") 
	else:
		animated_sprite.play("walkPlayer") 
	
	velocity = input_vector*moveSpeed
	move_and_slide()
	
	if input_vector.x > 0:
		animated_sprite.flip_h = false
	elif input_vector.x < 0:
		animated_sprite.flip_h = true



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		battle_enemy = area.get_parent().get_parent()
		print(battle_enemy)
		GameManager.game.start_battle()


func kill_enemy():
	print(battle_enemy)
	if battle_enemy == null: return
	battle_enemy.queue_free()
	battle_enemy = null
