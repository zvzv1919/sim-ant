extends PanelContainer

signal ant_type_selected(ant_type: String)
signal spawn_interval_changed(interval: float)

@onready var fire_btn = $MarginContainer/VBoxContainer/FireAntButton
@onready var leaf_btn = $MarginContainer/VBoxContainer/LeafCutterButton
@onready var army_btn = $MarginContainer/VBoxContainer/ArmyAntButton
@onready var bullet_btn = $MarginContainer/VBoxContainer/BulletAntButton
@onready var spawn_slider = $MarginContainer/VBoxContainer/SpawnIntervalSlider
@onready var spawn_label = $MarginContainer/VBoxContainer/SpawnIntervalLabel

var selected_ant_type := "fire_ant"

func _ready():
	fire_btn.pressed.connect(_select.bind("fire_ant"))
	leaf_btn.pressed.connect(_select.bind("leaf_cutter"))
	army_btn.pressed.connect(_select.bind("army_ant"))
	bullet_btn.pressed.connect(_select.bind("bullet_ant"))
	_highlight_selected()
	spawn_slider.value_changed.connect(_on_spawn_interval_changed)
	_update_spawn_label()

func _select(ant_type: String):
	selected_ant_type = ant_type
	_highlight_selected()
	ant_type_selected.emit(ant_type)

func _highlight_selected():
	fire_btn.button_pressed = (selected_ant_type == "fire_ant")
	leaf_btn.button_pressed = (selected_ant_type == "leaf_cutter")
	army_btn.button_pressed = (selected_ant_type == "army_ant")
	bullet_btn.button_pressed = (selected_ant_type == "bullet_ant")

func _on_spawn_interval_changed(value: float):
	spawn_interval_changed.emit(value)
	_update_spawn_label()

func _update_spawn_label():
	spawn_label.text = "Spawn: %.0f ms" % (spawn_slider.value * 1000)
