extends Area2D

class_name InteractArea
signal interact_now;
signal player_entered;

#var player_here : bool = false;
@onready var label: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMain:
		#player_here = true;
		set_process(true);
		player_entered.emit(); #można ominąć potwierdzenie interakcji

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerMain:
		#player_here = false
		set_process(false)
		label.hide();

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("interact")):
		interact_now.emit();

func interact_label_show():
	label.show();


func _on_ready() -> void:
	set_process(false);
