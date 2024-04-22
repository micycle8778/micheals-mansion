class_name Watercan
extends Area2D

@export var water_count := 10
@export var max_contained_water := 3
@export var water_scene: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var water_spawn_position: Marker2D = %WaterSpawnPosition

@onready var contained_water := max_contained_water

func spawn_waters() -> void:
	contained_water -= 1
	
	for i in range(water_count):
		var water: WaterDrop = water_scene.instantiate()
		water.global_position = water_spawn_position.global_position + \
			(Vector2.RIGHT.rotated(randf() * 2 * PI) * 10)
		
		get_tree().current_scene.add_child(water)

func _on_tool_used() -> void:
	animation_player.play("pouring")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "pouring":
		animation_player.play("RESET")
	elif anim_name == "RESET":
		pass
	else:
		push_error("unknown animation finished " + anim_name)
