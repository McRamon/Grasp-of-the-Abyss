extends Node

var active_float_tweens = {}

func wiggle_once(target: Node2D) -> void:
	var wiggle_duration: float = 0.2
	var wiggle_strength: float = 5.0 

	var original_position = target.position
	var original_scale = target.scale
	
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(target, "position", original_position + Vector2(randf_range(-wiggle_strength, wiggle_strength), randf_range(-wiggle_strength, wiggle_strength)), wiggle_duration / 4)
	tween.parallel().tween_property(target, "scale", original_scale * 1.1, wiggle_duration / 4)
	tween.tween_property(target, "position", original_position, wiggle_duration / 4)
	tween.parallel().tween_property(target, "scale", original_scale, wiggle_duration / 4)
	tween.tween_property(target, "position", original_position + Vector2(randf_range(-wiggle_strength, wiggle_strength), randf_range(-wiggle_strength, wiggle_strength)), wiggle_duration / 4)
	tween.parallel().tween_property(target, "scale", original_scale * 0.9, wiggle_duration / 4)
	tween.tween_property(target, "position", original_position, wiggle_duration / 4)
	tween.parallel().tween_property(target, "scale", original_scale, wiggle_duration / 4)
	
func grow_pulse(target: Node2D, duration: float, size: float) -> void:
	var original_scale = target.scale
	
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(target, "scale", original_scale * size, duration/2)
	tween.tween_property(target, "scale", original_scale, duration)
	
	
func rotate(target:Node2D, duration: float) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(target, "rotation_degrees", 360, duration)
	tween.tween_callback(func(): target.rotation_degrees = 0)
	
func float(target:Node2D):
	if active_float_tweens.has(target):
		active_float_tweens[target].kill()
		
	var original_position = target.position
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).set_loops()
	active_float_tweens[target] = tween
	
	tween.tween_property(target, "position:y", original_position.y+1, 0.5)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(target, "position:y", original_position.y-1, 1)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(target, "position:y", original_position.y, 0.5)
	
	target.tree_exiting.connect(
		func():
			if active_float_tweens.has(target):
				active_float_tweens[target].kill()
				active_float_tweens.erase(target)
	)
	
func bumb(target:Node2D, direction:Node2D):
	var original_position = target.position
	var halfway_point = original_position.lerp(direction.position, 0.5)
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property(target, "position", halfway_point, 0.1)
	tween.tween_property(target, "position", target.position, 0.1)
	
	
