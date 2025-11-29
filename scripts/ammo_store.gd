extends Node
class_name Ammo_store

var ammo: Dictionary = {}


func _ready() -> void:
	# startowe ilości – tu możesz sobie zmieniać
	for t in Ammo_types.Type.values():
		ammo[t] = 0

	# przykład testowy:
	ammo[Ammo_types.Type.LIGHT_NONE] = 50
	ammo[Ammo_types.Type.MEDIUM_FIRE] = 10


func get_amount(ammo_type: Ammo_types.Type) -> int:
	return ammo.get(ammo_type, 0)


func add_ammo(ammo_type: Ammo_types.Type, amount: int) -> void:
	ammo[ammo_type] = ammo.get(ammo_type, 0) + amount


func try_consume(ammo_type: Ammo_types.Type, amount: int = 1) -> bool:
	var current := get_amount(ammo_type)
	if current >= amount:
		ammo[ammo_type] = current - amount
		return true
	return false
