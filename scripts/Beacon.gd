extends Node2D

@export var cell_size: float = 24
@export var radius: float = 72
@export var color: Color = Color(0.73, 0.35, 0.11, 0.5)

var time_modifier = 0;

func _ready():
	
	var collider_poly = generate_circle_collider(32, 32*2)
	
	# Draw Polygon2D to visualize
	var poly = Polygon2D.new()
	poly.polygon = collider_poly
	poly.color = color
	add_child(poly)

func generate_circle_collider(cell_size: float, radius: float) -> PackedVector2Array:
	var half = cell_size / 2.0
	var max_offset = int(ceil(radius / cell_size))
	var points := []
	
	# Iterate the grid in a clockwise fashion to generate a simple outline
	for angle_deg in range(0, 360, 5):
		var angle = deg_to_rad(angle_deg)
		var x = round(cos(angle) * radius / cell_size) * cell_size + half
		var y = round(sin(angle) * radius / cell_size) * cell_size + half
		points.append(Vector2(x, y))
	
	return PackedVector2Array(points)
