extends GDScript;
class_name AbilityScript;

static func main(source: Ability) -> int:
	print(source.ability_name + ": " + str(source.min_damage));
	return source.min_damage;
