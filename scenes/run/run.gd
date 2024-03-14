class_name Run
extends Node

const BATTLE_SCENE = preload("res://scenes/battle/battle.tscn")
const BATTLE_REWARDS_SCENE = preload("res://scenes/battle_rewards/battle_rewards.tscn")
const CAMPFIRE_SCENE = preload("res://scenes/camp/campfire.tscn")
const SHOP_SCENE = preload("res://scenes/shop/shop.tscn")
const TREASURE_ROOM_SCENE = preload("res://scenes/treasure_room/treasure_room.tscn")
const MAP_SCENE = preload("res://scenes/map/map.tscn")

@export var run_startup: RunStartup

@onready var current_view: Node = $CurrentView
@onready var map_button: Button = %MapButton
@onready var battle_button: Button = %BattleButton
@onready var rewards_button: Button = %RewardsButton
@onready var shop_button: Button = %ShopButton
@onready var treasure_button: Button = %TreasureButton
@onready var campfire_button: Button = %CampfireButton
@onready var run_character: TextureRect = %RunCharacter
@onready var deck_button: CardPileOpener = %DeckButton
@onready var deck_view: CardPileView = %DeckView
@onready var gold_ui: GoldUI = %GoldUI

var character: Stats_Player
var stats : RunStats

func _ready() -> void:
	if not run_startup:
		return
	
	match run_startup.type:
		RunStartup.Type.NEW_RUN:
			character = run_startup.picked_character.create_instance()
			run_character.texture = character.portrait
			_start_run()
		RunStartup.Type.CONTINUED_RUN:
			print ("TODO: load previous run")


func _start_run() -> void:
	stats = RunStats.new()
	_setup_event_connections()
	_setup_top_bar()
	print("TODO: procedurally generate map")


func _change_view(scene: PackedScene) -> Node:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view)
	
	return new_view


func _setup_event_connections() -> void:
	Events.battle_won.connect(_on_battle_won)
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_on_map_exited)
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.treasure_room_exited.connect(_change_view.bind(MAP_SCENE))
	
	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	rewards_button.pressed.connect(_change_view.bind(BATTLE_REWARDS_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	treasure_button.pressed.connect(_on_treasure_room_entered)


func _setup_top_bar() -> void:
	gold_ui.run_stats = stats
	deck_button.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_button.pressed.connect(deck_view.show_current_view.bind("Deck"))


func _on_map_exited() -> void:
	print ("TODO: From the map, change view based on room type")


func _on_battle_won() -> void:
	var reward_scene := _change_view(BATTLE_REWARDS_SCENE) as BattleReward
	reward_scene.reward_gui.run_stats = stats
	reward_scene.reward_gui.character_stats = character
	
	# TEMP TESTING CODE
	reward_scene.reward_gui.add_gold_reward(77)
	reward_scene.reward_gui.add_card_reward()


func _on_treasure_room_entered() -> void:
	var treasure_scene := _change_view(TREASURE_ROOM_SCENE) as TreasureUI
	treasure_scene.reward_gui.run_stats = stats
	treasure_scene.reward_gui.character_stats = character
	
	#TEMP TESTING CODE
	treasure_scene.reward_gui.add_gold_reward(28)
	treasure_scene.reward_gui.add_card_reward()


func _on_campfire_room_entered() -> void:
	var campfire_scene := _change_view(CAMPFIRE_SCENE) as CampfireUI
	campfire_scene.run_stats = stats
	campfire_scene.character_stats = character
