extends Resource;
class_name Ability;

@export var ability_name: String;
@export var ability_cost: int = 1;
@export_category("akcja")
@export var min_damage: int;
@export var max_damage: int;
@export var extra: Dictionary;
@export var ability_script: Script;

var attack_instance: Object;

func ability_main() -> int:
	attack_instance = Object.new();
	if(ability_script):
		attack_instance.set_script(ability_script);
	else:
		attack_instance.set_script(AbilityScript.new().get_script());
	var output: int = (attack_instance as AbilityScript).main(self);
	return output;
