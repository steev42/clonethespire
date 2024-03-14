class_name CampfireHealEffect
extends CampfireEffect

var percentage := 0.3

func execute(character_stats : Stats_Player) -> void:
	print ("Character Health at Start: %s"%[character_stats.health])
	var amount = character_stats.max_health * percentage
	character_stats.heal(amount)
	SFXPlayer.play(sound)
	print ("Character Health at End: %s"%[character_stats.health])
	
