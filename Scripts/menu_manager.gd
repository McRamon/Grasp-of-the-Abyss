extends Node2D

var main_menu = preload("res://Scenes/main_menu.tscn")
var settings_menu = preload("res://Scenes/settings_menu.tscn")

var active_main_menu
var active_settings_menu

var is_menu: bool = true


func _ready() -> void:
	active_main_menu = main_menu.instantiate()
	active_settings_menu = settings_menu.instantiate()
	add_child(active_main_menu)
	add_child(active_settings_menu)

	active_settings_menu.hide()

func switch_scenes():
	if is_menu:
		switch_to_settings()
	else:
		switch_to_menu()
		

func switch_to_menu():
	active_settings_menu.hide()
	active_main_menu.show()
	is_menu = true
	
func switch_to_settings():
	active_settings_menu.show()
	active_main_menu.hide()
	is_menu = false
