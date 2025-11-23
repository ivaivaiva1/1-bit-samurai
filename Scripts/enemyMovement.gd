extends Node2D
class_name Enemy


var moveSpeed:float = 130
@onready var sprite = %Sprite
@onready var visionArea = $VisionArea
var move_area = Rect2(Vector2.ZERO, Vector2(400, 300))
var area_position: Vector2 = Vector2.ZERO
var player: Node2D = null
var followPlayer:bool

func _ready():
	move_area.position = global_position - move_area.size / 2
	_set_new_area()


func _on_vision_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		#print('Entrou')
		player = area.get_parent()
		followPlayer = true
		
func _on_vision_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		followPlayer = false
		player = null
		#print('Saiu')


func _physics_process(delta: float) -> void:
	return
	if followPlayer and player != null:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * moveSpeed * delta
		if direction.x != 0:
			sprite.flip_h = direction.x < 0
	else:
		_move(delta)


func _move(delta: float) -> void:
	var direction: Vector2 = area_position - global_position
	if direction.length() > 1:
		global_position += direction.normalized() * moveSpeed * delta
		if direction.x != 0:
			sprite.flip_h = direction.x < 0
	else:
		_set_new_area()



func _set_new_area() -> void:
	area_position = Vector2(
		randf_range(move_area.position.x, move_area.position.x + move_area.size.x),
		randf_range(move_area.position.y, move_area.position.y + move_area.size.y)
	)
