extends Resource;
class_name Ability;

@export var ability_name: String;
@export var ability_cost: int = 1;
@export_category("akcja")
@export var min_damage: int;
@export var max_damage: int;
@export var extra: Dictionary;
@export var ability_script: Script;

func ability_main() -> int:
	if(ability_script):
		return ability_script.main(self);
	else:
		return AbilityScript.main(self);
