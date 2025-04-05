extends Node2D

var pause_menu = preload("res://Scenes/pause_menu.tscn")
var pause_menu_instance = null
var is_paused = false

var sounds = {
	"ambient" : preload("res://Assets/Sounds/ambient.ogg"),
	"alarm" : preload("res://Assets/Sounds/alarm.ogg")
}

var ambience_active:bool = false
var sound_loop_ambience:bool = false
var sound_loop_alarm:bool = false

@export var time_until_event: int
var event_timer: int = 0

#game over conditions. Different event_nodes raise the counter.
var pressure_counter:int = 0
var pressure_gameover:int = 5

var oxygen_counter:int = 0
var oxygen_gameover:int = 5

var power_counter:int = 0
var power_gameover:int = 5

var alarm_active:bool = false
var alarm_playing:bool = false

func _ready():
	$ambient.finished.connect(sound_loop_func)
	$alarm.finished.connect(sound_loop_func)
	$player_character.player_moved.connect(_on_player_moved)
	
func _process(delta):
	var second_counter = 0
	second_counter += delta
	if second_counter >= 1.0:
		event_timer += 1
		second_counter -= 1.0
		
		
	if event_timer >= time_until_event:
		event_timer = 0
		random_event()
		
	#ambience code, loops via func sound_loop_func().
	if !ambience_active:
		$ambient.stream = sounds["ambient"]
		$ambient.pitch_scale = 0.2
		$ambient.volume_db = AudioManager.global_sound_volume/2
		$ambient.play()
		ambience_active = true
		print("ambient playing")
		sound_loop_ambience = true
		
	if pressure_counter >= 4 or oxygen_counter >= 4 or power_counter >= 4:
		alarm_active = true
	else:
		alarm_active = false	
	
	if alarm_active:
		if !alarm_playing:
			$alarm.stream = sounds["alarm"]
			$alarm.volume_db = AudioManager.global_sound_volume
			$alarm.play()
			alarm_playing = true
			print("alarm is playing")
			sound_loop_alarm = true
	
func sound_loop_func():
	if sound_loop_ambience:
		$ambient.play()
	if sound_loop_alarm:
		$alarm.play()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().root.set_input_as_handled()
		toggle_pause()
		
func toggle_pause():
	
	if is_paused == false:
		is_paused = true
		get_tree().paused = is_paused
		pause_menu_instance = pause_menu.instantiate()
		pause_menu_instance.process_mode = PROCESS_MODE_ALWAYS
		add_child(pause_menu_instance)
		pause_menu_instance.get_node("Resume").pressed.connect(toggle_pause)
	else:
		unpause()
			
			
func unpause():
	if pause_menu_instance:
		get_tree().paused = false
		pause_menu_instance.queue_free()
		pause_menu_instance = null
	is_paused = false
	
func _on_player_moved():
	event_timer += 1
	
func random_event():
	var event_nodes = get_tree().get_nodes_in_group("event_nodes")
	for node in event_nodes:
		if node.active:
			event_nodes.erase(node)
		if node.unavailable:
			event_nodes.erase(node)
	var event_node = event_nodes.pick_random()
	event_node.activate()
	
func ambience_for_cutscene():
	AudioServer.set_bus_effect_enabled(1, 0, true)
