extends Node2D

@export var velocity = 550
@export var grid: GridManager
@onready var camera = $Camera2D

@export var zoom_speed: float = 0.1
@export var zoom_smoothness: float = 0.2
@export var move_smoothness: float = 0.2
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

var target_pos: Vector2
var target_zoom: Vector2
var mouse_world_pre_zoom: Vector2

var x_bound = 0
var y_bound = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_zoom = camera.zoom
	target_pos = self.position
	x_bound = grid.cell_size[0] * grid.grid_size[0]
	y_bound = grid.cell_size[1] * grid.grid_size[1]
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var dir_x = Input.get_axis("left", "right")
	var dir_y = Input.get_axis("up", "down")
	target_pos += Vector2(dir_x * delta, dir_y * delta) * velocity * (Vector2(1, 1)/camera.zoom)

	target_pos = clamp(target_pos, Vector2(0, 0), Vector2(x_bound, y_bound))

	self.position = lerp(self.position, target_pos, move_smoothness)
	
	if(pow((camera.zoom.x - target_zoom.x), 2) + pow((camera.zoom.y - target_zoom.y), 2) < 0.001):
		target_zoom = camera.zoom
	
	if(camera.zoom != target_zoom):
		mouse_world_pre_zoom = get_global_mouse_position()
		camera.zoom = lerp(camera.zoom,target_zoom, zoom_smoothness)
		self.position -= (get_global_mouse_position() - mouse_world_pre_zoom)
		self.target_pos -= (get_global_mouse_position() - mouse_world_pre_zoom)
	
		
	
	
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
