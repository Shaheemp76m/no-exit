class_name MovementComponent
extends Node

## MovementComponent: Grounded Soulslike locomotion, acceleration curves, and landing impacts.

signal state_changed(old_state: int, new_state: int)
signal landed(impact_velocity: float)

enum State {
	IDLE,
	WALK,
	RUN,
	SPRINT,
	AIR
}

@export_group("Speeds")
@export var walk_speed: float = 2.8
@export var run_speed: float = 4.8
@export var sprint_speed: float = 7.2
@export var jump_velocity: float = 4.6

@export_group("Physics & Inertia")
@export var ground_acceleration: float = 12.0
@export var ground_friction: float = 14.0
@export var air_acceleration: float = 3.2
@export var air_friction: float = 1.0

var current_state: State = State.IDLE
var target_speed: float = 0.0
var current_speed: float = 0.0
var is_sprinting: bool = false
var fall_velocity: float = 0.0
var was_on_floor: bool = true

@onready var character: CharacterBody3D = get_parent() as CharacterBody3D

func _ready() -> void:
	if not character:
		push_error("MovementComponent must be child of a CharacterBody3D!")

func process_movement(delta: float, input_dir: Vector2, is_sprint_pressed: bool, is_jump_pressed: bool) -> void:
	if not character:
		return

	var is_floor: bool = character.is_on_floor()

	# Landing detection
	if is_floor and not was_on_floor:
		var impact: float = abs(fall_velocity)
		landed.emit(impact)
		fall_velocity = 0.0

	# Gravity and falling
	var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)
	if not is_floor:
		character.velocity.y -= gravity * delta
		fall_velocity = character.velocity.y
	else:
		if is_jump_pressed:
			character.velocity.y = jump_velocity
			_set_state(State.AIR)

	# Determine locomotion mode
	var moving: bool = input_dir.length_squared() > 0.01
	is_sprinting = is_sprint_pressed and moving and is_floor

	if not is_floor:
		_set_state(State.AIR)
		target_speed = run_speed
	elif not moving:
		_set_state(State.IDLE)
		target_speed = 0.0
	elif is_sprinting:
		_set_state(State.SPRINT)
		target_speed = sprint_speed
	else:
		# Run is default on movement, or walk if slower
		_set_state(State.RUN)
		target_speed = run_speed

	# Calculate world direction relative to character orientation
	var wish_dir: Vector3 = (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var target_vel: Vector3 = wish_dir * target_speed

	var accel: float = ground_acceleration if is_floor else air_acceleration
	var friction: float = ground_friction if is_floor else air_friction

	var current_horizontal: Vector3 = Vector3(character.velocity.x, 0, character.velocity.z)
	var final_horizontal: Vector3

	if moving:
		final_horizontal = current_horizontal.lerp(target_vel, accel * delta)
	else:
		final_horizontal = current_horizontal.move_toward(Vector3.ZERO, friction * delta)

	character.velocity.x = final_horizontal.x
	character.velocity.z = final_horizontal.z
	current_speed = final_horizontal.length()

	character.move_and_slide()
	was_on_floor = character.is_on_floor()

func _set_state(new_state: State) -> void:
	if current_state != new_state:
		var old: State = current_state
		current_state = new_state
		state_changed.emit(old, new_state)

func get_horizontal_velocity() -> Vector3:
	if not character:
		return Vector3.ZERO
	return Vector3(character.velocity.x, 0, character.velocity.z)
