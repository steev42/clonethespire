class_name ExposeEffect
extends Effect

var amount := 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Player:
			target.add_character_effect(ExposedCharacterEffect.new(),amount)
