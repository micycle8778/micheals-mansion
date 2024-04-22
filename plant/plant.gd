class_name Plant
extends Area2D

signal health_changed(new_health: int)

static var instance: Plant

@export var water_drain_per_second := 22.0

var water := 100.0
var health := 10:
	set(v):
		health = v
		health_changed.emit(v)

func _init() -> void:
	instance = self

func _on_area_entered(area: Area2D) -> void:
	if area is Insect:
		health -= 1
		area.queue_free()
