extends Node2D

@export var grid_manager: GridManager
@export var grid_color: Color = Color(1, 1, 1, 0.1)


func _draw():
	if grid_manager == null:
		return
	var s = grid_manager.cell_size

	for x in range(grid_manager.grid_size.x + 1):
		draw_line(Vector2(x * s.x, 0), Vector2(x * s.x, grid_manager.grid_size.y * s.y), grid_color)
	for y in range(grid_manager.grid_size.y + 1):
		draw_line(Vector2(0, y * s.y), Vector2(grid_manager.grid_size.x * s.x, y * s.y), grid_color)
