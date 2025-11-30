extends Node2D


@export var grid: GridManager
@export var beacon_limit: int
@export var total_time = 1.0


@export var beacon_scene = preload("res://scenes/beacon.tscn")

var placed_beacons = 0

var beacons: Array = []
var beacon_matrix := []
var time_modfier_matrix := []

func _ready():

	for y in range(grid.grid_size[1]):
		var row := []
		var row2 := []
		for x in range(grid.grid_size[0]):
			row.append(null) 
			row2.append(0) 
		beacon_matrix.append(row)
		time_modfier_matrix.append(row2)
	

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if(placed_beacons < beacon_limit):
				place_at_cursor()
				update_time_modifiers()
				update_time_modifier_mat()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			delete_at_cursor()
			update_time_modifiers()
			update_time_modifier_mat()


func get_time_modifier_at_world(pos_world: Vector2) -> float:
	var pos_grid = grid.world_to_grid(pos_world)
	return time_modfier_matrix[pos_grid.x][pos_grid.y]
	
func update_time_modifier_mat():
	for y in range(grid.grid_size[1]):
		for x in range(grid.grid_size[0]):
			time_modfier_matrix[x][y] = 0
		
	for x in range(grid.grid_size[0]):
		for y in range(grid.grid_size[1]):
			for beacon in beacons:
				var beacon_grid_pos = grid.world_to_grid(beacon.position)
				if(pow(x - beacon_grid_pos.x,2) + pow(y - beacon_grid_pos.y, 2) < pow(beacon.radius_cells, 2) - 1):
					time_modfier_matrix[x][y] += beacon.time_modifier
	return
	


func update_time_modifiers():
	for beacon in beacons:
		beacon.time_modifier = total_time / placed_beacons

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
		
		
