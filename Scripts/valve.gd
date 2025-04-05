extends Node2D

signal turned

@export var connected_pipe: EventNode
var player_in_range: bool = false

var active_player: Area2D = null



func _ready():
	if connected_pipe:
		connected_pipe.activated.connect(_on_pipe_activation)
	$e_ui.visible = false
	
	$player_detection_area.area_entered.connect(_on_player_entered)
	$player_detection_area.area_exited.connect(_on_player_exited)
	
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
	if (player_in_range and event.is_action_pressed("interact")):
		if connected_pipe.active:
			Animations.rotate($Sprite2D, 1)
			emit_signal("turned")
			$e_ui.visible = false
			print("valve turned")
			Animations.bumb(active_player, self)
		
	
	
