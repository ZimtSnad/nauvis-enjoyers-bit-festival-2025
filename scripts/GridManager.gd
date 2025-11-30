class_name GridManager
extends Node

@export var cell_size: Vector2 = Vector2(32, 32)
@export var grid_size: Vector2 = Vector2(10, 10)



func world_to_grid(pos: Vector2) -> Vector2i:
	return Vector2i(
		floor(pos.x / cell_size.x),
		floor(pos.y / cell_size.y)
	)

func grid_to_world(cell: Vector2i) -> Vector2:
	return Vector2(
		cell.x * cell_size.x + cell_size.x / 2,
		cell.y * cell_size.y + cell_size.y / 2
	)

func is_inside_grid(cell: Vector2i) -> bool:
	if (cell.x >= 0 and cell.y >= 0 and cell.x < grid_size.x and cell.y < grid_size.y):
		return true
		
	return false
