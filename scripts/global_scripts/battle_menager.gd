extends Node

var arena: String = "res://scenes/world/arena.tscn";
var arena_node: Node;
var progress: Array = [];

var player_res: Resource;
var enemy_res: Resource;

func _on_ready() -> void:
	SignalBus.battle_to_start.connect(start_battle);

func go_to_battle() -> void:
	TransitionScript.fade_in(Color(0,0,255));
	await TransitionScript.fade_in_complete;
	var state = ResourceLoader.load_threaded_request(arena, "", true);
	
	if state == OK:
		set_process(true);
	
func _process(delta: float) -> void:
	var load_status = ResourceLoader.\
		load_threaded_get_status(arena, progress);
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false);
			#dodaj print błędu
		ResourceLoader.THREAD_LOAD_LOADED:
			var loaded = ResourceLoader.load_threaded_get(arena);
			#await TransitionScript.show_folder_complete;
			get_tree().change_scene_to_packed(loaded);

func start_battle(_enemy_resource: Resource):
	go_to_battle();

func set_battlefield():
	var player_sprite = arena_node.find_child("SpritePlayer") as Sprite2D;
	var enemy_sprite = arena_node.find_child("SpriteEnemy") as Sprite2D;
	if(player_sprite and enemy_sprite):
		player_sprite.texture = load("res://assets/sprites/calc1.png");
		enemy_sprite.texture = load("res://icon.svg");
	TransitionScript.show_folder("enemy_name_from_res");#(enenmy_res.enemy_name);
	await get_tree().create_timer(0.5).timeout;
	TransitionScript.fade_out(Color(0,0,255));
	
