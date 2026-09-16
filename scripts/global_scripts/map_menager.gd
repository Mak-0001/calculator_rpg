extends Node;

signal room_changed;
signal progress_changed(progress: float);

var use_subthreads: bool = true;
var scene_path: String;
var progress: Array = [];

func _on_ready() -> void:
	set_process(false);
	room_changed.connect(TransitionScript._on_load_finished);
	progress_changed.connect(TransitionScript._on_progress_changed);

func go_to_level(_scene_path: String, door_tag: String = ""):
	TransitionScript.fade_in(Color(0,0,255));
	await TransitionScript.fade_in_complete;
	scene_path = _scene_path;
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_subthreads);
	
	#door_tag prześlij do GameMenager
	if state == OK:
		set_process(true);
	
func _process(delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress);
	progress_changed.emit(progress[0]);
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false);
		ResourceLoader.THREAD_LOAD_LOADED:
			var loaded = ResourceLoader.load_threaded_get(scene_path);
			TransitionScript.fade_out(Color(0,0,255));
			get_tree().change_scene_to_packed(loaded);
