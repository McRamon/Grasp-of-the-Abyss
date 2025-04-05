extends Node2D

class_name EventNode

signal activated
signal deactivated

var active:bool = false

#time until node can be picked for event again
@export var grace_period: float = 10
var unavailable = false


func activate():
	active = true
	emit_signal("activated")
	print(self.name, "activated")
	
	
func deactivate():
	active = false
	unavailable = true
	emit_signal("deactivated")
	print(self.name, "deactivated")
	get_tree().create_timer(grace_period).timeout.connect(\
		func():
			unavailable = false
			print(self.name, " can be selected for event again"))
	
	
