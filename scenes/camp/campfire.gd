class_name CampfireUI
extends Control

@export var run_stats : RunStats
@export var character_stats: Stats_Player

@onready var campfire_options: GridContainer = %CampfireOptions

const CAMPFIRE_OPTION_UI = preload("res://scenes/ui/campfire_option_ui.tscn")

var uses = {}
var actions := 0

func _ready() -> void:
	uses.clear()
	for opt in campfire_options.get_children():
		opt.queue_free()
	for option in run_stats.campfire_options:
		if not option:
			continue
		var child = CAMPFIRE_OPTION_UI.instantiate()
		child.effect = option
		child.character_stats = character_stats
		child.campfire_event_completed.connect(_on_campfire_event_completed)
		campfire_options.add_child(child)
		


func _on_button_pressed() -> void:
	Events.campfire_exited.emit()


func _on_campfire_event_completed(option_button: CampfireOptionUI) -> void:
	if not uses.has(option_button):
		uses[option_button] = 1
	else:
		uses[option_button] += 1
	if uses[option_button] >= option_button.effect.max_uses_per_rest:
		option_button.button.disabled = true
		option_button.button_image.modulate = Color.GRAY
	actions += 1
	if actions >= run_stats.campfire_selections:
		print ("Done with campfire, figure out how to exit here")
