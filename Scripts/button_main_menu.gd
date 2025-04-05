extends Button


var base_scale := Vector2.ONE
var tween: Tween

var scene_to_load: PackedScene = load("res://Scenes/menu_manager.tscn")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	mouse_filter = MOUSE_FILTER_STOP

func _on_mouse_entered():
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE).bind_node(self)
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.2)
	
func _on_mouse_exited():
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).bind_node(self)
	tween.tween_property(self, "scale", Vector2.ONE, 0.2)
	
func _on_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(scene_to_load)
