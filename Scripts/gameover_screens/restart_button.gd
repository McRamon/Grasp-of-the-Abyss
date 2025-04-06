extends Button


var base_scale := Vector2.ONE
var tween: Tween
 
var scene_to_load = preload("res://Scenes/main_game_level.tscn")

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	mouse_filter = MOUSE_FILTER_STOP
	if scene_to_load == null:
		push_error("scene_to_load is null at startup!")

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
	if tween:
		tween.kill()
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_game_level.tscn")
	#var current_scene = get_tree().root.get_child(get_tree().root.get_child_count() -1)
	#if current_scene != null:
		#current_scene.queue_free()
	#var new_scene = scene_to_load.instantiate()
	#get_tree().root.add_child(new_scene)
		
	
	self.modulate = Color(1, 0.5, 0.5)
