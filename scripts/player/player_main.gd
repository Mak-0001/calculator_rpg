extends Entity;
class_name playerMain;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D;

#region enums
enum POSS_DIRECTION {Up, Right, Down, Left};
#endregion
#region stałe
const MAX_SPEED := 80.00;

#endregion
var curr_direction : POSS_DIRECTION;

#region basics
func _on_ready() -> void:
	GameMenager.playerNode = self;
	SignalBus.room_changed.connect(enter_room);

func _on_tree_exited() -> void:
	GameMenager.playerNode = null;

func _physics_process(_delta: float) -> void:
	check_direction();
	anim_play();
	
	var left_right_vec := Input.get_axis("left","right");
	var down_up_vec := Input.get_axis("up", "down");
	
	if(left_right_vec != 0):
		velocity.x = MAX_SPEED * left_right_vec;
		velocity.y = 0;
	else:
		velocity.y = MAX_SPEED * down_up_vec;
		velocity.x = 0;
	
	move_and_slide();

func check_direction() -> void:
	if(velocity.y != 0):
		curr_direction = POSS_DIRECTION.Up if velocity.y > 0 else POSS_DIRECTION.Down;
	elif(velocity.x != 0):
		curr_direction = POSS_DIRECTION.Right if velocity.x > 0 else POSS_DIRECTION.Left;

func enter_room(pos:Vector2, dir: int) -> void:
	global_position = pos;
	curr_direction = dir as POSS_DIRECTION;
#endregion

#region animations
func anim_play() -> void:
	if(velocity == Vector2.ZERO):
		animated_sprite_2d.pause();
	else:
		#oparte na wektorze ruchu
		#if(velocity.x != 0):
			#animated_sprite_2d.play("side")
			#animated_sprite_2d.flip_h = velocity.x < 0;
		#else:
			#if(velocity.y > 0):
				#animated_sprite_2d.play("forward");
			#else:
				#animated_sprite_2d.play("backward");
		#oparte na kierunku
		match curr_direction:
			POSS_DIRECTION.Up:
				animated_sprite_2d.play("forward");
				animated_sprite_2d.flip_h = false;
			POSS_DIRECTION.Down:
				animated_sprite_2d.play("backward");
				animated_sprite_2d.flip_h = false;
			POSS_DIRECTION.Right:
				animated_sprite_2d.play("side");
				animated_sprite_2d.flip_h = false;
			POSS_DIRECTION.Left:
				animated_sprite_2d.play("side");
				animated_sprite_2d.flip_h = true;
			_:
				pass;

#endregion
#region health
func die() -> void:
	print("player died")
