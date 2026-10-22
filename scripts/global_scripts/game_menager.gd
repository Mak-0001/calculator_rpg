extends Node2D;

const defaultVec: Vector2 = Vector2(-100000,-100000);

var playerNode: PlayerMain = null;
var pause_screen: CanvasLayer;

var game_running: bool = true;

var available_languages: PackedStringArray = TranslationServer.get_loaded_locales();
var lang_index: int: 
	set(value):
		lang_index = value % available_languages.size();
		TranslationServer.set_locale(available_languages[lang_index]);

func _on_ready() -> void:
	print(TranslationServer.get_loaded_locales());
	lang_index = 0;

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("escape")):
		handle_pause(!get_tree().paused);

func handle_pause(toStop: bool):
	game_running = !toStop;
	get_tree().paused = toStop;
	if(pause_screen):
		pause_screen.visible = toStop;

func change_language(index: int):
	lang_index = index;
