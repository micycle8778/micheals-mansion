class_name Insect
extends Area2D

@export var speed := 200

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			queue_free()

func _ready() -> void:
	if Plant.instance == null:
		process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	look_at(Plant.instance.global_position)

func _physics_process(delta: float) -> void:
	var to_plant := (Plant.instance.global_position - global_position) \
		.normalized()
		
	position += to_plant * speed * delta
