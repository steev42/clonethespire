class_name EffectsUI
extends HBoxContainer

const TARGET_EFFECT_UI = preload("res://scenes/ui/target_effect_ui.tscn")

func add_effect(effect: TargetEffect) -> void:
	var effect_icon = TARGET_EFFECT_UI.instantiate()
	effect_icon.effect = effect
	add_child(effect_icon)


func remove_effect(effect: TargetEffect) -> void:
	for child : TargetEffectUI in get_children():
		if child.effect.name == effect.name:
			child.queue_free()


