extends Node;

@warning_ignore_start("unused_signal")

signal room_changed(pos: Vector2, dir: int);

#region battle signals
signal battle_to_start(enemy: Enemy);
signal battle_started();
signal battle_to_end();
#endregion


@warning_ignore_restore("unused_signal")
