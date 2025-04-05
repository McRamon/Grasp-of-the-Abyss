extends Node2D

var active:bool = true

var player_in_range:bool = false

var pressure_counter:int = 0
var oxygen_counter:int = 0
var power_counter:int = 0

var sounds = {
	"alarm" : preload("res://Assets/Sounds/alarm.ogg")
}
var sound_loop:bool = false

func _ready():
	$player_detection_area.area_entered.connect(_on_player_entered)
	$player_detection_area.area_exited.connect(_on_player_exited)
	
	$AudioStreamPlayer2D.finished.connect(sound_loop_func)
	active = false


func _process(delta):
	if get_parent().pressure_counter >= 0 or get_parent().oxygen_counter >= 0 or get_parent().power_counter >= 0:
		active = true
		
	if active:
			$AudioStreamPlayer2D.stream = sounds["alarm"]
			$AudioStreamPlayer2D.volume_db = AudioManager.global_sound_volume
			$AudioStreamPlayer2D.play()
			sound_loop = true

func sound_loop_func():
	if sound_loop:
		$AudioStreamPlayer2D.play()	
		
func _input(event):
	if (player_in_range and event.is_action_pressed("interact")):
		if active:
			#$e_ui.visible = false
			active = false
			sound_loop = false
			$AudioStreamPlayer2D.stop

		
func _on_player_entered(player: Area2D):
	player_in_range = true
	
func _on_player_exited(player: Area2D):
	player_in_range = false
	
