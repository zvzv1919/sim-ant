extends Node

const REPULSE_STRENGTH := 8000.0
const REPULSE_RADIUS := 150.0
const CELL_SIZE := 150.0

var _positions: PackedVector2Array
var _forces: PackedVector2Array
var _neighbor_offsets: PackedInt32Array
var _neighbor_counts: PackedInt32Array
var _neighbor_list: PackedInt32Array
var _ant_refs: Array[RigidBody2D] = []

func _physics_process(_delta):
	_ant_refs.clear()
	for node in get_tree().get_nodes_in_group("repulsive_ants"):
		if is_instance_valid(node):
			_ant_refs.append(node as RigidBody2D)

	var count := _ant_refs.size()
	if count < 2:
		return

	_positions.resize(count)
	_forces.resize(count)
	for i in count:
		_positions[i] = _ant_refs[i].global_position
		_forces[i] = Vector2.ZERO

	_build_neighbor_lists(count)

	var group_id := WorkerThreadPool.add_group_task(
		_compute_force, count, -1, true
	)
	WorkerThreadPool.wait_for_group_task_completion(group_id)

	for i in count:
		if is_instance_valid(_ant_refs[i]):
			_ant_refs[i].apply_central_force(_forces[i])

func _build_neighbor_lists(count: int):
	var grid := {}
	for i in count:
		var key := Vector2i(
			int(floor(_positions[i].x / CELL_SIZE)),
			int(floor(_positions[i].y / CELL_SIZE))
		)
		if not grid.has(key):
			grid[key] = []
		grid[key].append(i)

	_neighbor_offsets.resize(count)
	_neighbor_counts.resize(count)
	var flat: Array[int] = []

	for i in count:
		var cx := int(floor(_positions[i].x / CELL_SIZE))
		var cy := int(floor(_positions[i].y / CELL_SIZE))
		var start := flat.size()
		_neighbor_offsets[i] = start
		var n := 0
		for dx in range(-1, 2):
			for dy in range(-1, 2):
				var key := Vector2i(cx + dx, cy + dy)
				if grid.has(key):
					for j in grid[key]:
						if j != i:
							flat.append(j)
							n += 1
		_neighbor_counts[i] = n

	_neighbor_list = PackedInt32Array(flat)

func _compute_force(ant_index: int):
	var pos := _positions[ant_index]
	var force := Vector2.ZERO
	var start := _neighbor_offsets[ant_index]
	var n := _neighbor_counts[ant_index]

	for k in range(start, start + n):
		var j := _neighbor_list[k]
		var offset := pos - _positions[j]
		var dist := offset.length()
		if dist < 1.0:
			var angle := float(ant_index) * 2.399
			offset = Vector2(cos(angle), sin(angle))
			dist = 1.0
		if dist < REPULSE_RADIUS:
			force += offset.normalized() * (REPULSE_STRENGTH / (dist * dist))

	_forces[ant_index] = force
