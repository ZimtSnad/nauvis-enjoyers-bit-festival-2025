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
