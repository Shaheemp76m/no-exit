class_name CameraComponent
extends Node3D

## CameraComponent: First-person camera with organic breathing, footstep bobbing, turn roll, landing dips, and damage jolts.

@export var mouse_sensitivity: float = 0.0025
@export var pitch_min: float = -1.4
@export var pitch_max: float = 1.4

@export_group("Breathing Sway")
@export var breath_speed_idle: float = 1.6
@export var breath_speed_sprint: float = 3.8
@export var breath_amp_v: float = 0.012
@export var breath_amp_pitch: float = 0.008

@export_group("Head Bob")
@export var bob_frequency_walk: float = 7.0
@export var bob_frequency_run: float = 10.5
@export var bob_frequency_sprint: float = 13.0
@export var bob_amplitude_v: float = 0.04
@export var bob_amplitude_h: float = 0.025

@export_group("Inertia & Roll")
@export var turn_roll_amount: float = 0.025
@export var strafe_roll_amount: float = 0.035

@onready var camera: Camera3D = $Camera3D
@onready var character: CharacterBody3D = get_parent() as CharacterBody3D

var pitch: float = 0.0
var mouse_delta_x: float = 0.0
var roll_offset: float = 0.0

var breath_timer: float = 0.0
var bob_distance: float = 0.0

# Landing dip spring
var spring_displacement: float = 0.0
var spring_velocity: float = 0.0
const SPRING_STIFFNESS: float = 120.0
const SPRING_DAMPING: float = 14.0

# Damage recoil
var damage_rot_impulse: Vector3 = Vector3.ZERO

func _ready() -> void:
	if camera:
		camera.near = 0.05 # Prevent near-plane clipping through character chest
		camera.fov = 75.0

func handle_mouse_input(event: InputEventMouseMotion) -> void:
	if not character:
		return
	
	# Yaw body
	character.rotate_y(-event.relative.x * mouse_sensitivity)
	
	# Pitch camera
	pitch = clamp(pitch - event.relative.y * mouse_sensitivity, pitch_min, pitch_max)
	
	# Store yaw speed for roll inertia
	mouse_delta_x = event.relative.x

func update_camera(delta: float, current_speed: float, max_speed: float, is_on_floor: bool, input_strafe: float) -> void:
	if not camera:
		return

	# Decay mouse delta
	mouse_delta_x = lerp(mouse_delta_x, 0.0, 15.0 * delta)

	# 1. Spring physics for landing dip
	var spring_force: float = -SPRING_STIFFNESS * spring_displacement - SPRING_DAMPING * spring_velocity
	spring_velocity += spring_force * delta
	spring_displacement += spring_velocity * delta

	# 2. Breathing sway
	var speed_ratio: float = clamp(current_speed / max_speed, 0.0, 1.0) if max_speed > 0 else 0.0
	var breath_speed: float = lerp(breath_speed_idle, breath_speed_sprint, speed_ratio)
	breath_timer += delta * breath_speed
	
	var breath_v: float = sin(breath_timer) * breath_amp_v * (1.0 - speed_ratio * 0.5)
	var breath_p: float = cos(breath_timer * 0.5) * breath_amp_pitch

	# 3. Head bobbing
	var bob_v: float = 0.0
	var bob_h: float = 0.0
	if is_on_floor and current_speed > 0.2:
		var freq: float = lerp(bob_frequency_walk, bob_frequency_sprint, speed_ratio)
		bob_distance += delta * freq
		bob_v = sin(bob_distance * 2.0) * bob_amplitude_v * speed_ratio
		bob_h = cos(bob_distance) * bob_amplitude_h * speed_ratio
	else:
		bob_distance = 0.0

	# 4. Turn & strafe roll
	var target_roll: float = (-mouse_delta_x * 0.001 * turn_roll_amount) - (input_strafe * strafe_roll_amount)
	roll_offset = lerp(roll_offset, target_roll, 10.0 * delta)

	# 5. Decay damage impulse
	damage_rot_impulse = damage_rot_impulse.lerp(Vector3.ZERO, 10.0 * delta)

	# Apply final camera transform
	camera.position.x = bob_h
	camera.position.y = breath_v + bob_v + spring_displacement
	camera.rotation.x = pitch + breath_p + damage_rot_impulse.x
	camera.rotation.y = damage_rot_impulse.y
	camera.rotation.z = roll_offset + damage_rot_impulse.z

func on_landed(impact_velocity: float) -> void:
	# Downward impact spring impulse
	var strength: float = clamp(impact_velocity * 0.02, 0.03, 0.35)
	spring_velocity -= strength * 14.0

func apply_damage_jolt(direction: Vector3, severity: float) -> void:
	# Convert world hit direction to local camera impulse
	var local_dir: Vector3 = character.transform.basis.inverse() * direction
	damage_rot_impulse.x += clamp(-local_dir.z * 0.15 * severity, -0.25, 0.25)
	damage_rot_impulse.y += clamp(-local_dir.x * 0.20 * severity, -0.3, 0.3)
	damage_rot_impulse.z += clamp(local_dir.x * 0.12 * severity, -0.2, 0.2)
