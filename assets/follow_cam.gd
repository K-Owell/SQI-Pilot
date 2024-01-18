extends Camera2D

@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemapSize = tilemap.get_used_rect().size
	var tileSize = Vector2(1, 1)  # Default tile size if not specified in the TileSet
	if tilemap.tile_set:
		tileSize = tilemap.tile_set.tile_size
	
	var upperLeftCorner = tilemap.to_global(Vector2(0, 0))
	var lowerRightCorner = tilemap.to_global(tilemapSize * tileSize)

	limit_left = upperLeftCorner.x
	limit_top = upperLeftCorner.y
	limit_right = lowerRightCorner.x
	limit_bottom = lowerRightCorner.y
