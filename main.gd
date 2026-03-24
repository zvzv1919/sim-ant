extends Node2D

var ant_scenes := {
	"fire_ant": preload("res://ants/fire_ant.tscn"),
	"leaf_cutter": preload("res://ants/leaf_cutter.tscn"),
	"army_ant": preload("res://ants/army_ant.tscn"),
}
var selected_ant_type := "fire_ant"

@onready var world = $World
@onready var red_btn = $CanvasLayer/SidePanel/MarginContainer/VBoxContainer/RedCircleButton
@onready var green_btn = $CanvasLayer/SidePanel/MarginContainer/VBoxContainer/GreenCircleButton
@onready var yellow_btn = $CanvasLayer/SidePanel/MarginContainer/VBoxContainer/YellowTriangleButton
@onready var side_panel = $CanvasLayer/SidePanel

func _ready():
	red_btn.pressed.connect(_select.bind("fire_ant"))
	green_btn.pressed.connect(_select.bind("leaf_cutter"))
	yellow_btn.pressed.connect(_select.bind("army_ant"))
	_highlight_selected()

func _select(ant_type: String):
	selected_ant_type = ant_type
	_highlight_selected()

func _highlight_selected():
	red_btn.button_pressed = (selected_ant_type == "fire_ant")
	green_btn.button_pressed = (selected_ant_type == "leaf_cutter")
	yellow_btn.button_pressed = (selected_ant_type == "army_ant")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var panel_rect = side_panel.get_global_rect()
			if not panel_rect.has_point(event.position):
				var ant = ant_scenes[selected_ant_type].instantiate()
				ant.position = event.position
				world.add_child(ant)
