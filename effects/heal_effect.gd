class_name HealEffect
extends Effect

var amount := 0

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Combatant:
			target.heal(amount)
			SFXPlayer.play(sound)
