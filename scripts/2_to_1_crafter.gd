extends Node2D

@export var first_generator : Area2D
@export var second_generator : Area2D

@onready var first_label = $"First input"
@onready var second_label = $"Second input"
@onready var output_label = $Output
@onready var first_timer = $"First timer"
@onready var second_timer = $"Second timer"
@onready var output_timer = $"Output timer"

var first_counter = 0
var second_counter = 0
var output_counter = 0

var time_scale = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_label.text = str(first_counter)
	second_label.text = str(second_counter)
	output_label.text = str(output_counter)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	first_label.text = str(first_counter)
	second_label.text = str(second_counter)
	output_label.text = str(output_counter)
	if time_scale != 0 && first_counter != 0 && second_counter != 0:
		output_timer.wait_time = time_scale
		if output_timer.is_stopped():
			output_timer.start()
	else :
		output_timer.stop()
	if first_generator.time_scale != 0 && first_generator.entered:
		first_timer.wait_time = first_generator.time_scale
		if first_timer.is_stopped():
			first_timer.start()
	else :
		output_timer.stop()
	if second_generator.time_scale != 0 && second_generator.entered:
		second_timer.wait_time = second_generator.time_scale
		if second_timer.is_stopped():
			second_timer.start()
	else :
		output_timer.stop()
	pass



func _on_first_timer_timeout() -> void:
	first_counter += 1
	pass # Replace with function body.


func _on_second_timer_timeout() -> void:
	second_counter += 1
	pass # Replace with function body.


func _on_output_timer_timeout() -> void:
	first_counter -= 1
	second_counter -= 1
	output_counter += 1
	pass # Replace with function body.
