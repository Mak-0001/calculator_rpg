extends AbilityScript;


static func main(_source: Ability) -> int:
	print("coward");
	BattleMenager.add_battle_log("coward");
	SignalBus.battle_to_end.emit()
	return ability_type.SPECIAL;
