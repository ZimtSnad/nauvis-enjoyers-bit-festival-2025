extends Node2D


@export var grid: GridManager
@export var beacon_limit: int
# Called when the node enters the scene tree for the first time.


@export var beacon_scene = preload("res://scenes/beacon.tscn")

var placed_beacons = 0

var beacons: Array = []
var beacon_matrix := []

func _ready():
	for y in range(grid.grid_size[0]):
		var row := []
		for x in range(grid.grid_size[1]):
			row.append(null)  # no object yet
		beacon_matrix.append(row)
	

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if(placed_beacons < beacon_limit):
				place_at_cursor()
				update_time_modifiers()
			print("beacons currently placed: " + str(placed_beacons))
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			delete_at_cursor()
			update_time_modifiers()
			print("beacons currently placed: " + str(placed_beacons))
			
			

func update_time_modifiers():
	for beacon in beacons:
		beacon.time_modifier = 0.5

func place_at_cursor():
	# Get the mouse position in world coordinates
	var mouse_pos = get_global_mouse_position()

	# Convert to grid coordinates
	var cell = grid.world_to_grid(mouse_pos)
	
	if(not grid.is_inside_grid(cell)):
		return

	# Convert back to world position (snapped to center of grid)
	var snapped_pos = grid.grid_to_world(cell) - (grid.cell_size / 2)

	# Instantiate the object and place it
	if beacon_scene and beacon_matrix[cell.x][cell.y] == null:
		var obj = beacon_scene.instantiate()
		obj.position = snapped_pos
		add_child(obj)
		beacons.append(obj)
		beacon_matrix[cell.x][cell.y] = obj
		placed_beacons += 1


func delete_at_cursor():


	# Get the mouse position in world coordinates
	var mouse_pos = get_global_mouse_position()

	# Convert to grid coordinates
	var cell = grid.world_to_grid(mouse_pos)
	
	if(not grid.is_inside_grid(cell)):
		return

	
	if beacon_matrix[cell.x][cell.y] != null:
		beacons.erase(beacon_matrix[cell.x][cell.y])
		remove_child(beacon_matrix[cell.x][cell.y])
		beacon_matrix[cell.x][cell.y] = null;
		
		placed_beacons -= 1
		
		
