extends Enemy

var player_here:bool = false;
@onready var area: InteractArea = $Area 

func _on_ready() -> void:
	set_process(false);
	#enemy_icon_path = ($Sprite2D.texture as Texture2D).resource_path;
	connect_icon_text($Sprite2D.texture);
	connect_interaction(area);

func _on_area_player_entered() -> void:
	player_here = true
	set_process(true)

func _on_area_player_exited() -> void:
	player_here = false
	($Timer as Timer).stop()
	set_process(false)

func _process(_delta: float) -> void:
	if(player_here and GameMenager.playerNode.can_interact and $Timer.is_stopped()):
		$Timer.start()

func _on_timer_timeout() -> void:
	if(aligment < 0 and player_here):
		start_battle();
