extends Object;
class_name AbilityScript;

func main(source: Ability) -> int:
	print(source.ability_name + ": " + str(source.min_damage));
	return 0;
