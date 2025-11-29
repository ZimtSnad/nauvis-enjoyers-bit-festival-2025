extends Node2D

@onready var collider = $CollisionPolygon2D
@export var cell_size: float = 128
@export var radius: float = 72
@export var color: Color = Color(0.73, 0.35, 0.11, 0.5)

var time_modifier = 0;

func _ready():
	
	var collider_poly = generate_circle_collider(cell_size, cell_size*3)
	collider.polygon = collider_poly
	collider.position = Vector2(cell_size/2, cell_size/2)

func generate_circle_collider(cell_size: float, radius: float) -> PackedVector2Array:
	var half = cell_size / 2.0
	var max_offset = int(ceil(radius / cell_size))

	var border_points := []

	# 1. Collect all border cells
	for y in range(-max_offset, max_offset + 1):
		for x in range(-max_offset, max_offset + 1):
			var center = Vector2(x * cell_size + half, y * cell_size + half)

			var dist = center.length()

			# Border = within radius, but neighbors include some outside radius
			if dist <= radius:
				var neighbor_outside = false
				for ny in [-1, 0, 1]:
					for nx in [-1, 0, 1]:
						if nx == 0 and ny == 0:
							continue
						var n_center = Vector2((x + nx) * cell_size + half, (y + ny) * cell_size + half)
						if n_center.length() > radius:
							neighbor_outside = true
							break
					if neighbor_outside:
						break

				if neighbor_outside:
					border_points.append(center)

	# 2. Sort points by angle to form a clean polygon
	border_points.sort_custom(func(a, b): return a.angle() < b.angle())

	# 3. Convert to PackedVector2Array
	return PackedVector2Array(border_points)
