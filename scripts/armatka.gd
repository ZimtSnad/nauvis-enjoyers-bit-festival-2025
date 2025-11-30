extends Node2D

@export var delay_between_shots := 2.0
@export var damage := 10
@export var health := 1000
@export var bullet_speed: float = 400.0
@export var bullet_scene: PackedScene

@onready var timer: Timer = $Timer

@onready var AnimatedSprite = $AnimatedSprite2D

var current_enemy: Node2D = null
var shooting: bool = false

func _ready() -> void:
	AnimatedSprite.play("idle")
	timer.one_shot = true
	timer.wait_time = delay_between_shots
	
	

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and current_enemy == null:
		print("enemy in range")
		current_enemy = body
		shoot_at_enemy(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == current_enemy:
		current_enemy = null


func _on_timer_timeout() -> void:
	pass


func shoot_at_enemy(body: Node) -> void:
	if shooting:
		return  # już strzelamy

	shooting = true
	
	while current_enemy != null and is_instance_valid(current_enemy):
		var enemy := current_enemy

		# upewniamy się, że wróg ma potrzebne zmienne
		if not ("enemy_type" in enemy) or not ("enemy_mod" in enemy):
			print("Enemy nie ma enemy_type / enemy_mod")
			break

		# wybierz typ amunicji pod tego wroga
		var ammo_type := AmmoStore.choose_ammo_for_enemy(enemy.enemy_type, enemy.enemy_mod)

		if ammo_type == -1:
			print("Brak odpowiedniej amunicji na tego robaka!")
			break

		# spróbuj zużyć 1 sztukę ammo
		if not AmmoStore.try_consume(ammo_type, 1):
			print("Wybrana amunicja się skończyła")
			break

		print("Strzelam ammo:", ammo_type, " pozostało:", AmmoStore.get_amount(ammo_type))

		# start animation
		AnimatedSprite.play("shoot")

		if bullet_scene == null:
			push_warning("bullet_scene nie ustawiony w Inspectorze!")
			break

		var bullet: Node2D = bullet_scene.instantiate()

		# start pocisku w miejscu turreta
		bullet.global_position = global_position

		# kierunek w stronę wroga
		var dir: Vector2 = (enemy.global_position - bullet.global_position).normalized()

		# przekaż parametry do bulletu
		bullet.direction = dir
		print("ammo_type: ", ammo_type)
		bullet.ammo_type = ammo_type

		get_tree().current_scene.add_child(bullet)
		#AnimatedSprite.stop()

	
		# zadaj obrażenia
		#enemy.health -= damage
		print("fire, dmg:", damage, " enemy hp:", enemy.health)

		#if enemy.health <= 0:
			#enemy.queue_free()
			#current_enemy = null
			#break

		# czekamy na kolejny strzał
		timer.start()
		await timer.timeout

	shooting = false
	
	
