class_name CardVisuals
extends Control

const TRAIT_UI = preload("res://scenes/ui/trait_ui.tscn")

@export var card: Card : set = set_card

@onready var panel: Panel = $Panel
@onready var image: TextureRect = %CardImage
@onready var title: Label = %CardName
@onready var cost: Label = %ManaCost
@onready var card_text: RichTextLabel = %CardText
@onready var rarity: TextureRect = %Rarity
@onready var traits: VBoxContainer = %Traits
@onready var hover_glow: ColorRect = %HoverGlow
func set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	card_text.text = card.card_text
	cost.text = str(card.cost)
	title.text = card.id
	image.texture = card.icon
	rarity.modulate = Card.RARITY_COLORS[card.rarity]
	for t in traits.get_children():
		t.queue_free()
	for t:Trait in card.get_trait_array():
		if not t:
			continue
		var trait_texture := TRAIT_UI.instantiate()
		trait_texture.card_trait = t
		traits.add_child(trait_texture)
		continue
