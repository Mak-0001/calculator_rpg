extends Node;

signal room_changed;
signal progress_changed(progress: float);

var use_subthreads: bool = true;
var scene_path: String;
var dest_door: String;
var progress: Array = [];

func _on_ready() -> void:
	set_process(false);
	room_changed.connect(TransitionScript._on_load_finished);
	progress_changed.connect(TransitionScript._on_progress_changed);

func go_to_level(_scene_path: String, door_tag: String = "") -> void:
	TransitionScript.fade_in(Color(0,0,255));
	await TransitionScript.fade_in_complete;
	scene_path = _scene_path;
	dest_door = door_tag;
	
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_subthreads);
	
	if state == OK:
		set_process(true);
	
func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress);
	progress_changed.emit(progress[0]);
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false);
			#dodaj print błędu
		ResourceLoader.THREAD_LOAD_LOADED:
			var loaded = ResourceLoader.load_threaded_get(scene_path);
			#await TransitionScript.show_folder_complete;
			get_tree().change_scene_to_packed(loaded);
			TransitionScript.show_folder("dir_placeholder");
			await get_tree().create_timer(0.5).timeout;
			TransitionScript.fade_out(Color(0,0,255));
