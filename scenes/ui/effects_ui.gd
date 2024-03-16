class_name EffectsUI
extends HBoxContainer

func add_effect(effect: TargetEffect) -> void:
	var effect_icon = TargetEffectUI.new()
	effect_icon.effect = effect
	effect_icon.effect.at_default_value. \
		connect(remove_effect).bind(effect_icon)
	add_child(effect_icon)


func remove_effect(effect: TargetEffect) -> void:
	for child : TargetEffectUI in get_children():
		if child.effect.name == effect.name:
			child.queue_free()


