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

var action_count: int;
var actions_per_turn: int = 1;

var icon_path: String;

func connect_icon_text(texture_res: Texture2D):
	icon_path = texture_res.resource_path;
	
func connect_icon_path(texture_res: String):
	icon_path = texture_res;

func my_turn():
	pass

func die():
	print("I died");
