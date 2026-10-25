class_name DoorInteractable
extends Interactable

## Medieval heavy wooden door that pivots open and closed on a hinge.

@export var is_open: bool = false
@export var open_angle_degrees: float = 95.0
@export var swing_speed: float = 3.0

@onready var hinge: Node3D = $Hinge
@onready var handle: Node3D = get_node_or_null("Hinge/DoorLeaf/Handle")

var target_angle_rad: float = 0.0
var current_angle_rad: float = 0.0

func _ready() -> void:
	target_angle_rad = deg_to_rad(open_angle_degrees) if is_open else 0.0
	current_angle_rad = target_angle_rad
	if hinge:
		hinge.rotation.y = current_angle_rad
	_update_prompt()

func _physics_process(delta: float) -> void:
	if hinge:
		current_angle_rad = lerp_angle(current_angle_rad, target_angle_rad, swing_speed * delta)
		hinge.rotation.y = current_angle_rad

func _on_interacted(_user: Node3D) -> void:
	is_open = not is_open
	target_angle_rad = deg_to_rad(open_angle_degrees) if is_open else 0.0
	_update_prompt()

func _update_prompt() -> void:
	prompt_message = "Close Door" if is_open else "Open Door"

func get_interaction_target_position() -> Vector3:
	if handle:
		return handle.global_position
	return global_position + Vector3(0.4, 1.0, 0)
