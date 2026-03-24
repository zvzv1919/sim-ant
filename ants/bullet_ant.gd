extends Ant

var acceleration := 100.0

func _ready():
	speed = -100.0

func _process(delta):
	speed -= acceleration * delta
	position.x += speed * delta
	if position.x < -20:
		queue_free()
