extends CanvasLayer
class_name Arena

@onready var player_options: GridContainer = %PlayerOptions

var player: PlayerMain;
var enemy: Enemy;

func _on_ready() -> void:
	BattleMenager.arena_ready(self);
	#BattleMenager.set_battlefield();
	SignalBus.battle_started.connect(battle_start);
	SignalBus.battle_to_end.connect(battle_end);
	self.layer = 0;

func battle_start():
	pass

func battle_end():
	visible = false;
	queue_free();


func set_battlefield(player_temp: PlayerMain, enemy_temp: Enemy):
	player = player_temp;
	enemy = enemy_temp;
	TransitionScript.show_folder(enemy.enemy_res_file.enemy_name);
	#sprite_player.texture = load("res://assets/sprites/calc1.png")
	#sprite_enemy.texture = load(enemy.enemy_icon_path);
	#label_player.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": player.current_health, "max_hp": player.max_health});
	#label_enemy.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": enemy.current_health, "max_hp": enemy.max_health});
	render_battle_profile(player);
	render_battle_profile(enemy);
	await get_tree().create_timer(0.5).timeout;
	TransitionScript.fade_out(Color(0,0,255));
	await TransitionScript.fade_out_complete;
	self.layer = 1;

func render_battle_profile(entit: Entity):
	var container: Control = %FramePlayer if entit is PlayerMain else %FrameEnemy;
	var sprite = container.find_child("sprite");
	var label = container.find_child("label");
	var actions = container.find_child("actions");
	
	sprite.texture = load(entit.icon_path);
	label.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": entit.current_health, "max_hp": entit.max_health});
	actions.text = "Actions:{cur_act}/{max_act}".format({"cur_act": entit.action_count, "max_act": entit.actions_per_turn});
	
	
	if(entit is PlayerMain):
		for ab in entit.ability_list:
			var btn_temp = Button.new();
			btn_temp.text = ab.ability_name;
			player_options.add_child(btn_temp);
			btn_temp.pressed.connect(ab.ability_main);
