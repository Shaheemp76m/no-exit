class_name Player
extends CharacterBody3D

## Player: Modular Soulslike First-Person Controller uniting movement, camera, procedural animation, weapon, interaction, and damage systems.

@onready var movement_comp: MovementComponent = $MovementComponent
@onready var camera_comp: CameraComponent = $CameraComponent
@onready var proc_anim_comp: ProceduralAnimationComponent = $CameraComponent/ProceduralAnimationComponent
@onready var weapon_comp: WeaponComponent = $CameraComponent/ProceduralAnimationComponent/RightArmPivot/WandererHandRight/Wrist/Palm/WeaponSocket/WeaponComponent
@onready var interaction_comp: InteractionComponent = $CameraComponent/InteractionComponent
@onready var damage_comp: DamageReactionComponent = $DamageReactionComponent

@onready var left_hand_rig: HandRig = $CameraComponent/ProceduralAnimationComponent/LeftArmPivot/WandererHandLeft
@onready var right_hand_rig: HandRig = $CameraComponent/ProceduralAnimationComponent/RightArmPivot/WandererHandRight

# UI
@onready var prompt_label: Label = get_node_or_null("HUD/PromptLabel")
@onready var status_label: Label = get_node_or_null("HUD/StatusLabel")

var mouse_locked: bool = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Configure handedness
	if left_hand_rig:
		left_hand_rig.is_left_hand = true

	# Initialize weapon and interaction with hand rigs
	if weapon_comp:
		weapon_comp.setup(right_hand_rig)

	if interaction_comp:
		interaction_comp.setup(left_hand_rig)
		interaction_comp.prompt_changed.connect(_on_prompt_changed)

	if proc_anim_comp:
		proc_anim_comp.setup(left_hand_rig, right_hand_rig, weapon_comp, interaction_comp, damage_comp)

	if damage_comp:
		damage_comp.setup(camera_comp, proc_anim_comp, left_hand_rig, right_hand_rig)
		damage_comp.damaged.connect(_on_damaged)

	if movement_comp:
		movement_comp.landed.connect(camera_comp.on_landed)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_locked:
		camera_comp.handle_mouse_input(event)
		proc_anim_comp.handle_mouse_lag(event.relative)

	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			mouse_locked = not mouse_locked
			Input.set_mouse_mode(
				Input.MOUSE_MODE_CAPTURED if mouse_locked else Input.MOUSE_MODE_VISIBLE
			)

		# Action triggers
		if Input.is_action_just_pressed("toggle_weapon"):
			if weapon_comp:
				weapon_comp.toggle_weapon()

		if Input.is_action_just_pressed("interact"):
			if interaction_comp:
				interaction_comp.try_interact()

		if Input.is_action_just_pressed("debug_damage_light"):
			if damage_comp:
				# Front-left light strike
				var dir: Vector3 = (transform.basis * Vector3(-0.6, 0.1, -1.0)).normalized()
				damage_comp.take_damage(12.0, dir, "light")

		if Input.is_action_just_pressed("debug_damage_heavy"):
			if damage_comp:
				# Front-right heavy stagger
				var dir: Vector3 = (transform.basis * Vector3(0.7, 0.2, -1.0)).normalized()
				damage_comp.take_damage(35.0, dir, "heavy")

func _physics_process(delta: float) -> void:
	# Read movement inputs
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var is_sprint: bool = Input.is_action_pressed("sprint")
	var is_jump: bool = Input.is_action_just_pressed("jump")

	# Update movement component
	movement_comp.process_movement(delta, input_dir, is_sprint, is_jump)

	# Update camera component
	var cur_speed: float = movement_comp.current_speed
	var max_spd: float = movement_comp.sprint_speed
	camera_comp.update_camera(delta, cur_speed, max_spd, is_on_floor(), input_dir.x)

	# Update procedural animation & hand arms
	proc_anim_comp.update_procedural_animation(delta, cur_speed, max_spd, is_on_floor(), velocity)

	# Update weapon transitions
	if weapon_comp:
		weapon_comp.update_weapon(delta)

	# Update interaction raycasting
	if interaction_comp:
		interaction_comp.update_interaction(delta)

	# Update damage flinch recovery
	if damage_comp:
		damage_comp.update_damage(delta)

	_update_hud()

func _on_prompt_changed(text: String, is_visible: bool) -> void:
	if prompt_label:
		prompt_label.text = text
		prompt_label.visible = is_visible

func _on_damaged(_amount: float, _direction: Vector3, _severity: String) -> void:
	_update_hud()

func _update_hud() -> void:
	if status_label:
		var state_str: String = "IDLE"
		match movement_comp.current_state:
			MovementComponent.State.IDLE: state_str = "IDLE"
			MovementComponent.State.WALK: state_str = "WALK"
			MovementComponent.State.RUN: state_str = "RUN"
			MovementComponent.State.SPRINT: state_str = "SPRINT"
			MovementComponent.State.AIR: state_str = "AIR"

		var weapon_str: String = "DRAWN" if (weapon_comp and weapon_comp.is_weapon_drawn()) else "SHEATHED"
		var hp: int = int(damage_comp.current_health) if damage_comp else 100

		status_label.text = "HP: %d | STATE: %s | WEAPON: %s\nWASD: Move | Shift: Sprint | Space: Jump | F: Toggle Weapon | E: Interact | 1/2: Debug Damage" % [hp, state_str, weapon_str]
