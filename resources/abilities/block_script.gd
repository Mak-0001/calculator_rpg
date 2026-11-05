extends AbilityScript;


static func main(source: Ability) -> int:
	var user: Entity = BattleMenager.nodes_in_battle[BattleMenager.turn_index];
	user.block += source.extra.get("block_amount", 0);
	BattleMenager.add_battle_log(source.ability_name + ": +" + str(source.extra.get("block_amount", 0)));
	return ability_type.SPECIAL;
