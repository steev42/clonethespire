class_name Combatant_Player
extends Combatant

func _ready() -> void:
	target_type = TargetType.PLAYER


func check_for_death() -> void:
	if stats.health <= 0:
		Events.player_died.emit()
		queue_free()
