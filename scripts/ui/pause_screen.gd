extends CanvasLayer

@onready var quit_btn: Button = %quit;
@onready var resume_btn: Button = %resume
@onready var settings_btn: Button = %settings
@onready var languages_container: OptionButton = %languages


func _on_ready() -> void:
	visible = false;
	GameMenager.pause_screen = self;
	
	for i in GameMenager.available_languages.size():
		languages_container.add_item(GameMenager.available_languages[i], i);
	languages_container.selected = GameMenager.lang_index;
	
	quit_btn.pressed.connect(func(): get_tree().quit());
	resume_btn.pressed.connect(open_settings);
	resume_btn.pressed.connect(func(): GameMenager.handle_pause(false));
	languages_container.item_selected.connect(GameMenager.change_language);

func open_settings():
	pass
