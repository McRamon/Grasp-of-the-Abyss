extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("idle")
	$alarm_console_alarm.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().pressure_counter >= 4 or get_parent().oxygen_counter >= 4 or get_parent().power_counter >= 4:
		play("off")
		$alarm_console_alarm.visible = true
	else:
		play("idle")
		$alarm_console_alarm.visible = false
	
