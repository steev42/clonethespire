class_name Stats
extends Resource

signal stats_changed
signal effect_updated(effect: TargetEffect)
signal death_check_required

@export_group("Visuals")
@export var character_name: String
@export_multiline var description: String
@export var portrait: Texture

@export_group("Gameplay Data")
@export_subgroup("Health")
@export var max_health := 1
@export var health_regeneration := 0
@export_subgroup("Block") # TODO If block becomes an effect, remove this?
@export var block_max := 999
@export var block_reduction := 1000 
@export_range(0.0,1.0,0.01) var block_multiplier := 0.0
@export_subgroup("Mana")
@export var max_mana := 10
@export var mana_regeneration := 3
@export_subgroup("Hand")
@export var cards_per_turn := 5
@export var max_hand_size := 12
@export_subgroup("Cards")
@export var starting_deck: CardPile
@export var draftable_cards: CardPile # TODO Apply only to player?

var health: int  : set = set_health
var block: int : set = set_block
var mana: int: set = set_mana

var deck: CardPile
var discard: CardPile
var draw_pile: CardPile

#TODO Make block an effect?
var character_effects = {}

func has_target_effect(effect: TargetEffect) -> bool:
	return character_effects.has(effect.name)


func add_target_effect(effect: TargetEffect) -> TargetEffect:
	if has_target_effect(effect):
		character_effects[effect.name].current_value += effect.current_value
	else:
		character_effects[effect.name] = effect
		character_effects[effect.name].current_value = effect.current_value		
	return character_effects[effect.name]


func set_health (value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()
	if health <= 0:
		death_check_required.emit()


func set_block (value : int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()


func set_mana (value: int) -> void:
	mana = clampi(value, 0, max_mana) 
	# TODO: Allow going over maximum with effects that aren't turn-based auto-generation?
	stats_changed.emit()


func regenerate_mana() -> void:
	if mana >= max_mana:
		return
	mana += mana_regeneration


func reduce_block() -> void:
	if block <= 0:
		return
	#Assuming multiplier is 1 or less (which it should be), then applying
	#reduction BEFORE the multiplier should always result in the higher number
	#so that's what we're going to go for. In practice, I assume we'll never
	#see both of these at the same time, but it's good to plan for it.
	#TODO Alternatively, figure out which is better and only apply it?
	#TODO This might all be moot when we start using elemental damage.
	block -= block_reduction
	block = floori(block * block_multiplier)


func take_damage(damage: int) -> void:
	# TODO Make sure PlayerStats extends this
	# TODO Update this to apply various elemental damage and their
	# 	associated blocking.
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage-block, 0, damage)
	self.block = clampi(block-initial_damage,0,block)
	self.health -= damage


func heal(amount: int) -> void:
	# This calls the set_health automatically, where it is clamped to max.
	self.health += amount


func can_play_card(card: Card) -> bool:
	#For AI creatures, this should be part of the AI?
	return mana >= card.cost


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	instance.mana = 0
	if instance.starting_deck:
		instance.deck = instance.starting_deck.duplicate()
	else:
		instance.deck = CardPile.new()
	instance.draw_pile = CardPile.new()
	instance.discard = CardPile.new()
	return instance
