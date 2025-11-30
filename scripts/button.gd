extends Button
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	#audio_stream_player_2d.play()
	get_tree().change_scene_to_file("res://levels/level1.tscn")
