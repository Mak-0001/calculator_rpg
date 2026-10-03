extends Node

var arena: String = "res://scenes/world/arena.tscn";
var arena_node: CanvasLayer;
var progress: Array = [];

var player_res: Resource;
var enemy_node: Enemy;
var enemy_res: EnemyFileResource;

func _on_ready() -> void:
	SignalBus.battle_to_start.connect(start_battle);

func go_to_battle() -> void:
	
	TransitionScript.fade_in(Color(0,0,255));
	await TransitionScript.fade_in_complete;
	var state = ResourceLoader.load_threaded_request(arena, "", true);
	
	if state == OK:
		set_process(true);
	
func _process(_delta: float) -> void:
	var load_status = ResourceLoader.\
		load_threaded_get_status(arena, progress);
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false);
			#dodaj print błędu
		ResourceLoader.THREAD_LOAD_LOADED:
			var loaded = ResourceLoader.load_threaded_get(arena);
			#get_tree().change_scene_to_packed(loaded);
			#await TransitionScript.show_folder_complete;
			if loaded:
				var scene = loaded as PackedScene
				if scene:
					var instance = scene.instantiate()
					get_tree().current_scene.add_child(instance)
					SignalBus.battle_started.emit();

func start_battle(_enemy: Enemy):
	enemy_node = _enemy;
	go_to_battle();

func arena_ready(arena_node_temp: CanvasLayer):
	arena_node = arena_node_temp as Arena;
	arena_node.set_battlefield(GameMenager.playerNode, enemy_node)

func set_battlefield(): #useless
	var player_sprite = arena_node.find_child("SpritePlayer") as TextureRect;
	var enemy_sprite = arena_node.find_child("SpriteEnemy") as TextureRect;
	if(player_sprite and enemy_sprite):
		player_sprite.texture = load("res://assets/sprites/calc1.png");
		enemy_sprite.texture = load("res://icon.svg");
	TransitionScript.show_folder(enemy_res.enemy_name);
	await get_tree().create_timer(0.5).timeout;
	TransitionScript.fade_out(Color(0,0,255));
	await TransitionScript.fade_out_complete;
	arena_node.layer = 1;
	
