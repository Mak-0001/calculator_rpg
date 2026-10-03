extends CanvasLayer




func _on_ready() -> void:
	BattleMenager.arena_node = self as CanvasLayer;
	BattleMenager.set_battlefield();
	SignalBus.battle_started.connect(battle_start);
	SignalBus.battle_to_end.connect(battle_end);
	self.layer = 0;

func battle_start():
	pass

func battle_end():
	visible = false;
	queue_free();
