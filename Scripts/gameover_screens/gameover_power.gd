extends Node2D

var sounds = {
	"ambient" : preload("res://Assets/Sounds/ambient.ogg"),
	"alarm" : preload("res://Assets/Sounds/alarm.ogg")
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
	$sub/syb_dark.visible = true
	$sub/light_main.visible = false
	await get_tree().create_timer(0.2).timeout
	$sub/syb_dark.visible = false
	$sub/light_main.visible = true
	await get_tree().create_timer(1.0).timeout
	$sub/syb_dark.visible = true
	$sub/light_main.visible = false
	await get_tree().create_timer(0.2).timeout
	$sub/syb_dark.visible = false
	$sub/light_main.visible = true
	await get_tree().create_timer(0.2).timeout
	$sub/syb_dark.visible = true
	$sub/light_main.visible = false
	await get_tree().create_timer(0.5).timeout
	$sub/light_red.visible = false
	await get_tree().create_timer(0.2).timeout
	$sub/light_red.visible = true
	await get_tree().create_timer(0.2).timeout
	$sub/light_red.visible = false
	await get_tree().create_timer(0.2).timeout
	$sub/light_red.visible = true	
	await get_tree().create_timer(0.1).timeout
	$sub/light_red.visible = false	
	$ColorRect.visible = true
	await get_tree().create_timer(1.0).timeout
	$signal_lost.visible = true
	await get_tree().create_timer(1.0).timeout
	$power.visible = true
	await get_tree().create_timer(1.0).timeout
	$score.visible = true
	$score/Label.text = str(ScoreCounter.score)
	$score/Label.visible = true
	await get_tree().create_timer(1.0).timeout
	$start_button.visible = true
