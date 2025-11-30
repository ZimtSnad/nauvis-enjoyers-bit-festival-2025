extends Object
class_name Ammo_types

enum Type {
	LIGHT_NONE,
	LIGHT_ICE,
	LIGHT_TOXIC,
	LIGHT_FIRE,
	LIGHT_VOID,

	MEDIUM_NONE,
	MEDIUM_ICE,
	MEDIUM_TOXIC,
	MEDIUM_FIRE,
	MEDIUM_VOID,

	HEAVY_NONE,
	HEAVY_ICE,
	HEAVY_TOXIC,
	HEAVY_FIRE,
	HEAVY_VOID,
}

const NAMES := {
	Type.LIGHT_NONE:  "Light None",
	Type.LIGHT_ICE:   "Light Ice",
	Type.LIGHT_TOXIC: "Light Toxic",
	Type.LIGHT_FIRE:  "Light Fire",
	Type.LIGHT_VOID:  "Light Void",

	Type.MEDIUM_NONE:  "Medium None",
	Type.MEDIUM_ICE:   "Medium Ice",
	Type.MEDIUM_TOXIC: "Medium Toxic",
	Type.MEDIUM_FIRE:  "Medium Fire",
	Type.MEDIUM_VOID:  "Medium Void",

	Type.HEAVY_NONE:  "Heavy None",
	Type.HEAVY_ICE:   "Heavy Ice",
	Type.HEAVY_TOXIC: "Heavy Toxic",
	Type.HEAVY_FIRE:  "Heavy Fire",
	Type.HEAVY_VOID:  "Heavy Void",
}


static func get_type(size: Enemy_types.Type, mod: Enemy_modifiers.Mod) -> Type:
	match size:
		Enemy_types.Type.LIGHT:
			match mod:
				Enemy_modifiers.Mod.NONE:  return Type.LIGHT_NONE
				Enemy_modifiers.Mod.ICE:   return Type.LIGHT_ICE
				Enemy_modifiers.Mod.TOXIC: return Type.LIGHT_TOXIC
				Enemy_modifiers.Mod.FIRE:  return Type.LIGHT_FIRE
				Enemy_modifiers.Mod.VOID:  return Type.LIGHT_VOID

		Enemy_types.Type.MEDIUM:
			match mod:
				Enemy_modifiers.Mod.NONE:  return Type.MEDIUM_NONE
				Enemy_modifiers.Mod.ICE:   return Type.MEDIUM_ICE
				Enemy_modifiers.Mod.TOXIC: return Type.MEDIUM_TOXIC
				Enemy_modifiers.Mod.FIRE:  return Type.MEDIUM_FIRE
				Enemy_modifiers.Mod.VOID:  return Type.MEDIUM_VOID

		Enemy_types.Type.HEAVY:
			match mod:
				Enemy_modifiers.Mod.NONE:  return Type.HEAVY_NONE
				Enemy_modifiers.Mod.ICE:   return Type.HEAVY_ICE
				Enemy_modifiers.Mod.TOXIC: return Type.HEAVY_TOXIC
				Enemy_modifiers.Mod.FIRE:  return Type.HEAVY_FIRE
				Enemy_modifiers.Mod.VOID:  return Type.HEAVY_VOID

	# fallback (nie powinno się zdarzyć)
	return Type.LIGHT_NONE
