extends Node

var arena: String = "res://scenes/world/arena.tscn";
var arena_node: CanvasLayer;
var progress: Array = [];

#var player_res: Resource;
var nodes_in_battle: Array[Entity];
#var enemy_res: EnemyFileResource;

enum WHOSE_TURN {PLAYER = 0, ENEMY = 1, OTHER = -1, NONE = -2};
var turn_of: WHOSE_TURN = WHOSE_TURN.NONE:
	set(value):
		turn_of = value;
		if(arena_node):
			(arena_node.turn_banner as Label).text = str(turn_of as int);
var turn_index: int:
	set(value):
		value = value % (len(nodes_in_battle) if len(nodes_in_battle) != 0 else 1);
		if(value == 0 or value == -1):
			turn_of = value as WHOSE_TURN;
			if(value == 0):
				SignalBus.next_turn.emit();
		elif(value > 0):
			turn_of = 1 as WHOSE_TURN;
		else:
			turn_of = WHOSE_TURN.NONE;
		turn_index = value;

enum BATTLE_STATE {LOADING = 0, IN_PROGRESS = 1, OFF = -1};
var state_of_battle: BATTLE_STATE;


func _on_ready() -> void:
	SignalBus.battle_to_start.connect(start_battle);
	SignalBus.battle_to_end.connect(func(): 
		nodes_in_battle.clear();
		turn_of = WHOSE_TURN.NONE;
		state_of_battle = BATTLE_STATE.OFF;
		set_process(false);
	);
	SignalBus.end_my_turn.connect(func(): 
		turn_index+=1;
		#await get_tree().create_timer(1).timeout;
		set_process(true);
	);
	SignalBus.next_turn.connect(func():
		print("===END OF TURN===");
		for ent in nodes_in_battle:
			ent.action_count = ent.actions_per_turn;
		SignalBus.update_battle_info.emit();
		)

func go_to_battle() -> void:
	
	TransitionScript.fade_in(Color(0,0,255));
	await TransitionScript.fade_in_complete;
	var state = ResourceLoader.load_threaded_request(arena, "", true);
	
	if state == OK:
		state_of_battle = BATTLE_STATE.LOADING;
		set_process(true);
	
func _process(_delta: float) -> void:
	if(state_of_battle == BATTLE_STATE.IN_PROGRESS):
		if(turn_of != WHOSE_TURN.PLAYER):
			set_process(false);
			await get_tree().create_timer(2).timeout;
			handle_single_turn(nodes_in_battle[turn_index].my_turn(), 0);
	
	if(state_of_battle == BATTLE_STATE.LOADING):
		var load_status = ResourceLoader.\
			load_threaded_get_status(arena, progress);
		match load_status:
			ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
				set_process(false);
				state_of_battle = BATTLE_STATE.OFF;
			ResourceLoader.THREAD_LOAD_LOADED:
				var loaded = ResourceLoader.load_threaded_get(arena);
				if loaded:
					var scene = loaded as PackedScene
					if scene:
						var instance = scene.instantiate()
						get_tree().current_scene.add_child(instance)
						SignalBus.battle_started.emit();

func start_battle(_enemy: Enemy):
	nodes_in_battle.append(GameMenager.playerNode);
	nodes_in_battle.append(_enemy);
	turn_of = WHOSE_TURN.PLAYER;
	turn_index = 0;
	go_to_battle();

func arena_ready(arena_node_temp: CanvasLayer):
	arena_node = arena_node_temp as Arena;
	(arena_node.turn_banner as Label).text = str(turn_of as int);
	arena_node.set_battlefield(
		GameMenager.playerNode, 
		nodes_in_battle.slice(1,len(nodes_in_battle))
	);
	state_of_battle = BATTLE_STATE.IN_PROGRESS;
	set_process(true);


func handle_single_turn(_ability: Callable, target_ind: int):
	print((nodes_in_battle[turn_index].name) + ": ");
	var output = _ability.call();
	if(output >= 0):
		deal_damage_to(target_ind, output);
	SignalBus.update_battle_info.emit();


func deal_damage_to(target_index: int, damage: int) -> void:
	var target: Entity = nodes_in_battle[target_index];
	target.take_damage(damage);
