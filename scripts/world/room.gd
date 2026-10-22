extends Node2D

class_name room;

var pause_screen = preload("res://scenes/ui/pause_screen.tscn");

func _on_ready() -> void:
	self.add_child(pause_screen.instantiate());
	if(MapMenager.dest_door == ""):
		SignalBus.room_changed.emit(Vector2.ZERO, 2);#2 -> DIRECTION.Down
		print("gate not defined");
	else:
		var door_path = "gates/" + MapMenager.dest_door;
		var door = get_node_or_null(door_path) as Gate;
		if door:
			SignalBus.room_changed.emit(door.spawn_point.global_position, door.direction);
		else:
			print("gate not found");
			SignalBus.room_changed.emit(Vector2.ZERO, 2);#2 -> DIRECTION.Down
