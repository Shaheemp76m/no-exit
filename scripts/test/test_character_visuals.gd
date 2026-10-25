extends Node

## Deterministic async visual test runner for character systems and states.

func _ready() -> void:
	call_deferred("_run_sequence")

func _run_sequence() -> void:
	print("--- Starting Character Visual Verification Sequence ---")
	var player: Player = get_tree().root.find_child("Player", true, false) as Player
	if not player:
		push_error("Player node not found!")
		get_tree().quit(1)
		return

	var base_path: String = "/home/ross/.gemini/antigravity-cli/brain/0ddf7b6a-d555-488d-97d3-76b1ded29842"

	# 1. Idle View at spawn
	await get_tree().create_timer(1.0).timeout
	await _capture(base_path + "/screenshot_character_idle.png")
	print("1. Idle screenshot saved.")

	# 2. Draw Weapon
	if player.weapon_comp:
		player.weapon_comp.toggle_weapon()
	await get_tree().create_timer(1.2).timeout
	await _capture(base_path + "/screenshot_character_weapon_drawn.png")
	print("2. Weapon drawn screenshot saved.")

	# 3. Look Down at Torso and Belt
	if player.camera_comp:
		player.camera_comp.pitch = -1.0
	await get_tree().create_timer(0.8).timeout
	await _capture(base_path + "/screenshot_character_torso_down.png")
	print("3. Torso look-down screenshot saved.")

	# 4. Approach Door - Prompt
	if player.camera_comp:
		player.camera_comp.pitch = 0.0
	player.global_position = Vector3(0, 0, -9.2)
	await get_tree().create_timer(0.8).timeout
	await _capture(base_path + "/screenshot_character_door_prompt.png")
	print("4. Door prompt screenshot saved.")

	# 5. Open Door
	if player.interaction_comp:
		player.interaction_comp.try_interact()
	await get_tree().create_timer(0.8).timeout
	await _capture(base_path + "/screenshot_character_door_opened.png")
	print("5. Door opened screenshot saved.")

	# 6. Narrow corridor wall bracing
	player.global_position = Vector3(-0.55, 0, -4.5)
	await get_tree().create_timer(0.8).timeout
	await _capture(base_path + "/screenshot_character_wall_bracing.png")
	print("6. Wall bracing screenshot saved.")

	# 7. Take Directional Damage & Flinch
	if player.damage_comp:
		var hit_dir: Vector3 = Vector3(0.6, 0.2, -1.0).normalized()
		player.damage_comp.take_damage(25.0, hit_dir, "heavy")
	await get_tree().create_timer(0.12).timeout
	await _capture(base_path + "/screenshot_character_damage_flinch.png")
	print("7. Damage flinch screenshot saved.")

	await get_tree().create_timer(0.5).timeout
	print("--- All Visual Verifications Successfully Finished! ---")
	get_tree().quit(0)

func _capture(path: String) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	var img: Image = get_viewport().get_texture().get_image()
	if img:
		img.save_png(path)
