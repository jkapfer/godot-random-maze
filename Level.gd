extends Node2D

onready var space = $Space
onready var dungeon = $Dungeon

var border = Rect2(1, 1, 30, 17)
func _ready():
	randomize()
	generate_level()
	
func generate_level():	
	var etch_a_sketch = Walker.new(Vector2(15, 17), border)
	var level_map = etch_a_sketch.make_map(500)
	for loc in level_map:
		space.set_cellv(loc, -1)
	for x in border.size.x + 2:
		for y in border.size.y + 2:
			var pt = Vector2(x, y)
			if not pt in level_map:
				dungeon.set_cellv(pt, -1)
	space.update_bitmask_region()
	dungeon.update_bitmask_region()
