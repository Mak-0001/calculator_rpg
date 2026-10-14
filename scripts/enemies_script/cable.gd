extends Enemy
var player_here:bool = false;
@onready var area: InteractArea = $Area
@onready var sprite_2d: Sprite2D = $Sprite2D
	
func _on_ready() -> void:
	connect_interaction(area);
	connect_icon_texture(sprite_2d.texture);
func _on_area_player_entered() -> void:
	player_here = true;
	set_process(true);

func _process(_delta: float) -> void:
	if(player_here and GameMenager.playerNode.can_interact and $Timer.is_stopped()):
		$Timer.start();

func _on_timer_timeout() -> void:
	if (aligment < 0 and player_here):
		start_battle();

func _on_area_player_exited() -> void:
	player_here = false;
	($Timer as Timer).stop();
	set_process(false);
	
	
