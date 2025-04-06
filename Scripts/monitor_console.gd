extends Node2D

@export var connected_hologram: Node2D
@export var connected_idle_monitor: Node2D
@export var connected_informative_monitor: Node2D


var active:bool = true

func _ready():
	connected_hologram.visible = false
	
	$player_detection_area.area_entered.connect(_on_player_entered)
	$player_detection_area.area_exited.connect(_on_player_exited)	
	
	connected_idle_monitor.play("idle")
	
	
	
func _on_player_entered():
	if active:
		connected_hologram.visible = true
		print("player entered monitor area")
		
		
func _on_player_exited():
	connected_hologram.visible = false
	print("player exited monitor area")
			
			
	
	
