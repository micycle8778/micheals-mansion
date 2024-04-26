class_name World
extends Node2D

@export var spawn_timer := 1.75
		
@export var minimum_spawn_timer := .5
@export var spawn_ramp := .02

@export var insect_scene: PackedScene = preload("uid://c4ik87aloa2yr")

@onready var spawning_path: Path2D = %SpawningPath

static var level_started_msec: float
static var death_reason: Plant.DeathReason

func spawning_coroutine() -> void:
	while true:
		await Autoloaded.get_tree().create_timer(spawn_timer).timeout
		
		for i in range(2):
			var curve := spawning_path.curve
			var sample := randf() * curve.point_count
			var spawn_pos := spawning_path.curve.samplef(sample)
			var insect: Insect = insect_scene.instantiate()
			
			insect.position = spawn_pos
			add_child(insect)
		
		spawn_timer = maxf(spawn_timer - spawn_ramp, minimum_spawn_timer)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		#print("unhandled event: ", event)
		pass

func _ready() -> void:
	level_started_msec = Time.get_ticks_msec()
	
	spawning_coroutine()
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _on_plant_died(reason: Plant.DeathReason) -> void:
	death_reason = reason
	get_tree().change_scene_to_file.call_deferred("uid://mtwl05xvpndq")

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
