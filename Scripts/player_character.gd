extends Area2D

var tile_size = 16
var animation_speed = 3
var moving = false

var move_direction = {}

signal player_moved

@export var held_tank:Sprite2D
var has_tank: bool = false
var tank_fill:int

var sounds = {
	"jump" : preload("res://Assets/Sounds/step.wav"),
	"step" : preload("res://Assets/Sounds/step.ogg")
}

var inputs = {"right": Vector2.RIGHT,
				"left": Vector2.LEFT,
				"up": Vector2.UP,
				"down": Vector2.DOWN}
				
@onready var ray = $RayCast2D

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	held_tank.visible = false
	
func _process(delta):
	if !moving and move_direction.size() > 0:
		var next_dir = move_direction.keys()[0]
		move(next_dir)
		
	
func _unhandled_input(event):

	
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move_direction[dir] = true
			if !moving:
				move(dir)
		elif event.is_action_released(dir):
			move_direction.erase(dir)
			
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		if dir == "left":
			$Sprite2D.flip_h = true
		if dir == "right":
			$Sprite2D.flip_h = false
		
		Animations.wiggle_once(self)
		$AudioStreamPlayer2D.stream = sounds["step"]
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.8, 2.0)
		$AudioStreamPlayer2D.volume_db = AudioManager.global_sound_volume/2
		$AudioStreamPlayer2D.play()
		var tween = create_tween()
		tween.tween_property(self, "position", 
			position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		emit_signal("player_moved")
		moving = false
		
func remove_tank():
	has_tank = false
	held_tank.visible = false
	
func take_tank():
	has_tank = true
	held_tank.visible = true
