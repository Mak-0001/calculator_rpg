extends GDScript;
class_name AbilityScript;

enum ability_type {SKIP_TURN = -10, SPECIAL = -1}

static func main(source: Ability) -> int:
	BattleMenager.add_battle_log(source.ability_name + ": " + str(source.min_damage));
	print(source.ability_name + ": " + str(source.min_damage));
	return source.min_damage;
