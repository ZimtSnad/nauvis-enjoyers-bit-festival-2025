extends Node2D

@export var first_generator : Node2D
@export var second_generator : Node2D
@export var production_time : float = 2.0
@export var first_resource_cost : int = 1
@export var second_resource_cost : int = 1
@export var beacon_manager: Node2D

@onready var first_label = $"gui/Top cloud/First input"
@onready var second_label = $"gui/Top cloud/Second input"
@onready var output_label = $"gui/Bot cloud/Output"
@onready var timer = $Timer
@onready var building_animator = $"Building animation"
@onready var progress_bar = $"Building sprite/HSlider"

var first_counter = 0
var second_counter = 0
var output_counter = 0
var colliding = false
var can_take = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	building_animator.speed_scale = 0
	first_generator.increase_nodes()
	second_generator.increase_nodes()
	pass # Replace with function body.

func take():
	if can_take:
		output_counter -= 1

func can_craft():
	if first_counter >= first_resource_cost && second_counter >= second_resource_cost:
		output_counter += 1
		can_take = true
		first_counter -= first_resource_cost
		second_counter -= second_resource_cost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not timer.is_stopped():
		print(timer)
		progress_bar.value = ((timer.wait_time - timer.time_left) / timer.wait_time) * 100.0
	else:
		progress_bar.value = 0
	
	
	first_label.text = str(first_counter)
	second_label.text = str(second_counter)
	output_label.text = str(output_counter)
	var beacon_time_multipier = beacon_manager.get_time_modifier_at_world(self.position)
	if beacon_time_multipier == 0 and not timer.is_stopped():
		building_animator.speed_scale = 0
		timer.stop()
	elif beacon_time_multipier != 0 and timer.is_stopped():
		timer.wait_time = (1 / beacon_time_multipier) * production_time
		timer.start()
		building_animator.speed_scale = (1/timer.wait_time) * 6
	elif beacon_time_multipier != 0 :
		timer.wait_time = (1 / beacon_time_multipier) * production_time
		building_animator.speed_scale = (1/timer.wait_time) * 6
		
		
	if output_counter <= 0:
		can_take = false
	if first_generator.can_take:
		first_counter += 1
		first_generator.decrease_resources()
	if second_generator.can_take:
		second_counter += 1
		second_generator.decrease_resources()
	pass


func _on_area_entered(area: Area2D) -> void:
	timer.wait_time = production_time
	timer.start()
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	timer.stop()
	pass # Replace with function body.

func _on_output_timer_timeout() -> void:
	can_craft()
	pass # Replace with function body.
