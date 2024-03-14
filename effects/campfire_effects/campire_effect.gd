class_name CampfireEffect
extends Resource

@export var image : Texture
@export var name : String
@export var sound: AudioStream
@export var max_uses_per_rest: int = 1

func execute(_character_stats : Stats_Player) -> void:
	pass
