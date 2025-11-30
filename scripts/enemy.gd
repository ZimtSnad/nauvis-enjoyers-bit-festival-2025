extends Node2D

@export var enemy_type: Enemy_types.Type = Enemy_types.Type.LIGHT
@export var enemy_mod: Enemy_modifiers.Mod = Enemy_modifiers.Mod.NONE
@export var texture : Texture2D
@onready var sprite = $Sprite2D

var health: int
var damage: int
var speed: float
var delay_between_bite: float
var attack_range: float

@export var turret_path: NodePath 

@onready var timer: Timer = $Timer
@onready var turret: Node2D = get_node(turret_path)

var attacking: bool = false


func _ready() -> void:
	var base = Enemy_types.BASE_DATA[enemy_type]
	var mod = Enemy_modifiers.MOD_DATA[enemy_mod]
	sprite.texture = texture

	health = int(base["health"] * mod["health_mult"])
	damage = int(base["damage"] * mod["damage_mult"])
	speed = base["speed"] * mod["speed_mult"]

	delay_between_bite = base["delay_between_bite"] * mod["delay_mult"]
	attack_range = base["attack_range"] * mod["range_mult"]

	print("=== Enemy config ===")
	print("Type:", enemy_type, " Mod:", enemy_mod)
	print("HP:", health)
	print("DMG:", damage)
	print("SPD:", speed)
	print("DELAY:", delay_between_bite)
	print("RANGE:", attack_range)
	
	timer.one_shot = true
	timer.wait_time = delay_between_bite
	add_to_group("enemies")


func _physics_process(delta: float) -> void:
	if turret == null or !is_instance_valid(turret):
		return

	if attacking:
		return

	var dist := global_position.distance_to(turret.global_position)

	if dist > attack_range:
		var dir := (turret.global_position - global_position).normalized()
		global_position += dir * speed * delta
	else:
		attack_turret()


func attack_turret() -> void:
	if attacking:
		return
	attacking = true

	while turret != null and is_instance_valid(turret):
		# upewniamy się, że turret ma zdrowie
		#if not turret.has_variable("health"):
			#break

		turret.health -= damage
		print("enemy hits turret, dmg:", damage, " turret hp:", turret.health)

		if turret.health <= 0:
			print("turret destroyed")
			# możesz np.:
			# turret.queue_free()
			break

		timer.start()
		await timer.timeout

	attacking = false
