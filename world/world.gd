extends Node2D

var ant_scenes := {
	"fire_ant": preload("res://ants/fire_ant.tscn"),
	"leaf_cutter": preload("res://ants/leaf_cutter.tscn"),
	"army_ant": preload("res://ants/army_ant.tscn"),
	"bullet_ant": preload("res://ants/bullet_ant.tscn"),
}
var selected_ant_type := "fire_ant"
var _mouse_held := false
var _spawn_timer := 0.0
var spawn_interval := 0.08
var _excluded_rect: Control

func set_excluded_control(control: Control):
	_excluded_rect = control

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if _excluded_rect and _excluded_rect.get_global_rect().has_point(event.position):
				return
			_mouse_held = true
			_spawn_timer = 0.0
			_spawn_ant(event.position)
		else:
			_mouse_held = false

func _process(delta):
	if _mouse_held:
		_spawn_timer += delta
		if _spawn_timer >= spawn_interval:
			_spawn_timer -= spawn_interval
			var pos = get_viewport().get_mouse_position()
			if _excluded_rect and _excluded_rect.get_global_rect().has_point(pos):
				return
			_spawn_ant(pos)

func _spawn_ant(pos: Vector2):
	var ant = ant_scenes[selected_ant_type].instantiate()
	ant.position = pos
	add_child(ant)
