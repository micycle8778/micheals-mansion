class_name Insect
extends Area2D

@export var speed := 200

func _ready() -> void:
	if Plant.instance == null:
		process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	look_at(Plant.instance.global_position)

func _physics_process(delta: float) -> void:
	var to_plant := (Plant.instance.global_position - global_position) \
		.normalized()
		
	position += to_plant * speed * delta
