class_name Card extends Node2D
const FLIPPED = preload("res://new_sprite_frames.tres")
@export var sprites : SpriteFrames
var visual : Sprite2D
var flipped : bool

var flipped_texture : Texture
var visible_texture : Texture

var value : int

func create(_texture : Texture, val : int):
	visual = Sprite2D.new()
	value = val
	load_textures(_texture)
	set_flipped(false)
	add_child(visual)

func set_flipped(d_flipped : bool):
	if d_flipped == false:
		visual.texture = visible_texture
	else:
		visual.texture = flipped_texture

func load_textures(_texture : Texture):
	visible_texture = _texture
	flipped_texture = FLIPPED.get_frame_texture("default", 0)
	pass
