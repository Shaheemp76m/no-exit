extends CharacterBody3D

# Movement settings
const SPEED = 5.0
const SENSITIVITY = 0.003
const JUMP_VELOCITY = 4.5

var mouse_locked = true
var pitch = 0.0

@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_locked:
		rotate_y(-event.relative.x * SENSITIVITY)
		pitch = clamp(pitch - event.relative.y * SENSITIVITY, -1.4, 1.4)
		camera.rotation.x = pitch

	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			mouse_locked = not mouse_locked
			Input.set_mouse_mode(
				Input.MOUSE_MODE_CAPTURED if mouse_locked else Input.MOUSE_MODE_VISIBLE
			)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement relative to player facing direction
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
