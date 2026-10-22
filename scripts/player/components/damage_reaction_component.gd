class_name DamageReactionComponent
extends Node

## DamageReactionComponent: Processes directional hit events, flinch recoil, and camera shockwaves.

signal damaged(amount: float, direction: Vector3, severity: String)

@export var max_health: float = 100.0
var current_health: float = 100.0

var camera_comp: CameraComponent = null
var proc_anim: Node = null
var left_hand: HandRig = null
var right_hand: HandRig = null

var flinch_timer: float = 0.0
var flinch_duration: float = 0.3
var flinch_severity: float = 1.0
var flinch_offset: Vector3 = Vector3.ZERO

func setup(p_camera: CameraComponent, p_proc_anim: Node, p_left_hand: HandRig, p_right_hand: HandRig) -> void:
	camera_comp = p_camera
	proc_anim = p_proc_anim
	left_hand = p_left_hand
	right_hand = p_right_hand
	current_health = max_health

func update_damage(delta: float) -> void:
	if flinch_timer > 0.0:
		flinch_timer -= delta
		if flinch_timer <= 0.0:
			flinch_offset = Vector3.ZERO
			if left_hand:
				left_hand.set_pose("REST", 8.0)
			if right_hand and not (proc_anim and proc_anim.is_weapon_drawn()):
				right_hand.set_pose("REST", 8.0)
		else:
			flinch_offset = flinch_offset.lerp(Vector3.ZERO, 8.0 * delta)

func take_damage(amount: float, direction: Vector3, severity: String = "light") -> void:
	current_health = max(0.0, current_health - amount)
	var is_heavy: bool = severity == "heavy"

	flinch_severity = 2.2 if is_heavy else 1.0
	flinch_duration = 0.65 if is_heavy else 0.28
	flinch_timer = flinch_duration

	# Apply camera shock
	if camera_comp:
		camera_comp.apply_damage_jolt(direction, flinch_severity)

	# Apply hand flinch poses
	if left_hand:
		left_hand.set_pose("FLINCH", 16.0)
	if right_hand and not (proc_anim and proc_anim.is_weapon_drawn()):
		right_hand.set_pose("FLINCH", 16.0)

	# Local recoil offset for arms
	var character: CharacterBody3D = get_parent() as CharacterBody3D
	if character:
		var local_dir: Vector3 = character.transform.basis.inverse() * direction
		flinch_offset = Vector3(-local_dir.x * 0.12, -0.08 * flinch_severity, local_dir.z * 0.15)

	damaged.emit(amount, direction, severity)

func get_flinch_offset() -> Vector3:
	return flinch_offset

func is_flinching() -> bool:
	return flinch_timer > 0.0
