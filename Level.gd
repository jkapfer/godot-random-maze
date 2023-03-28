extends Node2D

var borders = Rect2(1,1, 30, 17)

onready var space = $Space
onready var dungeon = $Dungeon

func _ready():
	randomize()
	generate_level()
	
func generate_level():
	var walker = Walker.new(Vector2(15,17), borders)
	var map = walker.walk(500)
	for location in map:
		space.set_cellv(location, -1)
	for x in borders.size.x+1:
		for y in borders.size.y+2:
			var pt = Vector2(x,y)
			if not pt in map:
				dungeon.set_cellv(pt, -1)
	space.update_bitmask_region()
	dungeon.update_bitmask_region()
	
