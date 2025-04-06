extends Sprite2D

var pressure_level
var oxygen_level
var power_level



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$console2_alarm.visible = false
	$lamp.color = Color("#ffaa5e")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_levels()
	if get_parent().pressure_counter >= 4 or get_parent().oxygen_counter >= 4 or get_parent().power_counter >= 4:
		$console2_alarm.visible = true
		$lamp.color = Color.RED
	else:
		$console2_alarm.visible = false
		$lamp.color = Color("#ffaa5e")
	
	
func update_levels():
	pressure_level = get_parent().pressure_counter
	oxygen_level = get_parent().oxygen_counter
	power_level = get_parent().power_counter
	if pressure_level == 0:
		$pressure1.visible = true
		$pressure1.color = Color("#ffaa5e")
		$pressure2.visible = true
		$pressure2.color = Color("#ffaa5e")
		$pressure3.visible = true
		$pressure4.visible = true
		$pressure5.visible = true
	if pressure_level == 1:
		$pressure1.visible = true
		$pressure1.color = Color("#ffaa5e")
		$pressure2.visible = true
		$pressure2.color = Color("#ffaa5e")
		$pressure3.visible = true
		$pressure4.visible = true
		$pressure5.visible = false
	if pressure_level == 2:
		$pressure1.visible = true
		$pressure1.color = Color("#ffaa5e")
		$pressure2.visible = true
		$pressure2.color = Color("#ffaa5e")
		$pressure3.visible = true
		$pressure4.visible = false
		$pressure5.visible = false
	if pressure_level == 3:
		$pressure1.visible = true
		$pressure1.color = Color.RED
		$pressure2.visible = true
		$pressure2.color = Color.RED
		$pressure3.visible = false
		$pressure4.visible = false
		$pressure5.visible = false
	if pressure_level == 4:
		$pressure1.visible = true
		$pressure1.color = Color.RED
		$pressure2.visible = false
		$pressure3.visible = false
		$pressure4.visible = false
		$pressure5.visible = false
	if pressure_level == 5:
		$pressure1.visible = false
		$pressure2.visible = false
		$pressure3.visible = false
		$pressure4.visible = false
		$pressure5.visible = false
		
	if power_level == 0:
		$power1.visible = true
		$power1.color = Color("#ffaa5e")
		$power2.visible = true
		$power2.color = Color("#ffaa5e")
		$power3.visible = true
		$power4.visible = true
		$power5.visible = true
	if power_level == 1:
		$power1.visible = true
		$power1.color = Color("#ffaa5e")
		$power2.visible = true
		$power2.color = Color("#ffaa5e")
		$power3.visible = true
		$power4.visible = true
		$power5.visible = false
	if power_level == 2:
		$power1.visible = true
		$power1.color = Color("#ffaa5e")
		$power2.visible = true
		$power2.color = Color("#ffaa5e")
		$power3.visible = true
		$power4.visible = false
		$power5.visible = false
	if power_level == 3:
		$power1.visible = true
		$power1.color = Color.RED
		$power2.visible = true
		$power2.color = Color.RED
		$power3.visible = false
		$power4.visible = false
		$power5.visible = false
	if power_level == 4:
		$power1.visible = true
		$power1.color = Color.RED
		$power2.visible = false
		$power3.visible = false
		$power4.visible = false
		$power5.visible = false
	if power_level == 5:
		$power1.visible = false
		$power2.visible = false
		$power3.visible = false
		$power4.visible = false
		$power5.visible = false

	if oxygen_level == 0:
		$oxygen1.visible = true
		$oxygen1.color = Color("#ffaa5e")
		$oxygen2.visible = true
		$oxygen2.color = Color("#ffaa5e")
		$oxygen3.visible = true
		$oxygen4.visible = true
		$oxygen5.visible = true
	if oxygen_level == 1:
		$oxygen1.visible = true
		$oxygen1.color = Color("#ffaa5e")
		$oxygen2.visible = true
		$oxygen2.color = Color("#ffaa5e")
		$oxygen3.visible = true
		$oxygen4.visible = true
		$oxygen5.visible = false
	if oxygen_level == 2:
		$oxygen1.visible = true
		$oxygen1.color = Color("#ffaa5e")
		$oxygen2.visible = true
		$oxygen2.color = Color("#ffaa5e")
		$oxygen3.visible = true
		$oxygen4.visible = false
		$oxygen5.visible = false
	if oxygen_level == 3:
		$oxygen1.visible = true
		$oxygen1.color = Color.RED
		$oxygen2.visible = true
		$oxygen2.color = Color.RED
		$oxygen3.visible = false
		$oxygen4.visible = false
		$oxygen5.visible = false
	if oxygen_level == 4:
		$oxygen1.visible = true
		$oxygen1.color = Color.RED
		$oxygen2.visible = false
		$oxygen3.visible = false
		$oxygen4.visible = false
		$oxygen5.visible = false
	if oxygen_level == 5:
		$oxygen1.visible = false
		$oxygen2.visible = false
		$oxygen3.visible = false
		$oxygen4.visible = false
		$oxygen5.visible = false
