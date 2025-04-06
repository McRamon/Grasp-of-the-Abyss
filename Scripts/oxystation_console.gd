extends Node2D

var tank_fill:int = 0
var powered:bool = true
@export var connected_junkbox: Node2D
@export var connected_oxystation: Node2D

var second_counter:float = 0

var working:bool

func _ready():
	update_indicators()
	
	
func _process(delta):
	update_indicators()
	
	if !connected_oxystation:
		return
	
	tank_fill = connected_oxystation.tank_fill if connected_oxystation.has_tank else 0
	
	working = powered and (tank_fill > 0)
		
	if !working:
		second_counter += delta
		#each  5 seconds increases the oxyloss counter if active
		if second_counter >= 5.0:
			get_parent().oxygen_counter += 1
			print("oxygen counter = ", get_parent().oxygen_counter)
			second_counter -= 5.0
	else:
		get_parent().oxygen_counter = 0


func update_indicators():
	if !connected_junkbox.active:
		powered = true
		if connected_oxystation.has_tank:
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
