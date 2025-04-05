extends HSlider

func _ready() -> void:
	value = db_to_slider(AudioManager.global_sound_volume)
	value_changed.connect(_on_value_changed)
	
func db_to_slider(db_value: float) -> float:
	return remap(db_value, -40.0, 10.0, 0.0, 100.0)
	
	
func _on_value_changed(value: float):
	AudioManager.set_global_sound_volume(value)
