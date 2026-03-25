extends RigidBody2D

func _ready():
	gravity_scale = 0.0
	linear_damp = 2.0
	collision_layer = 0
	collision_mask = 0
	add_to_group("repulsive_ants")

func _physics_process(_delta):
	var vp := get_viewport_rect().size
	if global_position.x < -50 or global_position.x > vp.x + 50 \
		or global_position.y < -50 or global_position.y > vp.y + 50:
		queue_free()
