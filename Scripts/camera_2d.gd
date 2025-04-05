extends Camera2D
@export var target_node: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	if target_node:
		set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target = get_node(target_node)
	if target:
		global_position = target.global_position
