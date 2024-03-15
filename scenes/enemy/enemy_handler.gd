class_name EnemyHandler
extends Node2D

func _ready() -> void:
	Events.enemy_action_completed.connect(_on_enemy_action_completed)
	
func reset_enemy_actions() -> void:
	var enemy:Combatant_AI
	for child in get_children():
		enemy = child as Combatant_AI
		enemy.current_action = null
		enemy.update_action()

func start_turn() -> void:
	if get_child_count() == 0:
		return
	
	var first_enemy: Combatant_AI = get_child(0) as Combatant_AI
	first_enemy.do_turn()

func _on_enemy_action_completed(enemy: Combatant_AI) -> void:
	if enemy.get_index() == get_child_count() - 1:
		Events.enemy_turn_ended.emit()
		return
	var next_enemy: Combatant_AI = get_child(enemy.get_index() + 1) as Combatant_AI
	next_enemy.do_turn()
