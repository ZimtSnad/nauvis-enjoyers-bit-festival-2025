extends Object
class_name Enemy_types

enum Type { LIGHT, MEDIUM, HEAVY }

const BASE_DATA := {
	Type.LIGHT: {
		"health": 70,
		"damage": 8,
		"speed": 60.0,
		"delay_between_bite": 1.5,
		"attack_range": 90.0
	},
	Type.MEDIUM: {
		"health": 120,
		"damage": 12,
		"speed": 40.0,
		"delay_between_bite": 2.0,
		"attack_range": 90.0
	},
	Type.HEAVY: {
		"health": 200,
		"damage": 20,
		"speed": 30.0,
		"delay_between_bite": 3.0,
		"attack_range": 90.0
	},
}
