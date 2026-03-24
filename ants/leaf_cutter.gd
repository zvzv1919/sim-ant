extends Ant

func _ready():
	speed = 150.0

func _draw():
	draw_circle(Vector2.ZERO, 8.0, Color.GREEN)
