class_name TargetEffectUI
extends TextureRect

@export var effect : TargetEffect : set = set_effect
@onready var counter: Label = %Counter

func set_effect(new_value: TargetEffect) -> void:
	if not is_node_ready():
		await ready
	effect = new_value
	texture = effect.icon
	
	if not effect.target_effect_updated.is_connected(_on_target_effect_updated):
		effect.target_effect_updated.connect(_on_target_effect_updated)
		_on_target_effect_updated()


func _on_target_effect_updated() -> void:
	if not is_node_ready():
		await ready
	if effect.current_value == effect.default_value:
		queue_free()
		return
	if counter:
		counter.text = str(effect.current_value)
