extends Area2D

class_name InteractArea
signal player_entered;
signal player_interact;
signal interact_now;
signal player_exited;

#var player_here : bool = false;
@onready var label: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerMain:
		#player_here = true;
		set_process(true);
		player_entered.emit(); #można ominąć warunek interakcji
		if(GameMenager.playerNode.can_interact):
			player_interact.emit(); #można ominąć potwierdzenie interacji

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerMain:
		#player_here = false
		set_process(false)
		label.hide();
		player_exited.emit();

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("interact")):
		if(GameMenager.playerNode.can_interact):
			interact_now.emit();

func interact_label_show():
	label.show();


func _on_ready() -> void:
	set_process(false);
