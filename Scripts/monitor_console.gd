extends Node2D

@export var connected_hologram: Node2D
@export var connected_idle_monitor: Node2D
@export var connected_informative_monitor: Node2D

@export var connected_junkbox: EventNode

var active:bool = true

func _ready():
	connected_hologram.visible = false
	
	$player_detection_area.area_entered.connect(_on_player_entered)
	$player_detection_area.area_exited.connect(_on_player_exited)	
	
	
	
func _on_player_entered():
	if active:
		connected_hologram.visible = true
		
		
func _on_player_exited():
	connected_hologram.visible = false
			
			
	
	
