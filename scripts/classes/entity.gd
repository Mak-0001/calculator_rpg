extends CharacterBody2D;

class_name Entity;

enum STATES {ALIVE = 1, DEAD = -1, HURT = -2}
enum TRANSPORT {IDLE = 1, RUN = 2, FREEZE = 3, SPECIAL = -1, STEALTH = 4}
enum ALIGMENT {FRIENDLY = 1, NEUTRAL = 0, AGGRESIVE = -1, TOTAL_AGGRESSIVE = -2}

var min_cost_ability: int = 1_000_000;

@export var ability_list: Array[Ability]:
	set(value):
		ability_list = value;
		for ab in ability_list:
			if(ab.ability_cost < min_cost_ability):
				min_cost_ability = ab.ability_cost;
#@icon()

var max_health: int = 10:
	set(value):
		current_health = value;
		max_health = value;
var current_health: int = 10: 
	set(value):
		current_health = clamp(value, 0 , max_health);
		if(value <= 0):
			die();

var block: int = 0; #zerowane przy turn_index.set()

var action_count: int:
	set(value):
		action_count = clamp(value, 0, max_actions);
		actions_changed();
		#print(self.name + "-actions-"+str(value))
		#if(value <= 0):
			#SignalBus.end_my_turn.emit();
		#action_count = value;
var actions_per_turn: int = 2;
var max_actions: int = 3;

var icon_path: String;

func connect_icon_texture(texture_res: Texture2D) -> void:
	icon_path = texture_res.resource_path;
	
func connect_icon_path(texture_res: String) -> void:
	icon_path = texture_res;

func update_action_count(val: int) -> void:
	if(val < 0):
		action_count += val;
	elif(val == 1):
		action_count = actions_per_turn;

func my_turn():
	pass

func empty_turn():
	BattleMenager.add_battle_log(self.name + ": empty turn")
	#action_count = 0;
	#SignalBus.end_my_turn.emit();
	return -10;

func actions_changed():
	pass

func take_damage(dam: int) -> void:
	if(block > 0):
		var absorbed: int = mini(block, dam);
		block -= absorbed;
		dam -= absorbed;
		BattleMenager.add_battle_log("Block: -" + str(absorbed));
	if(dam > 0):
		current_health -= dam;

func die():
	SignalBus.battle_to_end.emit();
	BattleMenager.add_battle_log(self.name + " died");
	queue_free();
