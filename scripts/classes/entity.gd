extends CharacterBody2D;

class_name Entity;

enum STATES {ALIVE = 1, DEAD = -1, HURT = -2}
enum TRANSPORT {IDLE = 1, RUN = 2, FREEZE = 3, SPECIAL = -1, STEALTH = 4}
enum ALIGMENT {FRIENDLY = 1, NEUTRAL = 0, AGGRESIVE = -1, TOTAL_AGGRESSIVE = -2}

@export var ability_list: Array[Ability];
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

var action_count: int:
	set(value):
		if(value <= 0):
			SignalBus.end_turn.emit(self);
		action_count = value;
const actions_per_turn: int = 1;

var icon_path: String;

func connect_icon_text(texture_res: Texture2D) -> void:
	icon_path = texture_res.resource_path;
	
func connect_icon_path(texture_res: String) -> void:
	icon_path = texture_res;

func my_turn():
	pass

func take_damage(dam: int) -> void:
	current_health -= dam;

func die():
	SignalBus.battle_to_end.emit();
	print(self.name + " died");
	queue_free();
