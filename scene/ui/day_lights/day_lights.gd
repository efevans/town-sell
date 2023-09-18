extends CanvasLayer

const END_COLOR = Color(0.93333333730698, 0.70588237047195, 0.0588235296309)

@onready var timer = $Timer
@onready var color_rect = $ColorRect


func _ready():
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var shader_material = color_rect.material as ShaderMaterial
	var intensity = shader_material.get_shader_parameter("light_intensity")
	shader_material.set_shader_parameter("light_intensity", min(intensity + 0.05, 1))
