extends Node2D

@export var delay_between_bite := 2.0
@export var damage := 10
@export var health := 100
@export var id := 1
@export var type := 1
@export var modifier := 1
@export var speed := 1.0

@onready var timer: Timer = $"../Timer"

var target: Node2D = null
var attacking: bool = false


func _ready() -> void:
	timer.one_shot = true
	timer.wait_time = delay_between_bite
	# opcjonalnie: add_to_group("enemies")
	# add_to_group("enemies")


func _process(delta: float) -> void:
	# tu możesz poruszać wroga (np. w stronę targetu)
	pass


# To powinno być podpięte do sygnału z Area2D:
# Enemy/Area2D.body_entered
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and target == null:
		target = body
		attack_loop()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		target = null


func _on_timer_timeout() -> void:
	# Nie musimy tu nic robić, bo używamy await timer.timeout
	pass


func attack_loop() -> void:
	if attacking:
		return
	attacking = true

	while target != null and is_instance_valid(target):
		# zadaj dmg
		if not target.has_variable("health"):
			break

		target.health -= damage
		print("enemy bite, dmg:", damage, " player hp:", target.health)

		if target.health <= 0:
			# gracz padł – przestajemy gryźć
			break

		# czekamy między ugryzieniami
		timer.start()
		await timer.timeout

	attacking = false
