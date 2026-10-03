extends Entity;

class_name Enemy;


@export var enemy_res_file: EnemyFileResource:
	set(value):
		enemy_res_file = value;
		max_health = enemy_res_file.enemy_max_health
		current_health = enemy_res_file.enemy_max_health
@export var aligment: ALIGMENT;
var enemy_icon_path: String;
var max_health: int;
var current_health: int:
	set(value):
		current_health = value;

func start_battle() -> void:
	SignalBus.battle_to_start.emit(
		self
	);

func connect_enemy_icon_path(texture_res: Texture2D):
	enemy_icon_path = texture_res.resource_path
