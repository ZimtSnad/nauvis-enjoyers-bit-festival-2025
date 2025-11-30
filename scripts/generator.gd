extends Node2D
@export var production_time : float = 1.0
@onready var timer = $Timer
@onready var output_label = $Output
@export var beacon_manager: Node2D
@onready var building_animator = $AnimationPlayer
@onready var progress_bar = $"Building sprite/HSlider"

@export var output_material_sprite: Texture
@onready var output_sprite_holder = $InputMaterialsGuiSingle/outputMaterialSpriteHolder/Sprite



var nodes_connected = 0
var resource_count = 0
var can_take = false

func increase_nodes():
	nodes_connected += 1

func decrease_resources():
	resource_count -= 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	output_sprite_holder.texture = output_material_sprite
	building_animator.speed_scale = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	output_label.text = str(resource_count)

	if not timer.is_stopped():
		progress_bar.value = ((timer.wait_time - timer.time_left) / timer.wait_time) * 100.0
	else:
		progress_bar.value = 0
		
	var beacon_time_multipier = beacon_manager.get_time_modifier_at_world(self.position)
	if beacon_time_multipier == 0 and not timer.is_stopped():
		timer.stop()
		building_animator.speed_scale = 0
	elif beacon_time_multipier != 0 and timer.is_stopped():
		timer.wait_time = (1 / beacon_time_multipier) * production_time
		timer.start()
		building_animator.speed_scale = (1/timer.wait_time) * 6
	elif beacon_time_multipier != 0 :
		timer.wait_time = (1 / beacon_time_multipier) * production_time
		building_animator.speed_scale = (1/timer.wait_time) * 6

		
	if resource_count >= nodes_connected:
		can_take = true
	else:
		can_take = false
	pass


func _on_resource_timer_timeout() -> void:
	resource_count += 1
	pass # Replace with function body.
