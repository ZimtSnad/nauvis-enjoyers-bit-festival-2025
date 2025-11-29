extends Node2D

@export var delay_between_bite := 2.0
@export var damage := 10
@export var health := 100
@export var speed := 10.0
@export var attack_range := 30.0
@export var turret_path: NodePath 

@onready var timer: Timer = $Timer
@onready var turret: Node2D = get_node(turret_path)

var attacking: bool = false


func _ready() -> void:
	timer.one_shot = true
	timer.wait_time = delay_between_bite
	add_to_group("enemies")


func _physics_process(delta: float) -> void:
	if turret == null or !is_instance_valid(turret):
		return

	# jeśli już atakuje – nie ruszamy go
	if attacking:
		return

	# dystans do turreta
	var dist := global_position.distance_to(turret.global_position)

	if dist > attack_range:
		# idź w stronę turreta
		var dir := (turret.global_position - global_position).normalized()
		global_position += dir * speed * delta
	else:
		# jesteśmy wystarczająco blisko – zaczynamy atak
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

		# czekamy między ugryzieniami
		timer.start()
		await timer.timeout

	attacking = false
