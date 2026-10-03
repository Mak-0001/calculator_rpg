extends CanvasLayer
class_name Arena

@onready var sprite_player: TextureRect = %SpritePlayer
@onready var label_player: Label = %LabelPlayer

@onready var sprite_enemy: TextureRect = %SpriteEnemy
@onready var label_enemy: Label = %LabelEnemy

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
	sprite_player.texture = load("res://assets/sprites/calc1.png")
	sprite_enemy.texture = load(enemy.enemy_icon_path);
	label_player.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": player.current_health, "max_hp": player.max_health});
	label_enemy.text = "Health:{cur_hp}/{max_hp}".format({"cur_hp": enemy.current_health, "max_hp": enemy.max_health});
	await get_tree().create_timer(0.5).timeout;
	TransitionScript.fade_out(Color(0,0,255));
	await TransitionScript.fade_out_complete;
	self.layer = 1;
