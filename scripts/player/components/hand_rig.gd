class_name HandRig
extends Node3D

## HandRig: Controls procedural finger articulation, poses, and grip transitions.

@export var is_left_hand: bool = false

# Finger joint node references
@onready var wrist: Node3D = $Wrist
@onready var palm: Node3D = $Wrist/Palm

@onready var thumb_knuckle: Node3D = $Wrist/Palm/ThumbKnuckle
@onready var thumb_joint: Node3D = $Wrist/Palm/ThumbKnuckle/ThumbJoint

@onready var index_knuckle: Node3D = $Wrist/Palm/IndexKnuckle
@onready var index_joint: Node3D = $Wrist/Palm/IndexKnuckle/IndexJoint

@onready var middle_knuckle: Node3D = $Wrist/Palm/MiddleKnuckle
@onready var middle_joint: Node3D = $Wrist/Palm/MiddleKnuckle/MiddleJoint

@onready var ring_knuckle: Node3D = $Wrist/Palm/RingKnuckle
@onready var ring_joint: Node3D = $Wrist/Palm/RingKnuckle/RingJoint

@onready var pinky_knuckle: Node3D = $Wrist/Palm/PinkyKnuckle
@onready var pinky_joint: Node3D = $Wrist/Palm/PinkyKnuckle/PinkyJoint

# Weapon socket node for right hand
@onready var weapon_socket: Node3D = get_node_or_null("Wrist/Palm/WeaponSocket")

# Current finger curls (0.0 = fully open, 1.0 = clenched fist)
var target_thumb: float = 0.25
var target_index: float = 0.3
var target_middle: float = 0.35
var target_ring: float = 0.4
var target_pinky: float = 0.45

var current_thumb: float = 0.25
var current_index: float = 0.3
var current_middle: float = 0.35
var current_ring: float = 0.4
var current_pinky: float = 0.45

var current_pose_name: String = "REST"
var blend_speed: float = 10.0

func _ready() -> void:
	set_pose("REST", 20.0)

func _process(delta: float) -> void:
	current_thumb = lerp(current_thumb, target_thumb, blend_speed * delta)
	current_index = lerp(current_index, target_index, blend_speed * delta)
	current_middle = lerp(current_middle, target_middle, blend_speed * delta)
	current_ring = lerp(current_ring, target_ring, blend_speed * delta)
	current_pinky = lerp(current_pinky, target_pinky, blend_speed * delta)
	
	_apply_finger_curls()

func set_pose(pose_name: String, speed: float = 8.0) -> void:
	current_pose_name = pose_name
	blend_speed = speed
	
	match pose_name:
		"REST":
			# Asymmetrical, relaxed wanderer rest pose
			if is_left_hand:
				target_thumb = 0.22
				target_index = 0.28
				target_middle = 0.38
				target_ring = 0.44
				target_pinky = 0.50
			else:
				target_thumb = 0.25
				target_index = 0.32
				target_middle = 0.40
				target_ring = 0.46
				target_pinky = 0.52
				
		"GRIP":
			# Firm clench for holding sword or tools
			target_thumb = 0.88
			target_index = 0.92
			target_middle = 0.95
			target_ring = 0.95
			target_pinky = 0.92
			
		"REACH":
			# Extended fingers, reaching towards door latch / interactable
			target_thumb = 0.12
			target_index = 0.10
			target_middle = 0.14
			target_ring = 0.18
			target_pinky = 0.22
			
		"WALL_BRACE":
			# Palm flattened against surface, fingers slightly bent backward/flat
			target_thumb = 0.05
			target_index = 0.08
			target_middle = 0.10
			target_ring = 0.12
			target_pinky = 0.15
			
		"FLINCH":
			# Protective defensive contraction
			target_thumb = 0.70
			target_index = 0.65
			target_middle = 0.75
			target_ring = 0.80
			target_pinky = 0.85

func _apply_finger_curls() -> void:
	# Thumb has custom abduction/adduction and flexion
	if thumb_knuckle and thumb_joint:
		var thumb_mult: float = -1.0 if is_left_hand else 1.0
		thumb_knuckle.rotation.x = deg_to_rad(20.0 + current_thumb * 45.0)
		thumb_knuckle.rotation.y = deg_to_rad(thumb_mult * (15.0 + current_thumb * 25.0))
		thumb_joint.rotation.x = deg_to_rad(current_thumb * 55.0)
	
	# Fingers flex primarily along X axis
	_flex_finger(index_knuckle, index_joint, current_index, deg_to_rad(65.0), deg_to_rad(75.0))
	_flex_finger(middle_knuckle, middle_joint, current_middle, deg_to_rad(70.0), deg_to_rad(80.0))
	_flex_finger(ring_knuckle, ring_joint, current_ring, deg_to_rad(72.0), deg_to_rad(80.0))
	_flex_finger(pinky_knuckle, pinky_joint, current_pinky, deg_to_rad(75.0), deg_to_rad(82.0))

func _flex_finger(knuckle: Node3D, joint: Node3D, curl: float, max_knuckle: float, max_joint: float) -> void:
	if knuckle:
		knuckle.rotation.x = curl * max_knuckle
	if joint:
		joint.rotation.x = curl * max_joint
