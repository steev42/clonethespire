class_name TraitUI
extends TextureRect

@export var card_trait : Trait

@onready var trait_image: TextureRect = %TraitImage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trait_image.texture = card_trait.image
	trait_image.self_modulate = card_trait.image_modulation
