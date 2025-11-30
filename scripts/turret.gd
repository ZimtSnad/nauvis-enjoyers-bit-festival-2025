extends Node2D

@export var delay_between_shots := 2.0
@export var damage := 10
@export var health := 1000

@onready var timer: Timer = $Timer
@onready var raycast : RayCast2D = $RayCast2D

var current_enemy: Node2D = null
var shooting: bool = false
var body

func _ready() -> void:
	timer.wait_time = delay_between_shots

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		body = raycast.get_collider()
		#body = colider.get_parent()
		if  body != null && body.is_in_group("enemies"):
			current_enemy = body
			if timer.is_stopped():
				timer.start()
		else:
			current_enemy = null
			timer.stop()
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and current_enemy == null:
		print("enemy in range")
		current_enemy = body
		timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	# jeśli obecny cel wyszedł z zasięgu, przestajemy go atakować
	timer.stop()


func _on_timer_timeout() -> void:
	shoot_at_enemy(body)
	# Nie musimy tu nic robić, obsługujemy timeout przez `await`
	pass


func shoot_at_enemy(body: Node) -> void:
	var enemy := current_enemy

	# upewniamy się, że wróg ma potrzebne zmienne
	if not ("enemy_type" in enemy) or not ("enemy_mod" in enemy):
		print("Enemy nie ma enemy_type / enemy_mod")
		return

	# wybierz typ amunicji pod tego wroga
	var ammo_type := AmmoStore.choose_ammo_for_enemy(enemy.enemy_type, enemy.enemy_mod)

	if ammo_type == -1:
		print("Brak odpowiedniej amunicji na tego robaka!")
		return

	# spróbuj zużyć 1 sztukę ammo
	if not AmmoStore.try_consume(ammo_type, 1):
		print("Wybrana amunicja się skończyła")
		return

	print("Strzelam ammo:", ammo_type, " pozostało:", AmmoStore.get_amount(ammo_type))

	# zadaj obrażenia
	enemy.health -= damage
	print("fire, dmg:", damage, " enemy hp:", enemy.health)

	if enemy.health <= 0:
		enemy.queue_free()
		#current_enemy = null
		timer.stop()

	# czekamy na kolejny strzał
	
