extends Node2D

var tank_fill:int = 0
var powered:bool = true
@export var connected_junkbox: Node2D
@export var connected_oxygen: Node2D


func _ready():
	update_indicators()
	
	
func _process(delta):
	update_indicators()
	if connected_oxygen.has_tank:
		tank_fill = connected_oxygen.tank_fill


func update_indicators():
	if !connected_junkbox.active:
		powered = true
		if connected_oxygen.has_tank:
			if tank_fill == 0:
				$filler1.visible = false
				$filler2.visible = false
				$filler3.visible = false
				$filler4.visible = false
				$filler5.visible = false
			if tank_fill == 1:
				$filler1.visible = true
				$filler2.visible = false
				$filler3.visible = false
				$filler4.visible = false
				$filler5.visible = false
			if tank_fill == 2:
				$filler1.visible = true
				$filler2.visible = true
				$filler3.visible = false
				$filler4.visible = false
				$filler5.visible = false
			if tank_fill == 3:
				$filler1.visible = true
				$filler2.visible = true
				$filler3.visible = true
				$filler4.visible = false
				$filler5.visible = false
			if tank_fill == 4:
				$filler1.visible = true
				$filler2.visible = true
				$filler3.visible = true
				$filler4.visible = true
				$filler5.visible = false	
			if tank_fill == 5:
				$filler1.visible = true
				$filler2.visible = true
				$filler3.visible = true
				$filler4.visible = true
				$filler5.visible = true
		else:
			$filler1.visible = false
			$filler2.visible = false
			$filler3.visible = false
			$filler4.visible = false
			$filler5.visible = false
			
			
		$lamp_red.visible = false
		
	if connected_junkbox.active:
		powered = false
		$filler1.visible = false
		$filler2.visible = false
		$filler3.visible = false
		$filler4.visible = false
		$filler5.visible = false
		$lamp_red.visible = true

		
