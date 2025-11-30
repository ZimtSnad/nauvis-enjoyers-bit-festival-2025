extends Node2D
@export var production_time : float = 1.0
@onready var timer = $Timer
@onready var output_label = $Output
@export var beacon_manager: Node2D

var nodes_connected = 0
var resource_count = 0
var can_take = false

func increase_nodes():
	nodes_connected += 1

func decrease_resources():
	resource_count -= 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	output_label.text = str(resource_count)
	
	var beacon_time_multipier = beacon_manager.get_time_modifier_at_world(self.position)
	if beacon_time_multipier == 0 and not timer.is_stopped():
		timer.stop()
	elif beacon_time_multipier != 0 and timer.is_stopped():
		timer.wait_time = (1 / beacon_time_multipier) * production_time
		timer.start()
	elif beacon_time_multipier != 0 :
		timer.wait_time = (1 / beacon_time_multipier) * production_time
	if resource_count >= nodes_connected:
		can_take = true
	else:
		can_take = false
	pass


func _on_resource_timer_timeout() -> void:
	resource_count += 1
	pass # Replace with function body.
