extends Node
class_name Walker

var NEXT_DIR = {Vector2.RIGHT: [Vector2.UP, Vector2.LEFT, Vector2.DOWN],
					Vector2.LEFT: [Vector2.UP, Vector2.RIGHT, Vector2.DOWN],
					Vector2.UP: [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN],
					Vector2.DOWN: [Vector2.UP, Vector2.LEFT, Vector2.RIGHT]}

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var border = Rect2()
var step_history = []
var steps_since_turn = 0
# Called when the node enters the scene tree for the first time.

func _init(start, bounds):
	assert(bounds.has_point(start))
	position = start
	step_history.append(position)
	border = bounds
	
func walk(steps):
	print(len(step_history))
	for i in steps:
		if randf() <= 0.25 or steps_since_turn >= 5:
			change_direction()
		if step():
			if not position in step_history:
				step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target = position + direction
	if border.has_point(target):
		steps_since_turn += 1
		position = target
		return true
	else:
		return false

func change_direction():
	steps_since_turn = 0
	var possible = NEXT_DIR[direction].duplicate()
	var waspossible = possible.duplicate()
	possible.shuffle()
	var new_dir = possible.pop_front()
	while not border.has_point(position + new_dir):
		new_dir = possible.pop_front()
	direction = new_dir

