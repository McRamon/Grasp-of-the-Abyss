extends Node2D

var sounds = {
	"ambient" : preload("res://Assets/Sounds/ambient.ogg"),
	"alarm" : preload("res://Assets/Sounds/alarm.ogg"),
	"psh" : preload("res://Assets/Sounds/pshhh.ogg")
}

var ambience_active:bool = false
var sound_loop_ambience:bool = false

var ambience_bus = AudioServer.get_bus_index("Ambience")

func _ready():
	$ColorRect.visible = false
	var reverb = get_ambience_reverb()
	reverb.wet = 1
	reverb.dry = 0.1
	reverb.room_size = 1.1
	reverb.damping = 0.8
	$ambient.finished.connect(sound_loop_func)
	Animations.float($sub)
	start_event_sequence()


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

func get_ambience_reverb() -> AudioEffectReverb:
	return AudioServer.get_bus_effect(ambience_bus, 1) as AudioEffectReverb
	
func start_event_sequence():
	await get_tree().create_timer(5.0).timeout
	$ColorRect.visible = true
	$AudioStreamPlayer2D.stream = sounds["psh"]
	$AudioStreamPlayer2D.pitch_scale = 1
	$AudioStreamPlayer2D.volume_db = AudioManager.global_sound_volume/2
	$AudioStreamPlayer2D.play()
	sound_loop_ambience = false
	$ambient.stop()
	await get_tree().create_timer(2.0).timeout
	
	var end_color = Color(1, 1, 1, 0)
	$signal_lost.visible = true
	await get_tree().create_timer(1.0).timeout
	$implosion.visible = true
	await get_tree().create_timer(1.0).timeout
	$score.visible = true
	$score/Label.text = str(ScoreCounter.score)
	$score/Label.visible = true
	await get_tree().create_timer(1.0).timeout
	$start_button.visible = true
