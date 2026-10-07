extends CanvasLayer
class_name Arena

@onready var player_options: GridContainer = %PlayerOptions
@onready var turn_banner: Label = %turn_banner

var player: PlayerMain;
var enemy: Enemy;

var banners: Array[Control];
var volunteers: Array[Entity];#0: player, 1..: [enemy]

func _on_ready() -> void:
	banners.append(%FramePlayer);
	banners.append(%FrameEnemy);
	BattleMenager.arena_ready(self);
	#BattleMenager.set_battlefield();
	SignalBus.battle_started.connect(battle_start);
	SignalBus.battle_to_end.connect(battle_end);
	SignalBus.update_battle_info.connect(update_banner)
	self.layer = 0;

func battle_start():
	pass

func battle_end():
	visible = false;
	queue_free();


func set_battlefield(player_temp: PlayerMain, enemy_temp: Array[Entity]):
	#player = player_temp;
	#enemy = enemy_temp;
	volunteers.append(player_temp);
	volunteers.append_array(enemy_temp);
	TransitionScript.show_folder((volunteers[1] as Enemy).enemy_res_file.enemy_name);

	for i in range(len(volunteers)):
		render_battle_profile(i);
	update_banner()
	await get_tree().create_timer(0.5).timeout;
	TransitionScript.fade_out(Color(0,0,255));
	await TransitionScript.fade_out_complete;
	self.layer = 1;

func render_battle_profile(i: int):
	#var container: Control = %FramePlayer if entit is PlayerMain else %FrameEnemy;
	#var container: Control = banners[i];
	var entit: Entity = volunteers[i];
	
	if(entit is PlayerMain):
		var btn_temp: Button;
		for ab in entit.ability_list:
			btn_temp = Button.new();
			btn_temp.text = ab.ability_name;
			player_options.add_child(btn_temp);
			btn_temp.pressed.connect(func():
				if BattleMenager.turn_of == 0:
					volunteers[0].action_count -= ab.ability_cost;
					BattleMenager.handle_single_turn(ab.ability_main, 1);
			);
		btn_temp = Button.new();
		btn_temp.text = "Pomiń";
		player_options.add_child(btn_temp);
		btn_temp.pressed.connect(entit.empty_turn);

func update_banner() -> void:
	var container: Control;
	var entit: Entity;
	for i in range(len(volunteers)):
		container = banners[i];
		entit = volunteers[i];
		var sprite = container.find_child("sprite");
		var label = container.find_child("label");
		var actions = container.find_child("actions");
		
		sprite.texture = load(entit.icon_path);
		label.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": entit.current_health, "max_hp": entit.max_health});
		actions.text = "Actions:{cur_act}/{max_act}".format({"cur_act": entit.action_count, "max_act": entit.actions_per_turn});
