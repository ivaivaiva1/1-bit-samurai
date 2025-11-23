extends Node2D

@export var floatingObject: Node2D
@export var float_distance: float = 4.0  
@export var float_time: float = 0.8  

func _ready() -> void:
	if not floatingObject:
		push_error("floatingObject não está configurado!")
		return

	start_floating()


func start_floating():
	var start_y = floatingObject.position.y
	var up_y = start_y - float_distance
	var down_y = start_y + float_distance

	var tw = get_tree().create_tween()
	tw.set_loops()
	tw.set_trans(Tween.TRANS_SINE)
	tw.set_ease(Tween.EASE_IN_OUT)

	# sobe
	tw.tween_property(floatingObject, "position:y", up_y, float_time)
	# desce
	tw.tween_property(floatingObject, "position:y", down_y, float_time)
