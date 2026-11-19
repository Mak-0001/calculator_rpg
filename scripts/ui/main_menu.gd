extends CanvasLayer

signal carry_on;

@onready var buttonStart: Button = %btnStart
@onready var btn_quit: Button = $VBoxContainer/btnQuit
@onready var panel: Panel = $Panel
@onready var narrator_label: Label = $Panel/narrator_label
@onready var languages_container: OptionButton = $VBoxContainer/languages_container

var story_keys: Array[String] = ["STORY_1", "STORY_2", "STORY_3"];
var tween: Tween;
const CHAR_READ_RATE := 0.05;

func _on_button_pressed() -> void:
	$VBoxContainer.hide();
	panel.show();
	for key in story_keys:
		display_story(tr(key));
		await carry_on;
	MapMenager.go_to_level("res://scenes/world/lobby.tscn", "");

func _on_ready() -> void:
	panel.hide();
	btn_quit.pressed.connect(get_tree().quit);
	for i in GameMenager.available_languages.size():
		languages_container.add_item(GameMenager.available_languages[i], i);
	languages_container.selected = GameMenager.lang_index;
	languages_container.item_selected.connect(GameMenager.change_language);
	
func display_story(text: String):
	if(tween):
		tween.kill();
	tween = create_tween();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.finished.connect(set_process.bind(true))
	narrator_label.visible_characters = 0;
	narrator_label.text = text;
	tween.tween_property(\
	narrator_label, "visible_characters", \
	len(text), len(text) * CHAR_READ_RATE);

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("mouse"):
		carry_on.emit();
