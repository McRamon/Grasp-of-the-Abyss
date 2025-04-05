extends Node

var global_sound_volume: float = 0.0



func set_global_sound_volume(new_volume: float):
	global_sound_volume = remap(new_volume, 0.0, 100.0, -40.0, 10.0)

#var sound_volume: float = 0.8 :
	#set(value):
		#sound_volume = clamp(value, 0.0, 1.0)
		#AudioServer.set_bus_volume_db(0, linear2db(sound_volume))
		#
#var sound_effect := {}
#
#func _ready():
	#AudioServer.set_bus_count(1)
	#AudioServer.set_bus_name(0, "SFX")
	#set_sound_volume(sound_volume)
	#
#func preload_sounds(sound_dict: Dictionary) -> void:
	#for key in sound_dict:
		#var sound_path = sound_dict[key]
		#if ResourceLoader.exists(sound_path):
			#sound_effects[key] = load(sound_path)
	
	
