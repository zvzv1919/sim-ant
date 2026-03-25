extends Node2D

@onready var world = $World
@onready var hud = $CanvasLayer/HUD

func _ready():
	world.set_excluded_control(hud)
	hud.ant_type_selected.connect(func(t): world.selected_ant_type = t)
	world.spawn_interval = hud.spawn_interval
	hud.spawn_interval_changed.connect(func(i): world.spawn_interval = i)
	world.spawn_spread = hud.spawn_spread
	hud.spawn_spread_changed.connect(func(s): world.spawn_spread = s)
