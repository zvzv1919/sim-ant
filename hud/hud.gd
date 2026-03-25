extends PanelContainer

signal ant_type_selected(ant_type: String)
signal spawn_interval_changed(interval: float)
signal spawn_spread_changed(spread: float)

@onready var fire_btn = $MarginContainer/VBoxContainer/FireAntButton
@onready var leaf_btn = $MarginContainer/VBoxContainer/LeafCutterButton
@onready var army_btn = $MarginContainer/VBoxContainer/ArmyAntButton
@onready var bullet_btn = $MarginContainer/VBoxContainer/BulletAntButton
@onready var repulsive_btn = $MarginContainer/VBoxContainer/RepulsiveAntButton
@onready var spawn_slider = $MarginContainer/VBoxContainer/SpawnIntervalSlider
@onready var spawn_label = $MarginContainer/VBoxContainer/SpawnIntervalLabel
@onready var spread_slider = $MarginContainer/VBoxContainer/SpawnSpreadSlider
@onready var spread_label = $MarginContainer/VBoxContainer/SpawnSpreadLabel

var selected_ant_type := "fire_ant"
var spawn_interval: float:
	get: return spawn_slider.value
var spawn_spread: float:
	get: return spread_slider.value

func _ready():
	fire_btn.pressed.connect(_select.bind("fire_ant"))
	leaf_btn.pressed.connect(_select.bind("leaf_cutter"))
	army_btn.pressed.connect(_select.bind("army_ant"))
	bullet_btn.pressed.connect(_select.bind("bullet_ant"))
	repulsive_btn.pressed.connect(_select.bind("repulsive_ant"))
	_highlight_selected()
	spawn_slider.value_changed.connect(_on_spawn_interval_changed)
	_update_spawn_label()
	spread_slider.value_changed.connect(_on_spawn_spread_changed)
	_update_spread_label()

func _select(ant_type: String):
	selected_ant_type = ant_type
	_highlight_selected()
	ant_type_selected.emit(ant_type)

func _highlight_selected():
	fire_btn.button_pressed = (selected_ant_type == "fire_ant")
	leaf_btn.button_pressed = (selected_ant_type == "leaf_cutter")
	army_btn.button_pressed = (selected_ant_type == "army_ant")
	bullet_btn.button_pressed = (selected_ant_type == "bullet_ant")
	repulsive_btn.button_pressed = (selected_ant_type == "repulsive_ant")

func _on_spawn_interval_changed(value: float):
	spawn_interval_changed.emit(value)
	_update_spawn_label()

func _update_spawn_label():
	spawn_label.text = "Spawn: %.0f ms" % (spawn_slider.value * 1000)

func _on_spawn_spread_changed(value: float):
	spawn_spread_changed.emit(value)
	_update_spread_label()

func _update_spread_label():
	spread_label.text = "Spread: %.0f px" % spread_slider.value
