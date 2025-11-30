extends Node
class_name Ammo_store

var ammo: Dictionary = {}


const SPECIAL_MODS := [
	Enemy_modifiers.Mod.ICE,
	Enemy_modifiers.Mod.TOXIC,
	Enemy_modifiers.Mod.FIRE,
	Enemy_modifiers.Mod.VOID,
]

func _ready() -> void:
	# startowe ilości – tu możesz sobie zmieniać
	for t in Ammo_types.Type.values():
		ammo[t] = 0

	# przykład testowy:
	ammo[Ammo_types.Type.LIGHT_NONE] = 100
	#ammo[Ammo_types.Type.MEDIUM_FIRE] = 10
	ammo[Ammo_types.Type.MEDIUM_NONE] = 1
	#ammo[Ammo_types.Type.HEAVY_FIRE] = 2


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


func choose_ammo_for_enemy(enemy_type: Enemy_types.Type, enemy_mod: Enemy_modifiers.Mod) -> Ammo_types.Type:
	var size_priority: Array = []

	# ustalamy jakie ROZMIARY ammo wolno użyć dla danego typu robaka
	match enemy_type:
		Enemy_types.Type.LIGHT:
			size_priority = [Enemy_types.Type.LIGHT, Enemy_types.Type.MEDIUM, Enemy_types.Type.HEAVY]
		Enemy_types.Type.MEDIUM:
			size_priority = [Enemy_types.Type.MEDIUM, Enemy_types.Type.HEAVY]
		Enemy_types.Type.HEAVY:
			size_priority = [Enemy_types.Type.HEAVY]

	# 1) jeśli robak ma specjalny typ (ICE/TOXIC/FIRE/VOID) → używamy TYLKO tej specjalnej amunicji
	if enemy_mod != Enemy_modifiers.Mod.NONE:
		for size in size_priority:
			var ammo_type := Ammo_types.get_type(size, enemy_mod)
			if get_amount(ammo_type) > 0:
				return ammo_type
		# brak odpowiedniej specjalnej amunicji
		return -1  # brak ammo

	# 2) jeśli robak ma typ NONE → najpierw zwykłe (NONE), potem specjalne

	# 2a) najpierw zwykła amunicja: NONE
	for size in size_priority:
		var normal_ammo := Ammo_types.get_type(size, Enemy_modifiers.Mod.NONE)
		if get_amount(normal_ammo) > 0:
			return normal_ammo

	# 2b) jak nie ma zwykłej → specjalne:
	# "specjal light, jak nie to specjal medium, jak nie to specjal heavy"
	for size in size_priority:
		for mod in SPECIAL_MODS:
			var special_ammo := Ammo_types.get_type(size, mod)
			if get_amount(special_ammo) > 0:
				return special_ammo

	# 2c) nic nie znaleziono
	return -1
