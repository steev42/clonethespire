class_name Combatant
extends Area2D

enum TargetType {PLAYER, ENEMY, ALLY}
const WHITE_SPRITE_MATERIAL := preload("res://art/white_shader_material.tres")
@onready var image: Sprite2D = %Image
@onready var pointer: Sprite2D = %Pointer
@onready var stats_ui: StatsUI = $StatsUI as StatsUI
#@onready var intent_ui: IntentUI = $IntentUI as IntentUI  # Move this to AICombatant!

@export var target_type : TargetType = TargetType.ENEMY

@export var stats: Stats : set = set_stats


func set_stats(value:Stats) -> void:
	# If AI, need to create new instance. If player, instance created in
	# run script (eventually--currently battle).
	if target_type == TargetType.PLAYER:
		stats = value
	else:
		stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_character()


func update_stats() -> void:
	stats_ui.update_stats(stats)
	# Stats have updated, so we may have died...check for this.
	check_for_death()


func update_character() -> void:
	if not stats is Stats:
		return
	if not is_inside_tree():
		await ready
	
	image.texture = stats.portrait
	update_stats()


func wound_feedback(amount:int) -> void:
	if stats.health <= 0:
		return
	
	# Turn white and shake the sprite a little, then reset.
	image.material = WHITE_SPRITE_MATERIAL
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 15, 0.15))
	tween.tween_callback(stats.take_damage.bind(amount))
	tween.tween_interval(0.17)
	
	tween.finished.connect(func():
		image.material = null
		)


# Placeholder function in case I want to do something like this later.
func heal_feedback(amount:int) -> void:
	pass


func check_for_death() -> void:
	pass


# NOTE On the following two functions, they will *always* show the pointer. 
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
