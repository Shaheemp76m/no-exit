class_name Interactable
extends CollisionObject3D

## Base class for interactable world objects in the game.

@export var prompt_message: String = "Interact"
@export var is_enabled: bool = true

signal interacted(user: Node3D)

func can_interact(_user: Node3D) -> bool:
	return is_enabled

func interact(user: Node3D) -> void:
	if not can_interact(user):
		return
	interacted.emit(user)
	_on_interacted(user)

func _on_interacted(_user: Node3D) -> void:
	pass

func get_prompt() -> String:
	return prompt_message

func get_interaction_target_position() -> Vector3:
	return global_position
