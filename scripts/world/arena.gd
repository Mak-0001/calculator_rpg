extends Node2D




func _on_ready() -> void:
	BattleMenager.arena_node = self;
	BattleMenager.set_battlefield();
