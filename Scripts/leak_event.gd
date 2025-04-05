extends EventNode

class_name LeakEvent

@export var connected_valve: Node2D

var second_counter = 0

var sounds = {
	"steam" : preload("res://Assets/Sounds/steam.ogg")
}

var sound_loop:bool = false

func _ready():
	$AudioStreamPlayer2D.finished.connect(sound_loop_func)
	active = false
	$GPUParticles2D.emitting = false
	if connected_valve:
		connected_valve.turned.connect(deactivate)

func _process(delta):
	if active:
		$GPUParticles2D.emitting = true
		
		second_counter += delta
		#each  5 seconds increases the pressure counter if active
		if second_counter >= 5.0:
			get_parent().pressure_counter += 1
			print("pressure counter = ", get_parent().pressure_counter)
			second_counter -= 5.0
	else:
		$GPUParticles2D.emitting = false
			
			
func activate():
	super.activate()
	sound_loop = true
	$AudioStreamPlayer2D.stream = sounds["steam"]
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
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
	get_parent().pressure_counter -= 2
	if get_parent().pressure_counter < 0:
		get_parent().pressure_counter = 0
	print("pressure counter = ", get_parent().pressure_counter)
	
	

		
		


	
	
