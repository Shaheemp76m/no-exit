class_name DamageZone
extends Area3D

## DamageZone: Applies directional damage when the player walks onto it.

@export var damage_amount: float = 25.0
@export var severity: String = "heavy"
@export var tick_rate: float = 1.0

var active_player: Player = null
var tick_timer: float = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _physics_process(delta: float) -> void:
	if active_player:
		tick_timer -= delta
		if tick_timer <= 0.0:
			tick_timer = tick_rate
			var hit_dir: Vector3 = (active_player.global_position - global_position).normalized()
			if hit_dir.length_squared() < 0.01:
				hit_dir = Vector3.UP
			active_player.damage_comp.take_damage(damage_amount, hit_dir, severity)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		active_player = body
		tick_timer = 0.0 # Trigger immediately on entry

func _on_body_exited(body: Node3D) -> void:
	if body == active_player:
		active_player = null
