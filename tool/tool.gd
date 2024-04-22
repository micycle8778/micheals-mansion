class_name Tool
extends Area2D

signal picked_up
signal dropped
signal used

static var tool_held := false

var in_use := false:
	set(v):
		if tool_held:
			return
		
		in_use = v
		if v:
			picked_up.emit()
		else:
			dropped.emit()
			tool_held = false

var hold_spot := Vector2()

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("use_tool"):
		if in_use:
			used.emit()
		else:
			# this no-ops if tool_held = true
			in_use = true
			hold_spot = get_global_mouse_position() - get_parent().global_position
	elif event.is_action_pressed("drop_tool"):
		in_use = false

func _process(_delta: float) -> void:
	if in_use:
		get_parent().global_position = get_global_mouse_position() - hold_spot
		print(position)
