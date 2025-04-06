extends EventNode

var sounds = {
	"sparks" : preload("res://Assets/Sounds/sparks.ogg")
}

var sound_loop:bool = false
signal fixed

var second_counter = 0
@onready var player_detection_area: Area2D = $junkbox_player_detector

var player_in_range:bool = false
var active_player: Area2D

func _ready():
	$AudioStreamPlayer2D.finished.connect(sound_loop_func)
	active = false
	$GPUParticles2D.emitting = false
	$Sprite2D.visible = false
	$e_ui.visible = false
	
	player_detection_area.area_entered.connect(_on_player_entered)
	player_detection_area.area_exited.connect(_on_player_exited)

func _process(delta):
	if active:
		$GPUParticles2D.emitting = true
		$Sprite2D.visible = true
		$e_ui.visible = true
		
		second_counter += delta
		#each  5 seconds increases the power counter if active, allegedly
		if second_counter >= 5.0:
			get_parent().power_counter += 1
			print("power counter = ", get_parent().power_counter)
			second_counter -= 5.0
	else:
		$GPUParticles2D.emitting = false
		$Sprite2D.visible = false
		$e_ui.visible = false
			
			
func activate():
	super.activate()
	sound_loop = true
	$AudioStreamPlayer2D.stream = sounds["sparks"]
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.5, 0.8)
	$AudioStreamPlayer2D.volume_db = AudioManager.global_sound_volume
	$AudioStreamPlayer2D.play()
	
	
	
func sound_loop_func():
	if sound_loop:
		$AudioStreamPlayer2D.play()
		
		
func deactivate():
	super.deactivate()
	$AudioStreamPlayer2D.stop()
	sound_loop = false
	$GPUParticles2D.emitting = false
	$e_ui.visible = false
	get_parent().power_counter -= 2
	if get_parent().power_counter <0:
		get_parent().power_counter = 0
	print("power counter = ", get_parent().power_counter)
			
			
func _input(event):
	if active:
		if (active_player and event.is_action_pressed("interact")):
			emit_signal("fixed")
			deactivate()
			print("junkction box  fixed")
			get_parent().power_counter -= 2
			if get_parent().power_counter < 0:
				get_parent().power_counter = 0
			print("power counter = ", get_parent().power_counter)
	
			
			
func _on_player_entered(player: Area2D):
	player_in_range = true
	print("player entered area")
	active_player = player
	
func _on_player_exited(player: Area2D):
	player_in_range = false
	print("player left area")
	active_player = null
