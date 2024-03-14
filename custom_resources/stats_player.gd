class_name Stats_Player
extends Stats

func take_damage(damage: int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if health < initial_health:
		Events.player_damage_taken.emit()
