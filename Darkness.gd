extends Sprite2D

var original_darkness_texture : ImageTexture = ImageTexture.new()
var original_darkness_image : Image
var original_light_texture : ImageTexture = ImageTexture.new()
var original_light_image : Image

var last_torch_pos = Vector2.ZERO

var last_lumen_pos_size : int = 0
var lumen_positions : Array[Vector2] = []

func _ready():
	# visible = true
	
	var darkness = load("res://assets/world/Darkness.png")
	var img : Image = darkness.get_image()
	img.resize(32 * scale.x, 32 * scale.y)
	img.convert(Image.FORMAT_RGBAH)
	
	original_darkness_image = img
	original_darkness_texture = original_darkness_texture.create_from_image(img)
	texture = original_darkness_texture
	scale = Vector2(1, 1)
	
	load_light()
	PlayerAutoload.connect("candela_changed", load_light)

func load_light() -> void:
	var light : Image= load("res://assets/world/Light.png").get_image()
	light.resize(light.get_width() * PlayerAutoload.get_light_strength() * 2, light.get_width() * PlayerAutoload.get_light_strength() * 2)
	light.convert(Image.FORMAT_RGBAH)
	original_light_texture = original_light_texture.create_from_image(light)
	original_light_image = light
	update_texture()

func _physics_process(delta):
	if last_lumen_pos_size != PlayerAutoload.lumen_positions.size():
		last_lumen_pos_size = PlayerAutoload.lumen_positions.size()
		var global_texture_rect = Rect2(global_position - Vector2(64, 64) * 6, (original_darkness_texture.get_size() + Vector2(128, 128)) * 6)
		for pos in PlayerAutoload.lumen_positions:
			if  global_texture_rect.has_point(pos):
				lumen_positions.append(pos)
	if PlayerAutoload.player != null:
		var torch_pos = PlayerAutoload.player.TorchPosition.global_position
		var global_texture_rect = Rect2(global_position - Vector2(64, 64) * 6, (original_darkness_texture.get_size() + Vector2(128, 128)) * 6)
		if global_texture_rect.has_point(torch_pos) && torch_pos != last_torch_pos:
			last_torch_pos = torch_pos
			update_texture()

func update_texture() -> void:
	var new_image = original_darkness_texture.get_image()
	var rect = Rect2(Vector2.ZERO, original_light_image.get_size())
	var tmp = Vector2(original_light_image.get_width() / 2, original_light_image.get_height() / 2) * 6
	new_image.blend_rect(original_light_image, rect, (last_torch_pos - global_position - tmp) / 6)
	#for pos in lumen_positions:
	#	new_image.blend_rect(original_light_image, rect, (pos - global_position - tmp) / 6)
	texture = ImageTexture.new().create_from_image(new_image)
