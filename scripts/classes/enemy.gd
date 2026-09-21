extends Entity;

class_name Enemy;

var enemy_name: String;

func start_battle() -> void:
	SignalBus.battle_to_start.emit(
		Resource.new()
	);
