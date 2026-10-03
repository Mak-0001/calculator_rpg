extends Entity;

class_name Enemy;

var enemy_name: String;
@export var enemy_res_file: EnemyFileResource;
@export var aligment: ALIGMENT;

func start_battle() -> void:
	SignalBus.battle_to_start.emit(
		self
	);
