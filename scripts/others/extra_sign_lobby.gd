extends Sprite2D

@export var interact_area: InteractArea;
var counter: int = 0;
var dialog: Array[String] = [
	"01001101 00100110 01001101","Sorry, I am not used to your language.",
	"Ahhh! You found my Easter Egg!",
	"This is hidden dialog for You,\nmy dearest Player",
	"....",
]
var exhausted: bool = false


func _on_ready() -> void:
	if(!interact_area):
		return
	interact_area.interact_now.connect(func():
		interact_area.label.text = "It's all I had to say" if exhausted else dialog[counter];
		counter = min(counter + 1, dialog.size() - 1);
		interact_area.interact_label_show();
		);
	interact_area.player_entered.connect(func(): 
		interact_area.label.text = ">interact";
		interact_area.interact_label_show();
		);
	interact_area.player_exited.connect(func():
		if(counter == dialog.size() - 1):
			exhausted = true;
		)
