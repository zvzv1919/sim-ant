extends Ant

func _ready():
	speed = 200.0

func _draw():
	draw_circle(Vector2.ZERO, 8.0, Color.RED)
