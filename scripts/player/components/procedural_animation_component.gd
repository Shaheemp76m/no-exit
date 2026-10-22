class_name ProceduralAnimationComponent
extends Node3D

## ProceduralAnimationComponent: Procedural arm sway, gait bob, inertia lag, wall avoidance, and pose blending.

@export_group("Wall Detection")
@export var wall_check_distance: float = 0.95

@export_group("Sway & Inertia")
@export var mouse_lag_strength: float = 0.0018
@export var mouse_lag_recovery: float = 12.0
@export var velocity_drag_strength: float = 0.015

@onready var left_arm_pivot: Node3D = $LeftArmPivot
@onready var right_arm_pivot: Node3D = $RightArmPivot
@onready var wall_ray_left: RayCast3D = get_node_or_null("WallRayLeft")
@onready var wall_ray_right: RayCast3D = get_node_or_null("WallRayRight")

var left_hand_rig: HandRig = null
var right_hand_rig: HandRig = null
var weapon_comp: WeaponComponent = null
var interaction_comp: InteractionComponent = null
var damage_comp: DamageReactionComponent = null

# Base resting transforms for Left and Right hands
var base_left_pos_unarmed: Vector3 = Vector3(-0.22, -0.24, -0.36)
var base_left_rot_unarmed: Vector3 = Vector3(deg_to_rad(-6.0), deg_to_rad(16.0), deg_to_rad(-6.0))

var base_left_pos_armed: Vector3 = Vector3(-0.20, -0.20, -0.38)
var base_left_rot_armed: Vector3 = Vector3(deg_to_rad(6.0), deg_to_rad(20.0), deg_to_rad(-8.0))

var base_right_pos_unarmed: Vector3 = Vector3(0.22, -0.24, -0.36)
var base_right_rot_unarmed: Vector3 = Vector3(deg_to_rad(-6.0), deg_to_rad(-16.0), deg_to_rad(6.0))

var base_right_pos_armed: Vector3 = Vector3(0.18, -0.16, -0.34)
var base_right_rot_armed: Vector3 = Vector3(deg_to_rad(28.0), deg_to_rad(-16.0), deg_to_rad(10.0))

# Inertia tracking
var mouse_lag_offset: Vector2 = Vector2.ZERO
var velocity_drag: Vector3 = Vector3.ZERO
var anim_timer: float = 0.0

# Wall proximity
var wall_factor_left: float = 0.0
var wall_factor_right: float = 0.0

func setup(p_left_hand: HandRig, p_right_hand: HandRig, p_weapon: WeaponComponent, p_interact: InteractionComponent, p_damage: DamageReactionComponent) -> void:
	left_hand_rig = p_left_hand
	right_hand_rig = p_right_hand
	weapon_comp = p_weapon
	interaction_comp = p_interact
	damage_comp = p_damage

func handle_mouse_lag(relative: Vector2) -> void:
	mouse_lag_offset.x = clamp(mouse_lag_offset.x + relative.x * mouse_lag_strength, -0.12, 0.12)
	mouse_lag_offset.y = clamp(mouse_lag_offset.y + relative.y * mouse_lag_strength, -0.10, 0.10)

func is_weapon_drawn() -> bool:
	return weapon_comp != null and weapon_comp.is_weapon_drawn()

func update_procedural_animation(delta: float, current_speed: float, max_speed: float, is_on_floor: bool, _direction: Vector3) -> void:
	if not left_arm_pivot or not right_arm_pivot:
		return

	# 1. Recover mouse lag
	mouse_lag_offset = mouse_lag_offset.lerp(Vector2.ZERO, mouse_lag_recovery * delta)

	# 2. Check wall proximity
	_update_wall_avoidance(delta)

	# 3. Locomotion & Breathing timers
	var speed_ratio: float = clamp(current_speed / max_speed, 0.0, 1.0) if max_speed > 0 else 0.0
	var freq: float = lerp(1.8, 8.5, speed_ratio) if is_on_floor else 1.2
	anim_timer += delta * freq

	# Arm swinging / breathing
	var breath_sway_y: float = sin(anim_timer * 0.8) * 0.008
	var walk_swing_z: float = sin(anim_timer) * 0.045 * speed_ratio
	var walk_bob_y: float = abs(sin(anim_timer * 1.5)) * 0.025 * speed_ratio

	# 4. Flinch offset from damage
	var flinch_offset: Vector3 = damage_comp.get_flinch_offset() if damage_comp else Vector3.ZERO

	# 5. Interaction reach for left hand
	var reach_offset: Vector3 = Vector3.ZERO
	if interaction_comp and interaction_comp.is_hand_reaching():
		var reach_t: float = interaction_comp.get_reach_progress()
		reach_offset = Vector3(0.08, 0.12, -0.28) * reach_t

	# 6. Wall avoidance offsets (pull hands in and up)
	var wall_left_offset: Vector3 = Vector3(0.06, 0.08, 0.22) * wall_factor_left
	var wall_right_offset: Vector3 = Vector3(-0.06, 0.08, 0.22) * wall_factor_right

	var is_armed: bool = is_weapon_drawn()

	# --- Calculate Left Arm Transform ---
	var base_l_pos: Vector3 = base_left_pos_armed if is_armed else base_left_pos_unarmed
	var base_l_rot: Vector3 = base_left_rot_armed if is_armed else base_left_rot_unarmed

	var left_target_pos: Vector3 = base_l_pos
	left_target_pos.x += -mouse_lag_offset.x * 0.5
	left_target_pos.y += breath_sway_y + walk_bob_y - mouse_lag_offset.y * 0.4
	left_target_pos.z += walk_swing_z
	left_target_pos += reach_offset + wall_left_offset + flinch_offset

	var left_target_rot: Vector3 = base_l_rot
	left_target_rot.z += mouse_lag_offset.x * 0.4
	left_target_rot.x += -mouse_lag_offset.y * 0.3
	if wall_factor_left > 0.4 and not (interaction_comp and interaction_comp.is_hand_reaching()):
		# Pitch up and flatten towards wall
		left_target_rot.x += deg_to_rad(30.0 * wall_factor_left)
		left_target_rot.y += deg_to_rad(-15.0 * wall_factor_left)

	left_arm_pivot.position = left_arm_pivot.position.lerp(left_target_pos, 14.0 * delta)
	left_arm_pivot.rotation = left_arm_pivot.rotation.lerp(left_target_rot, 14.0 * delta)

	# --- Calculate Right Arm Transform ---
	var base_r_pos: Vector3 = base_right_pos_armed if is_armed else base_right_pos_unarmed
	var base_r_rot: Vector3 = base_right_rot_armed if is_armed else base_right_rot_unarmed

	var right_target_pos: Vector3 = base_r_pos
	right_target_pos.x += -mouse_lag_offset.x * 0.5
	right_target_pos.y += breath_sway_y + walk_bob_y - mouse_lag_offset.y * 0.4
	right_target_pos.z += -walk_swing_z # Opposite phase swing
	right_target_pos += wall_right_offset + flinch_offset

	var right_target_rot: Vector3 = base_r_rot
	right_target_rot.z += mouse_lag_offset.x * 0.4
	right_target_rot.x += -mouse_lag_offset.y * 0.3
	if wall_factor_right > 0.3:
		right_target_rot.x += deg_to_rad(25.0 * wall_factor_right)

	right_arm_pivot.position = right_arm_pivot.position.lerp(right_target_pos, 14.0 * delta)
	right_arm_pivot.rotation = right_arm_pivot.rotation.lerp(right_target_rot, 14.0 * delta)

func _update_wall_avoidance(delta: float) -> void:
	var target_left: float = 0.0
	if wall_ray_left and wall_ray_left.is_colliding():
		var d: float = wall_ray_left.global_position.distance_to(wall_ray_left.get_collision_point())
		target_left = clamp((wall_check_distance - d) / wall_check_distance, 0.0, 1.0)

	var target_right: float = 0.0
	if wall_ray_right and wall_ray_right.is_colliding():
		var d: float = wall_ray_right.global_position.distance_to(wall_ray_right.get_collision_point())
		target_right = clamp((wall_check_distance - d) / wall_check_distance, 0.0, 1.0)

	wall_factor_left = lerp(wall_factor_left, target_left, 12.0 * delta)
	wall_factor_right = lerp(wall_factor_right, target_right, 12.0 * delta)

	# Update left hand brace pose when close to wall
	if left_hand_rig and not (interaction_comp and interaction_comp.is_hand_reaching()) and not (damage_comp and damage_comp.is_flinching()):
		if wall_factor_left > 0.45:
			left_hand_rig.set_pose("WALL_BRACE", 10.0)
		else:
			left_hand_rig.set_pose("REST", 8.0)
