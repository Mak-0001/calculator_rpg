extends CanvasLayer
@onready var animation_player: AnimationPlayer = %AnimationPlayer;
@onready var color_rect: ColorRect = %ColorRect;
@onready var dir_name: Label = %DirName

signal fade_in_complete;
signal fade_out_complete;
#signal show_folder_complete;

func _on_ready() -> void:
	dir_name.visible = false;

func fade_in(fog_color: Color = Color(0,0,0)):
	color_rect.color = fog_color;
	animation_player.play("fade_in");

func fade_out(fog_color: Color = Color(0,0,0)):
	color_rect.color = fog_color;
	animation_player.play("fade_out");

func show_folder(_dir_name: String):
	self.dir_name.text = _dir_name;
	self.dir_name.visible = true;
	await get_tree().create_timer(2).timeout;
	self.dir_name.visible = false;
	#animation_player.play("show_folder");

func _on_progress_changed(_progress: float):
	pass

func _on_load_finished():
	#fade_out();
	pass
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_in":
			fade_in_complete.emit();
		"fade_out":
			fade_out_complete.emit();
		#"show_folder":
			#show_folder_complete.emit();
