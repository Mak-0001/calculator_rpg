extends Entity;

class_name Enemy;


@export var enemy_res_file: EnemyFileResource:
	set(value):
		enemy_res_file = value;
		max_health = enemy_res_file.enemy_max_health
		current_health = enemy_res_file.enemy_max_health
@export var aligment: ALIGMENT;

func start_battle() -> void:
	SignalBus.battle_to_start.emit(
		self
	);

func my_turn() -> Callable:
	if(len(ability_list) <= 0):
		return empty_turn;
	var att_ind = randi_range(0, len(ability_list) - 1);
	return ability_list[att_ind].ability_main;

func empty_turn():
	print("empty turn")
	SignalBus.end_my_turn.emit();
	return 0;

func connect_interaction(area: InteractArea):
	match aligment:
		ALIGMENT.FRIENDLY:
			pass
		ALIGMENT.NEUTRAL:
			area.interact_now.connect(start_battle);
		ALIGMENT.AGGRESIVE, ALIGMENT.TOTAL_AGGRESSIVE:
			area.player_interact.connect(start_battle);
