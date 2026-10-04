extends AbilityScript;

func main(_source: Ability) -> int:
	print("coward");
	SignalBus.battle_to_end.emit()
	return 0;
