extends Node2D

@export var enemy_type: Enemy_types.Type = Enemy_types.Type.LIGHT
@export var enemy_mod: Enemy_modifiers.Mod = Enemy_modifiers.Mod.NONE

var health: int
var damage: int
var speed: float
var delay_between_bite: float
var attack_range: float

@export var turret_path: NodePath 

@onready var timer: Timer = $Timer
@onready var turret: Node2D = get_node(turret_path)

@onready var AnimatedSprite = $AnimatedSprite2D

@onready var BOOM = $BOOM
@onready var RUN = $RUN

var attacking: bool = false


func _ready() -> void:
	RUN.play()
	AnimatedSprite.play("loop_L_N")
	var base = Enemy_types.BASE_DATA[enemy_type]
	var mod = Enemy_modifiers.MOD_DATA[enemy_mod]
	type_and_mod_textures(enemy_type, enemy_mod)

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

func take_damage(amount: int) -> void:
	health -= amount
	print("enemy took dmg:", amount, "hp:", health)
	if health <= 0:
		RUN.stop()
		BOOM.play()
		AnimatedSprite.play("BOOM")


func die() -> void:
	queue_free()

func type_and_mod_textures(size: Enemy_types.Type, mod: Enemy_modifiers.Mod) -> void:
	match size:
		Enemy_types.Type.LIGHT:
			match mod:
				Enemy_modifiers.Mod.NONE: AnimatedSprite.play("loop_L_N")
				Enemy_modifiers.Mod.ICE: AnimatedSprite.play("loop_L_I")
				Enemy_modifiers.Mod.TOXIC: AnimatedSprite.play("loop_L_T")
				Enemy_modifiers.Mod.FIRE: AnimatedSprite.play("loop_L_F")
				Enemy_modifiers.Mod.VOID: AnimatedSprite.play("loop_L_V")

		Enemy_types.Type.MEDIUM:
			match mod:
				Enemy_modifiers.Mod.NONE: AnimatedSprite.play("loop_M_N")
				Enemy_modifiers.Mod.ICE: AnimatedSprite.play("loop_M_I")
				Enemy_modifiers.Mod.TOXIC: AnimatedSprite.play("loop_M_T")
				Enemy_modifiers.Mod.FIRE: AnimatedSprite.play("loop_M_F")
				Enemy_modifiers.Mod.VOID: AnimatedSprite.play("loop_M_V")

		#Enemy_types.Type.HEAVY:
			#match mod:
				#Enemy_modifiers.Mod.NONE: AnimatedSprite.play("loop_H_N")
				#Enemy_modifiers.Mod.ICE: AnimatedSprite.play("loop_H_I")
				#Enemy_modifiers.Mod.TOXIC: AnimatedSprite.play("loop_H_T")
				#Enemy_modifiers.Mod.FIRE: AnimatedSprite.play("loop_H_F")
				#Enemy_modifiers.Mod.VOID: AnimatedSprite.play("loop_H_V")


func _on_animated_sprite_2d_animation_finished() -> void:
	die()
