class_name InteractionComponent
extends Node3D

## InteractionComponent: Raycasting for interactables, HUD prompt updates, and hand reach coordination.

signal prompt_changed(prompt_text: String, is_visible: bool)

@export var max_interaction_distance: float = 2.4

@onready var raycast: RayCast3D = $RayCast3D
var current_interactable: Interactable = null
var left_hand_rig: HandRig = null

var is_reaching: bool = false
var reach_timer: float = 0.0
const REACH_DURATION: float = 0.45

func setup(p_left_hand: HandRig) -> void:
	left_hand_rig = p_left_hand

func update_interaction(delta: float) -> void:
	if not raycast:
		return

	# Handle reach animation timer
	if is_reaching:
		reach_timer -= delta
		if reach_timer <= 0.0:
			is_reaching = false
			if left_hand_rig:
				left_hand_rig.set_pose("REST", 7.0)

	# Raycast check
	if raycast.is_colliding():
		var collider: Object = raycast.get_collider()
		var interactable: Interactable = null

		if collider is Interactable:
			interactable = collider
		elif collider is Node:
			# Check parents or children
			interactable = collider.get_node_or_null(".") as Interactable
			if not interactable and collider.get_parent() is Interactable:
				interactable = collider.get_parent() as Interactable

		if interactable and interactable.can_interact(get_parent()):
			if interactable != current_interactable:
				current_interactable = interactable
				prompt_changed.emit("[E] " + current_interactable.get_prompt(), true)
			return

	if current_interactable != null:
		current_interactable = null
		prompt_changed.emit("", false)

func try_interact() -> bool:
	if current_interactable and current_interactable.can_interact(get_parent()):
		# Trigger hand reaching animation
		is_reaching = true
		reach_timer = REACH_DURATION
		if left_hand_rig:
			left_hand_rig.set_pose("REACH", 14.0)

		current_interactable.interact(get_parent() as Node3D)
		# Update prompt after state change
		prompt_changed.emit("[E] " + current_interactable.get_prompt(), true)
		return true
	return false

func is_hand_reaching() -> bool:
	return is_reaching

func get_reach_progress() -> float:
	if not is_reaching:
		return 0.0
	# Triangle wave 0 -> 1 -> 0 over REACH_DURATION
	var half: float = REACH_DURATION * 0.5
	if reach_timer > half:
		return (REACH_DURATION - reach_timer) / half
	else:
		return reach_timer / half
