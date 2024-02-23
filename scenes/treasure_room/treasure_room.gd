class_name TreasureUI
extends Control

@onready var open_chest: Button = %OpenChest
@onready var reward_gui: RewardUI = %RewardGui

func _ready() -> void:
	reward_gui.label.text = "TREASURE"


func _on_open_chest_pressed() -> void:
	open_chest.hide()
	reward_gui.show()


func _on_reward_gui_reward_claim_complete() -> void:
	Events.treasure_room_exited.emit()

