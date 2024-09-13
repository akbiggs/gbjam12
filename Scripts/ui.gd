extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = get_viewport().canvas_transform.get_origin()

func _process(delta: float) -> void:
	global_position = Vector2(-get_viewport().canvas_transform.get_origin().x, -get_viewport().canvas_transform.get_origin().y)	
