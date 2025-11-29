extends Object
class_name Enemy_modifiers

enum Mod { NONE, ICE, TOXIC, FIRE, VOID }

# Jak modyfikator wpływa na staty
const MOD_DATA := {
	Mod.NONE: {
		"health_mult": 1.0,
		"damage_mult": 1.0,
		"speed_mult": 1.0,
		"delay_mult": 1.0,
		"range_mult": 1.0,
	},
	Mod.ICE: {
		"health_mult": 1.2,
		"damage_mult": 0.8,
		"speed_mult": 0.9,
		"delay_mult": 1.2,
		"range_mult": 0.9,
	},
	Mod.TOXIC: {
		"health_mult": 0.9,
		"damage_mult": 1.3,
		"speed_mult": 1.0,
		"delay_mult": 1.0,
		"range_mult": 1.0,
	},
	Mod.FIRE: {
		"health_mult": 1.0,
		"damage_mult": 1.5,
		"speed_mult": 1.1,
		"delay_mult": 0.7,
		"range_mult": 1.1,
	},
	Mod.VOID: {
		"health_mult": 1.4,
		"damage_mult": 1.4,
		"speed_mult": 0.8,
		"delay_mult": 1.0,
		"range_mult": 1.25,
	},
}
