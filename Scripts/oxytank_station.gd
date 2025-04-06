extends OxyHolder

var second_counter:float = 0
@export var seconds_to_deplete = 10


@export var connected_console: Node2D
@onready var arrow = $arrow_ui

func _ready():
	super._ready()
	has_tank = true
	tank_fill = 5

func _process(delta):
	super._process(delta)
	if connected_console.powered == true:
		if has_tank:
			second_counter += delta
			if second_counter >= seconds_to_deplete:
				second_counter -= seconds_to_deplete
				tank_fill -= 1
				tank_fill = max (tank_fill, 0)
			
			
