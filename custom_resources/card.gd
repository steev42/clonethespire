class_name Card
extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Rarity {COMMON, UNCOMMON, RARE}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

const RARITY_COLORS := {
	Card.Rarity.COMMON: Color.GRAY,
	Card.Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	Card.Rarity.RARE: Color.GOLD,	
}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var rarity: Rarity
@export var target: Target
@export var cost: int
@export var rarity_trait : Trait : set = _set_rarity_trait
@export var type_trait : Trait : set = _set_type_trait
@export var target_trait : Trait : set = _set_target_trait
@export var other_traits : Array[Trait] = [] : set = _set_other_traits

@export_group ("Card Visuals")
@export var icon: Texture
@export_multiline var card_text: String
@export_multiline var tooltip_text: String

@export var sound: AudioStream


func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY


func _set_rarity_trait(value: Trait) -> void:
	if value.trait_type != Trait.TraitType.RARITY:
		return
	rarity_trait = value


func _set_type_trait(value: Trait) -> void:
	if value.trait_type != Trait.TraitType.TYPE:
		return
	type_trait = value


func _set_target_trait(value: Trait) -> void:
	if value.trait_type != Trait.TraitType.TARGETS:
		return
	target_trait = value


func _set_other_traits(value: Array[Trait]) -> void:
	for t : Trait in value:
		match t.trait_type:
			Trait.TraitType.RARITY:
				_set_rarity_trait(t)
			Trait.TraitType.TYPE:
				_set_type_trait(t)
			Trait.TraitType.TARGETS:
				_set_target_trait(t)
			_:
				other_traits.append(t)


func get_trait_array() -> Array[Trait]:
	var rv : Array[Trait] = []
	if rarity_trait:
		rv.append(rarity_trait)
	if type_trait:
		rv.append(type_trait)
	if target_trait:
		rv.append(target_trait)
	if other_traits:
		rv.append_array(other_traits)
	return rv

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets:
		return []
	var tree := targets[0].get_tree()
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], char_stats: Stats) -> void:
	Events.card_played.emit(self)
	char_stats.mana -= cost
	
	if is_single_targeted():
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))


func apply_effects(_targets: Array[Node]) -> void:
	pass
