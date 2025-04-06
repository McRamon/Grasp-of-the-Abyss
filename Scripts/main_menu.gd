extends Node2D

var sounds = {
	"ambient" : preload("res://Assets/Sounds/ambient.ogg"),
	"alarm" : preload("res://Assets/Sounds/alarm.ogg")
}

var ambience_active:bool = false
var sound_loop_ambience:bool = false

func _ready():
	$ambient.finished.connect(sound_loop_func)
	Animations.float($sub)

func _process(delta: float) -> void:
	
	
	if !ambience_active:
		$ambient.stream = sounds["ambient"]
		$ambient.pitch_scale = 0.2
		$ambient.volume_db = AudioManager.global_sound_volume/2
		$ambient.play()
		ambience_active = true
		print("ambient playing")
		sound_loop_ambience = true
		
func sound_loop_func():
	if sound_loop_ambience:
		$ambient.play()
