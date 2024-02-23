class_name Stats
extends Resource

signal stats_changed

@export var max_health :=1
@export var art: Texture

var health: int  : set = set_health
var block: int : set = set_block
#TODO Make block an effect?
var character_effects = {}

func add_character_effect(effect: CharacterEffect, value: int) -> void:
	if character_effects.has(effect.name):
		character_effects[effect.name].current_value += value
		print("Updated %s by %s, now at level %s"%[effect.name, value, character_effects[effect.name].current_value])
	else:
		character_effects[effect.name] = effect
		character_effects[effect.name].current_value = value
		print("Added %s at level %s"%[effect.name, value])


func set_health (value : int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()


func set_block (value : int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()


func take_damage(damage: int) -> void:
	if damage <= 0:
		return
	var initial_damage = damage
	damage = clampi(damage-block, 0, damage)
	self.block = clampi(block-initial_damage,0,block)
	self.health -= damage


func heal(amount: int) -> void:
	# This calls the set_health automatically, where it is clamped to max.
	self.health += amount


func create_instance() -> Resource:
	var instance: Stats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
