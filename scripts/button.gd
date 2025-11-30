extends Area2D

@export var speed: float = 400.0
@export var damage: int = 10
@export var ammo_type: int = 0

var direction: Vector2 = Vector2.ZERO

@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	match ammo_type:
		0:
			sprite.texture = preload("res://assets/sprites/bullet/LIGHT_NONE_BULLET.png")
		1:
			sprite.texture = preload("res://assets/sprites/bullet/LIGHT_ICE_BULLET.png")
		2:
			sprite.texture = preload("res://assets/sprites/bullet/LIGHT_TOXIC_BULLET.png")
		3:
			sprite.texture = preload("res://assets/sprites/bullet/LIGHT_FIRE_BULLET.png")
		4:
			sprite.texture = preload("res://assets/sprites/bullet/LIGHT_VOID_BULLET.png")
		5:
			sprite.texture = preload("res://assets/sprites/bullet/MEDIUM_NONE_BULLET.png")
		6:
			sprite.texture = preload("res://assets/sprites/bullet/MEDIUM_ICE_BULLET.png")
		7:
			sprite.texture = preload("res://assets/sprites/bullet/MEDIUM_TOXIC_BULLET.png")
		8:
			sprite.texture = preload("res://assets/sprites/bullet/MEDIUM_FIRE_BULLET.png")
		9:
			sprite.texture = preload("res://assets/sprites/bullet/MEDIUM_VOID_BULLET.png")
		10:
			sprite.texture = preload("res://assets/sprites/bullet/HEAVY_NONE_BULLET.png")
		11:
			sprite.texture = preload("res://assets/sprites/bullet/HEAVY_ICE_BULLET.png")
		12:
			sprite.texture = preload("res://assets/sprites/bullet/HEAVY_TOXIC_BULLET.png")
		13:
			sprite.texture = preload("res://assets/sprites/bullet/HEAVY_FIRE_BULLET.png")
		14:
			sprite.texture = preload("res://assets/sprites/bullet/HEAVY_VOID_BULLET.png")

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: CharacterBody2D) -> void:
	print("pocisk dotknal")
	if body.is_in_group("enemies"):
		print("pocisk dotknal enemy")
		if body.has_method("take_damage"):
			body.take_damage(damage)
		elif "health" in body:
			body.health -= damage
			if body.health <= 0:
				body.queue_free()
		queue_free()
