extends Node2D

@export var velocity = 550
@export var grid: GridManager
@onready var camera = $Camera2D

@export var zoom_speed: float = 0.1
@export var zoom_smoothness: float = 0.2
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

var target_zoom: Vector2
var mouse_world_pre_zoom: Vector2

var x_bound = 0
var y_bound = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_zoom = camera.zoom
	x_bound = grid.cell_size[0] * grid.grid_size[0]
	y_bound = grid.cell_size[1] * grid.grid_size[1]
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var dir_x = Input.get_axis("ui_left", "ui_right")
	var dir_y = Input.get_axis("ui_up", "ui_down")
	
	self.translate(Vector2(dir_x * delta, dir_y * delta) * velocity)
	
	self.position.x = max(0, min(x_bound, self.position.x))
	self.position.y = max(0, min(y_bound, self.position.y))
	
	camera.zoom = lerp(camera.zoom, target_zoom, zoom_smoothness)
	
	
func _unhandled_input(event: InputEvent) -> void:
	var zoom_pos = 0
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_pos = get_global_mouse_position()
				_handle_zoom_out()
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_pos = get_global_mouse_position()
				_handle_zoom_in()
				
func _handle_zoom_in() -> void:
	_zoom_at_mouse(1.0 + zoom_speed)

func _handle_zoom_out() -> void:
	_zoom_at_mouse(1.0 - zoom_speed)

func _zoom_at_mouse(scale_factor: float) -> void:

	target_zoom = (target_zoom * scale_factor).clamp(Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
