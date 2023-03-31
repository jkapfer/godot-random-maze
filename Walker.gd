extends Node

class_name Walker

const DIRECTIONS = {Vector2.UP: [Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN],
					Vector2.DOWN: [Vector2.LEFT, Vector2.RIGHT, Vector2.UP], 
					Vector2.RIGHT: [Vector2.LEFT, Vector2.DOWN, Vector2.UP],
					Vector2.LEFT: [Vector2.DOWN, Vector2.RIGHT, Vector2.UP]}

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var border = Rect2()
var step_history = []
var steps_since_turn = 0

func _init(start_location, boundary):
	position = start_location
	border = boundary
	step_history.append(position)
	
func make_map(steps):
	for i in steps:
		if randf() < 0.3 or steps_since_turn < 3:
			change_direction()
		if take_step():
			steps_since_turn += 1
			step_history.append(position)
		else:
			change_direction()
	return step_history
		
func take_step():
	if border.has_point(position+direction):
		position += direction
		return true
	return false
	
func change_direction():
	var possible_dir = DIRECTIONS[direction].duplicate()
	possible_dir.shuffle()
	var next_dir = possible_dir.pop_back()
	while not border.has_point(position + next_dir):
		next_dir = possible_dir.pop_back()
	direction = next_dir
