extends Button


func _on_pressed() -> void:
	SignalBus.battle_to_end.emit();
