class_name WeaponComponent
extends Node3D

## WeaponComponent: Controls weapon equipping, draw/sheathe transitions, and grip pose coordination.

signal weapon_state_changed(is_drawn: bool)

enum State {
	SHEATHED,
	DRAWING,
	DRAWN,
	SHEATHING
}

@export var draw_speed: float = 3.5

var current_state: State = State.SHEATHED
var transition_progress: float = 0.0

@onready var weapon_mesh: Node3D = get_node_or_null("WeaponMesh")
var right_hand_rig: HandRig = null

# Offsets relative to hand socket
var sheathed_pos: Vector3 = Vector3(0.0, -0.15, 0.35)
var sheathed_rot: Vector3 = Vector3(deg_to_rad(-45.0), 0.0, 0.0)

var drawn_pos: Vector3 = Vector3.ZERO
var drawn_rot: Vector3 = Vector3.ZERO

func setup(p_right_hand: HandRig) -> void:
	right_hand_rig = p_right_hand
	_apply_transform(sheathed_pos, sheathed_rot)
	if weapon_mesh:
		weapon_mesh.visible = false

func toggle_weapon() -> void:
	if current_state == State.SHEATHED or current_state == State.SHEATHING:
		current_state = State.DRAWING
		if weapon_mesh:
			weapon_mesh.visible = true
		if right_hand_rig:
			right_hand_rig.set_pose("GRIP", 12.0)
	elif current_state == State.DRAWN or current_state == State.DRAWING:
		current_state = State.SHEATHING
		if right_hand_rig:
			right_hand_rig.set_pose("REST", 8.0)

func update_weapon(delta: float) -> void:
	match current_state:
		State.DRAWING:
			transition_progress = move_toward(transition_progress, 1.0, draw_speed * delta)
			_blend_weapon_transform(transition_progress)
			if transition_progress >= 1.0:
				current_state = State.DRAWN
				weapon_state_changed.emit(true)

		State.SHEATHING:
			transition_progress = move_toward(transition_progress, 0.0, draw_speed * delta)
			_blend_weapon_transform(transition_progress)
			if transition_progress <= 0.0:
				current_state = State.SHEATHED
				if weapon_mesh:
					weapon_mesh.visible = false
				weapon_state_changed.emit(false)

		State.DRAWN:
			_apply_transform(drawn_pos, drawn_rot)

		State.SHEATHED:
			_apply_transform(sheathed_pos, sheathed_rot)

func _blend_weapon_transform(t: float) -> void:
	var smooth_t: float = smoothstep(0.0, 1.0, t)
	var pos: Vector3 = sheathed_pos.lerp(drawn_pos, smooth_t)
	var rot: Vector3 = sheathed_rot.lerp(drawn_rot, smooth_t)
	_apply_transform(pos, rot)

func _apply_transform(pos: Vector3, rot: Vector3) -> void:
	if weapon_mesh:
		weapon_mesh.position = pos
		weapon_mesh.rotation = rot

func is_weapon_drawn() -> bool:
	return current_state == State.DRAWN or current_state == State.DRAWING
