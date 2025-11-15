extends Node2D

@export var tilemap: TileMap
@export var map_size: Vector2i

@export var fill_tile: Vector2i

func _ready() -> void:
	gen()

func fill(pos1: Vector2i, pos2: Vector2i, tile_pos: Vector2i) -> void:
	for i in pos2.x:
		for j in pos2.y:
			tilemap.set_cell(0, Vector2i(i + pos1.x, j + pos1.y), 0, tile_pos)

func get_tile_by_noise(color: float) -> Vector2i:
	var ret: Vector2i = Vector2i(0, 0)
	
	if color < 0.6666:
		ret = Vector2i(0,1)
	if color < 0.3333:
		ret = Vector2i(1,0)
	
	return ret

func gen() -> void:
	fill(Vector2i(0,0), map_size, fill_tile)
	
	var noise: FastNoiseLite = FastNoiseLite.new()
	noise.seed = randi()
	var noise_img: Image = noise.get_image(map_size.x, map_size.y)
	
	for i in noise_img.get_width():
		for j in noise_img.get_height():
			tilemap.set_cell(0, Vector2i(i, j), 0, get_tile_by_noise(noise_img.get_pixel(i, j).r), 0)
