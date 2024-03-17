class_name Stats_Player
extends Stats

func take_damage(damage: int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if health < initial_health:
		Events.player_damage_taken.emit()

func create_instance() -> Resource:
	var instance: Stats_Player = self.duplicate() as Stats_Player
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
