extends AbilityScript;


static func main(source: Ability) -> int:
	var output: int = randi_range(source.min_damage, source.max_damage);
	BattleMenager.add_battle_log(source.ability_name + ": " + str(output));
	return output;
