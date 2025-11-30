extends Node2D

@onready var collider = $CollisionPolygon2D
@export var cell_size: float = 128
@export var radius_cells: float = 3
@export var color: Color = Color(0.73, 0.35, 0.11, 0.5)

var time_modifier = 0;
