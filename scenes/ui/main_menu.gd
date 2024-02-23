extends Control

const CHAR_SELECT_SCREEN := preload("res://scenes/ui/character_selector.tscn")

@onready var continue_button: Button = %Continue

func _ready() -> void:
	get_tree().paused = false


func _on_continue_pressed() -> void:
	print ("continue run")


func _on_new_run_pressed() -> void:
	get_tree().change_scene_to_packed(CHAR_SELECT_SCREEN)


func _on_quit_pressed() -> void:
	get_tree().quit()
