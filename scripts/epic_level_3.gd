extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy = get_tree().get_nodes_in_group("enemies")
	if enemy.is_empty():
		var new_scene = load("res://scenes/endscreen.tscn")
		get_tree().change_scene_to_packed(new_scene)
	pass
