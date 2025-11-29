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
	print("body.is_in_group('enemies'): ", body.is_in_group("enemies"))
	print("current_enemy == null: ", current_enemy == null)
	print("body: ", body.get_groups())
	if body.is_in_group("enemies") and current_enemy == null:
	#if  current_enemy == null:
		print("enemy in range")
		current_enemy = body
		shoot_at_enemy()


func _on_area_2d_body_exited(body: Node2D) -> void:
	# jeśli obecny cel wyszedł z zasięgu, przestajemy go atakować
	if body == current_enemy:
		current_enemy = null


func _on_timer_timeout() -> void:
	# Nie musimy tu nic robić, obsługujemy timeout przez `await`
	pass


func shoot_at_enemy() -> void:
	if shooting:
		return  # już strzelamy

	shooting = true

	while current_enemy != null and is_instance_valid(current_enemy):
		# zadaj obrażenia:
		#if not current_enemy.has_method("health"):
			#print("bezpieczenstwo")
			#break  # dla bezpieczeństwa

		current_enemy.health -= damage
		print("fire, dmg:", damage, " enemy hp:", current_enemy.health)

		if current_enemy.health <= 0:
			current_enemy.queue_free()
			current_enemy = null
			break

		# czekamy na timer (cooldown między strzałami)
		timer.start()
		await timer.timeout

	shooting = false
