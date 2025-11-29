extends Object
class_name BugTypes

enum Type { LIGHT, MEDIUM, HEAVY }

const BASE_DATA := {
	Type.LIGHT: {
		"health": 70,
		"damage": 8,
		"speed": 90.0
	},
	Type.MEDIUM: {
		"health": 120,
		"damage": 12,
		"speed": 60.0
	},
	Type.HEAVY: {
		"health": 200,
		"damage": 20,
		"speed": 40.0
	},
}
