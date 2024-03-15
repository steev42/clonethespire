class_name ExposeEffect
extends Effect

var amount := 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Combatant:
			#target.add_character_effect(ExposedCharacterEffect.new(),amount)
			pass
