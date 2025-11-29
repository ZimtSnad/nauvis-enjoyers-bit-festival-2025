extends Node2D

@export var delay_between_shots := 2.0
@export var damage := 10
@export var health := 1000

@onready var timer: Timer = $Timer

var current_enemy: Node2D = null
var shooting: bool = false

func _ready() -> void:
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
	# jeśli obecny cel wyszedł z zasięgu, przestajemy go atakować
	if body == current_enemy:
		current_enemy = null


func _on_timer_timeout() -> void:
	# Nie musimy tu nic robić, obsługujemy timeout przez `await`
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

		# zadaj obrażenia
		enemy.health -= damage
		print("fire, dmg:", damage, " enemy hp:", enemy.health)

		if enemy.health <= 0:
			enemy.queue_free()
			current_enemy = null
			break

		# czekamy na kolejny strzał
		timer.start()
		await timer.timeout

	shooting = false
	
	
	
	
	#var ammo_type := Ammo_store.choose_ammo_for_enemy(enemy.enemy_type, enemy.enemy_mod)
	#
	#if ammo_type == -1:
		#print("Brak odpowiedniej amunicji na tego robaka!")
		#return
#
	## próbujemy zużyć 1 sztukę ammo
	#if not Ammo_store.try_consume(ammo_type, 1):
		#print("Wybrana amunicja się skończyła (race condition)")
		#return
#
	#print("Strzelam ammo:", ammo_type, " pozostało:", Ammo_store.get_amount(ammo_type))
	#
#
	#while current_enemy != null and is_instance_valid(current_enemy):
		## zadaj obrażenia:
		##if not current_enemy.has_method("health"):
			##print("bezpieczenstwo")
			##break  # dla bezpieczeństwa
#
		#current_enemy.health -= damage
		#print("fire, dmg:", damage, " enemy hp:", current_enemy.health)
#
		#if current_enemy.health <= 0:
			#current_enemy.queue_free()
			#current_enemy = null
			#break
#
		## czekamy na timer (cooldown między strzałami)
		#timer.start()
		#await timer.timeout
#
	#shooting = false
