extends CanvasLayer

@onready var quit_btn: Button = %quit;
@onready var resume_btn: Button = %resume
@onready var settings_btn: Button = %settings
@onready var languages_container: OptionButton = %languages
@onready var main_menu: Button = %main_menu


func _on_ready() -> void:
	visible = false;
	GameMenager.pause_screen = self;
	
	for i in GameMenager.available_languages.size():
		languages_container.add_item(GameMenager.available_languages[i], i);
	languages_container.selected = GameMenager.lang_index;
	
	quit_btn.pressed.connect(get_tree().quit);
	resume_btn.pressed.connect(open_settings);
	resume_btn.pressed.connect(GameMenager.handle_pause.bind(false));
	languages_container.item_selected.connect(GameMenager.change_language);
	main_menu.pressed.connect(func():
		MapMenager.go_to_level("res://scenes/ui/main_menu.tscn","");
		GameMenager.handle_pause(false);
	);

func open_settings():
	pass
