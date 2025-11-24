extends Node2D

class_name RoomsController
@export var initialRoom: PackedScene
var actualRoom: Room
var can_change_room: bool = true

func _ready():
	GameManager.game.rooms_controller = self
	SpawnRoom(ROOM_DIRECTION.INITIAL)

func SpawnRoom(roomDirection: String):
	if not can_change_room:
		return

	can_change_room = false

	var room_num: String = ""
	
	match roomDirection:
		ROOM_DIRECTION.INITIAL:
			room_num = "1"
		ROOM_DIRECTION.LEFT:
			room_num = actualRoom.left_room
		ROOM_DIRECTION.RIGHT:
			room_num = actualRoom.right_room
		ROOM_DIRECTION.TOP:
			room_num = actualRoom.top_room
		ROOM_DIRECTION.DOWN:
			room_num = actualRoom.down_room
	
	if room_num == "":
		can_change_room = true
		return
	
	var path = "res://Scenes/rooms/room_%s.tscn" % room_num
	var targetScene = load(path) as PackedScene

	if actualRoom != null:
		actualRoom.queue_free()
		actualRoom = null
		
	if targetScene == null:
		can_change_room = true
		return
			
	var newRoom = targetScene.instantiate()
	add_child(newRoom)
	newRoom.global_position = Vector2.ZERO
	actualRoom = newRoom

	var player = get_tree().get_first_node_in_group("player")

	if player:
		var vp_size = get_viewport_rect().size
		var offset = 32
		
		var hud_node = get_tree().get_root().find_child("HUD_TOP", true, false)
		var hud_height = hud_node.size.y if hud_node else 0

		match roomDirection:
			ROOM_DIRECTION.LEFT:
				player.global_position.x = vp_size.x - offset

			ROOM_DIRECTION.RIGHT:
				player.global_position.x = offset

			ROOM_DIRECTION.TOP:
				player.global_position.y = vp_size.y - offset

			ROOM_DIRECTION.DOWN:
				player.global_position.y = hud_height + offset

			ROOM_DIRECTION.INITIAL:
				pass

	await get_tree().create_timer(0.3).timeout
	can_change_room = true

const ROOM_DIRECTION = {
	INITIAL = "initial",
	LEFT = "left",
	RIGHT = "right",
	TOP = "top",
	DOWN = "down"
}
