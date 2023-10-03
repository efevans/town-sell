extends Resource
class_name Item

@export var id: String
@export var name: String
@export var base_price: int 
@export var icon: CompressedTexture2D
@export var text_color: Color

func text_color_html():
	return text_color.to_html()
