extends Entity;
class_name playerMain;
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D;


#region stałe
const MAX_SPEED := 80.00;

#endregion

#region basics
func _on_ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
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
#endregion

#region animations
func anim_play():
	if(velocity == Vector2.ZERO):
		animated_sprite_2d.pause();
	else:
		if(velocity.x != 0):
			animated_sprite_2d.play("side")
			animated_sprite_2d.flip_h = velocity.x < 0;
		else:
			if(velocity.y > 0):
				animated_sprite_2d.play("forward");
			else:
				animated_sprite_2d.play("backward")

#endregion
#region health
func die():
	print("player died")
