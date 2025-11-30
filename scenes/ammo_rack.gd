extends Node2D

@export var crafter : Area2D
@export var ammotype : Ammo_types.Type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if crafter.can_take:
		crafter.output_counter -= 1
		AmmoStore.add_ammo(ammotype, 1)
	pass
