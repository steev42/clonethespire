class_name CampfireOptionUI
extends VBoxContainer

signal campfire_event_completed

@onready var label: Label = %Label
@onready var button: Button = %Button
@onready var button_image: TextureRect = %ButtonImage


@export var effect : CampfireEffect
@export var character_stats : Stats_Player

func _ready() -> void:
	label.text = effect.name
	button_image.texture = effect.image


func _on_button_pressed() -> void:
	effect.execute(character_stats)
	campfire_event_completed.emit(self)
