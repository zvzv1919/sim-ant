extends RigidBody2D

const REPULSE_STRENGTH := 8000.0
const REPULSE_RADIUS := 150.0

func _ready():
	gravity_scale = 0.0
	linear_damp = 2.0
	collision_layer = 0
	collision_mask = 0
	add_to_group("repulsive_ants")

func _physics_process(_delta):
	var force := Vector2.ZERO
	for other in get_tree().get_nodes_in_group("repulsive_ants"):
		if other == self:
			continue
		var offset: Vector2 = global_position - other.global_position
		var dist := offset.length()
		if dist < 1.0:
			offset = Vector2(randf() - 0.5, randf() - 0.5).normalized()
			dist = 1.0
		if dist < REPULSE_RADIUS:
			force += offset.normalized() * (REPULSE_STRENGTH / (dist * dist))
	apply_central_force(force)

	var vp := get_viewport_rect().size
	if global_position.x < -50 or global_position.x > vp.x + 50 \
		or global_position.y < -50 or global_position.y > vp.y + 50:
		queue_free()
