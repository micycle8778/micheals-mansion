class_name World
extends Node2D

@export var spawn_timer := 1.0
@export var minimum_spawn_timer := .05
@export var spawn_ramp := .05

@export var insect_scene: PackedScene = preload("uid://c4ik87aloa2yr")

@onready var spawning_path: Path2D = %SpawningPath

func spawning_coroutine() -> void:
	while true:
		await get_tree().create_timer(spawn_timer).timeout
		
		for i in range(2):
			var curve := spawning_path.curve
			var sample := randf() * curve.point_count
			var spawn_pos := spawning_path.curve.samplef(sample)
			var insect: Insect = insect_scene.instantiate()
			
			insect.position = spawn_pos
			add_child(insect)
		
		spawn_timer = max(spawn_timer - spawn_ramp, spawn_timer)

func _ready() -> void:
	spawning_coroutine()
