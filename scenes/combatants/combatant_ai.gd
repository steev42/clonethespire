class_name Combatant_AI
extends Combatant

@onready var intent_ui: IntentUI = $IntentUI

var ai_action_picker: EnemyActionPicker # TODO Genericize this?
var current_action: EnemyAction : set = set_current_action

@export var ai: PackedScene

func check_for_death() -> void:
	if stats.health <= 0:
		queue_free()


func set_stats(value: Stats) -> void:
	if not value:
		return
	super.set_stats(value)
	# if our stats have changed, our intent may as well.
	if not stats.stats_changed.is_connected(update_action):
		stats.stats_changed.connect(update_action)


func update_character() -> void:
	super.update_character()
	setup_ai()


func set_current_action(value: EnemyAction) -> void:
	current_action = value
	if current_action:
		intent_ui.update_intent(current_action.intent)


func setup_ai() -> void:
	if ai_action_picker:
		ai_action_picker.queue_free()
	
	var new_action_picker: EnemyActionPicker = ai.instantiate()
	add_child(new_action_picker)
	ai_action_picker = new_action_picker
	ai_action_picker.enemy = self


func update_action() -> void:
	if not ai_action_picker:
		return
	
	if not current_action:
		current_action = ai_action_picker.get_action()
		return
	
	var new_conditional_action := ai_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action


func do_turn() -> void:
	stats.block = 0 # TODO Hmmm...this should be less magic-numbery
	if not current_action:
		return
	current_action.perform_action()

