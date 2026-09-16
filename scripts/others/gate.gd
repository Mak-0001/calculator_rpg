extends Area2D

class_name Door;

@export var destination_level: String;
@export var destination_door: String;

@export var direction: String = "up";

@onready var spawn_point: Marker2D = $SpawnPoint


func _on_body_entered(body: Node2D) -> void:
	if body is playerMain:
		MapMenager.go_to_level(destination_level, destination_door);
