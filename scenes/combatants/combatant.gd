extends Area2D

enum TargetType {PLAYER, ENEMY, ALLY}

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var arrow: Sprite2D = $Arrow
@onready var stats_ui: StatsUI = $StatsUI as StatsUI
@onready var intent_ui: IntentUI = $IntentUI as IntentUI  # Enemy only?  Only hidden on player?

@export var target_type : TargetType = TargetType.ENEMY

#ENEMY FUNCTIONS						PLAYER FUNCTIONS						ALLY FUNCTIONS
# set_current_action(EnemyAction)												YES
# set_enemy_stats(EnemyStats)			set_character_stats(CharacterStats)		YES
# setup_ai()																	YES
# update_stats()						update_stats()							YES
# update_action()																YES
# update_enemy()						update_player()							YES
# do_turn()																		YES
# take_damage(int)						take_damage(int)						YES
# _on_area_entered						add this								YES
# _on_area_exited						add this								YES



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sprite_2d.get_rect().size.x
	#sprite_2d.apply_scale()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
