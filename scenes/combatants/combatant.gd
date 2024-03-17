class_name Combatant
extends Area2D

enum TargetType {PLAYER, ENEMY, ALLY}
const WHITE_SPRITE_MATERIAL := preload("res://art/white_shader_material.tres")
@onready var image: Sprite2D = %Image
@onready var pointer: Sprite2D = %Pointer
@onready var stats_ui: StatsUI = $StatsUI
@onready var effects_ui: EffectsUI = $EffectsUI

@export var target_type : TargetType = TargetType.ENEMY

@export var stats: Stats : set = set_stats


func set_stats(value:Stats) -> void:
	if not value:
		return

	# If AI, need to create new instance. If player, instance created in
	# run script (eventually--currently battle).
	if target_type == TargetType.PLAYER:
		stats = value
	else:
		stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	if not stats.death_check_required.is_connected(check_for_death):
		stats.death_check_required.connect(check_for_death)
	
	update_character()


func update_stats() -> void:
	stats_ui.update_stats(stats)


func update_character() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	
	image.texture = stats.portrait
	update_stats()


func take_damage(amount:int) -> void:
	# TODO I don't like that taking the damage and showing the feedback are
	# 	in the same function. Can we do something about that?
	if stats.health <= 0:
		return
	
	# Turn white and shake the sprite a little, then reset.
	image.material = WHITE_SPRITE_MATERIAL
	var tween := create_tween()
	# shake the sprite
	tween.tween_callback(Shaker.shake.bind(self, 15, 0.15))
	# actually deal the damage
	tween.tween_callback(stats.take_damage.bind(amount))
	tween.tween_interval(0.17)
	
	tween.finished.connect(func():
		image.material = null
		)


# Placeholder function in case I want to do something like this later.
func heal(amount:int) -> void:
	pass


func check_for_death() -> void:
	pass


func add_target_effect(effect: TargetEffect) -> void:
	Events.player_turn_ended.connect(effect._on_turn_end)
	if not stats.has_target_effect(effect):
		effects_ui.add_effect(effect)
	stats.add_target_effect(effect)
	# The target_effect_ui script handles updating the label & deleting itself
	# When needed.


# TODO On the following two functions, they will *always* show the pointer. 
# Should try to set something up that the pointer is only visible if the 
# entered character is a valid target for the card. 
# In the youtube tutorial, players didn't have a pointer, and allies didn't
# exist, so this wasn't an issue. If the card needed a target, all combatants
# with pointers were enemies, so you would always show the target.
# Area2D in these functions is the CardUI's DropPointDetector.
func _on_area_entered(_area: Area2D) -> void:
	pointer.show()


func _on_area_exited(_area: Area2D) -> void:
	pointer.hide()
