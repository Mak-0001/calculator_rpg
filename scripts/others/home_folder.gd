extends Sprite2D

func _on_area_interact_now() -> void:
	#get_tree().quit();
	#GameMenager.handle_pause(true);
	MapMenager.go_to_level("res://scenes/ui/main_menu.tscn", "")


func _on_area_player_entered() -> void:
	$Area.interact_label_show();
