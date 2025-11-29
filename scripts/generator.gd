extends Area2D
@export var time_scale : float = 1.0
@onready var timer = $Timer
@onready var output_label = $Output

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
	if resource_count >= nodes_connected:
		can_take = true
	else:
		can_take = false
	pass


func _on_area_entered(area: Area2D) -> void:
	timer.wait_time = time_scale
	timer.start()
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	timer.stop()
	pass # Replace with function body.
	

func _on_resource_timer_timeout() -> void:
	resource_count += 1
	pass # Replace with function body.
