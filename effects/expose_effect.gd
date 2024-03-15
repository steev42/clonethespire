class_name ExposeEffect
extends Effect

var amount := 0
const EXPOSED = preload("res://character_effects/exposed.tres")

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Combatant:			
			target.add_character_effect(EXPOSED.duplicate(),amount)
			pass
