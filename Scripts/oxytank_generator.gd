extends OxyHolder

var second_counter:float = 0
@export var seconds_to_recharge = 1


@export var connected_console: Node2D

@onready var arrow = $arrow_ui

func _ready():
	super._ready()
	arrow.visible = false

func _process(delta):
	super._process(delta)
	if connected_console.powered == true:
		if has_tank:
			second_counter += delta
			if second_counter >= seconds_to_recharge:
				second_counter -= seconds_to_recharge
				tank_fill += 1
		
				
			
	
	
