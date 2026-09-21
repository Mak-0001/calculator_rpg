extends Area2D

class_name Gate;

enum DIRECTION {Up, Right, Down, Left};

#@export var destination_level: String;
#@export var destination_door: String;
@export var key_resource : DoorKeysTemplate;
@export var direction: DIRECTION = DIRECTION.Down;
@export var ask_player: bool = false;

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var interact_area: InteractArea = $Area as InteractArea

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMain:
		if(!ask_player):
			use_gate();
		else:
			interact_area.interact_label_show();

func use_gate() -> void:
	if(ResourceUID.ensure_path(key_resource.level1) != get_tree().current_scene.scene_file_path):
		MapMenager.go_to_level(key_resource.level1, key_resource.gate1);
	else:
		MapMenager.go_to_level(key_resource.level2, key_resource.gate2);

func _on_area_interact_now() -> void:
	use_gate();
