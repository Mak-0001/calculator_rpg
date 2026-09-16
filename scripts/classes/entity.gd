extends CharacterBody2D;

class_name Entity;

enum STATES {ALIVE = 1, DEAD = -1, HURT = -2}
enum TRANSPORT {IDLE = 1, RUN = 2, FREEZE = 3, SPECIAL = -1, STEALTH = 4}
enum ALIGMENT {FRIENDLY = 1, NEUTRAL = 0, AGGRESIVE = -1, TOTAL_AGGRESSIVE = -2}


#@icon()

func die():
	print("I died");
