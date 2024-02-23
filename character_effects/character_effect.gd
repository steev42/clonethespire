class_name CharacterEffect
extends Resource

@export var name : String
@export var icon : Texture

@export var default_value : int = 0
@export var max_value: int = 999
@export var min_value: int = -999

@export var turn_flat_reduction: int = 0
@export var turn_multiplier: float = 0.0

var current_value := default_value : set = _set_current_value

func _on_turn_end() -> void:
	current_value = floori(current_value * turn_multiplier) - turn_flat_reduction


func _set_current_value(value: int) -> void:
	current_value = clampi(value, min_value, max_value)


func apply() -> void:
	pass
