class_name TargetEffect
extends Resource

signal target_effect_updated(value: int)
signal at_default_value

@export var name : String
@export var icon : Texture

@export var default_value : int = 0
@export var max_value: int = 999
@export var min_value: int = -999

@export var turn_flat_reduction: int = 0
@export var turn_multiplier: float = 0.0

var current_value := default_value : set = _set_current_value

func _on_turn_end() -> void:
	current_value = floori((current_value - turn_flat_reduction) * turn_multiplier)

func _set_current_value(value: int) -> void:
	current_value = clampi(value, min_value, max_value)
	target_effect_updated.emit()
	if current_value == default_value:
		at_default_value.emit()

func apply() -> void:
	pass
