class_name BattleReward
extends Control

@onready var reward_gui: RewardUI = %RewardGui


func _on_reward_gui_reward_claim_complete() -> void:
	Events.battle_reward_exited.emit()
