class_name Swatta
extends Node2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var area_2d: Area2D = %Area2D

func _physics_process(_delta: float) -> void:
	if animation_player.current_animation == "swatting":
		for area in area_2d.get_overlapping_areas():
			if area is Insect:
				area.queue_free()

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "swatting":
		animation_player.play("RESET")
	elif anim_name == "RESET":
		pass
	else:
		push_error("unknown animation finished " + anim_name)

func _on_tool_used() -> void:
	animation_player.play("swatting")
