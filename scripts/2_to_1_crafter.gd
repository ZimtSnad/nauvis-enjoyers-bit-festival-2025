extends Node2D

@export var first_generator : Area2D
@export var second_generator : Area2D
@export var time_scale : float = 2.0
@export var first_resource_cost : int = 1
@export var second_resource_cost : int = 1

@onready var first_label = $"First input"
@onready var second_label = $"Second input"
@onready var output_label = $Output
@onready var timer = $Timer

var first_counter = 0
var second_counter = 0
var output_counter = 0
var colliding = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_generator.increase_nodes()
	second_generator.increase_nodes()
	pass # Replace with function body.

func can_craft():
	if first_counter >= first_resource_cost && second_counter >= second_resource_cost:
		output_counter += 1
		first_counter -= first_resource_cost
		second_counter -= second_resource_cost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	first_label.text = str(first_counter)
	second_label.text = str(second_counter)
	output_label.text = str(output_counter)
	if first_generator.can_take:
		first_counter += 1
		first_generator.decrease_resources()
	if second_generator.can_take:
		second_counter += 1
		second_generator.decrease_resources()
	pass


func _on_area_entered(area: Area2D) -> void:
	timer.wait_time = time_scale
	timer.start()
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	timer.stop()
	pass # Replace with function body.

func _on_output_timer_timeout() -> void:
	can_craft()
	pass # Replace with function body.
