extends Node2D

class_name OxyHolder


var has_tank: bool = false

var player_in_range: bool = false
var active_player:Node2D
var tank_fill:int = 0

var sounds = {
	"take" : preload("res://Assets/Sounds/tank_take.ogg"),
	"put" : preload("res://Assets/Sounds/tank_put.ogg")
}

@onready var audio_system = $AudioStreamPlayer2D

func _ready():
	
	$Area2D.area_entered.connect(_on_player_entered)
	$Area2D.area_exited.connect(_on_player_exited)
	
func _process(delta):
	if has_tank:
		update_tank_fill()
		if $tank_sprite:
			$tank_sprite.visible = true
	else:
		if $tank_sprite:
			$tank_sprite.visible = false
	
	
func _on_pipe_activation():
	$e_ui.visible = true
	
func _on_player_entered(player: Area2D):
	player_in_range = true
	print("player entered area")
	active_player = player
	
func _on_player_exited(player: Area2D):
	player_in_range = false
	print("player left area")
	active_player = null
	
func _input(event):
	if has_tank:
		if (active_player and event.is_action_pressed("interact")):
			active_player.take_tank()
			print("player took oxytank")
			audio_system.stream = sounds["take"]
			audio_system.pitch_scale = randf_range(0.8, 1.2)
			audio_system.volume_db = AudioManager.global_sound_volume
			audio_system.play()
			has_tank = false
			active_player.tank_fill = tank_fill
		
	
	else:
		if (active_player and event.is_action_pressed("interact")):
			if active_player.has_tank:
				active_player.remove_tank()
				print ("player placed oxytank")
				audio_system.stream = sounds["put"]
				audio_system.pitch_scale = randf_range(0.8, 1.2)
				audio_system.volume_db = AudioManager.global_sound_volume
				audio_system.play()
				has_tank = true
				tank_fill = active_player.tank_fill
				
func update_tank_fill():
	if !has_tank:
		tank_fill = 0
	else:
		tank_fill = min(tank_fill, 5)
		
		
