class_name Trait
extends Resource

enum TraitType {RARITY, TYPE, TARGETS, DAMAGE, EFFECT_GROUP, EFFECT}

@export var trait_name : String
@export var image : Texture
@export var tooltip_text : String
@export var trait_type: TraitType
@export var image_modulation: Color = Color(1,1,1,1)

func _ready() -> void:
	image.modulate = image_modulation

# Trait Types
# Rarity [Only One, Required, Always Top]: Starter, Common, Uncommon, Rare
# Card Type [Only One, Required, Always 2nd]: Attack, Skill, Power
# Targets [Only One, 3rd on Attack]: Single, Multi, All, Random, Self
# All other traits to be displayed in alphabetical order
# Damage Type: Physical, Fire, Electricity, Cold, Poison, Acid
# Other: Heal, Debuff, Buff
# Effect Names
