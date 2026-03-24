extends Ant

func _ready():
	speed = 250.0

func _draw():
	var points = PackedVector2Array([
		Vector2(0, -10),
		Vector2(-9, 7),
		Vector2(9, 7),
	])
	draw_polygon(points, PackedColorArray([Color.YELLOW, Color.YELLOW, Color.YELLOW]))
