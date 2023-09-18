shader_type canvas_item;

uniform float light_intensity: hint_range(0.0, 1.0, 0.1);
uniform float western_bias: hint_range(8.0, 20.0, 0.5);
uniform float max_intensity: hint_range(0.0, 1.0, 0.01);
uniform vec4 light_rgb : source_color = vec4(0.0, 0.0, 0.0, 1.0);


float vignette(vec2 uv){
	float proximity_to_top = (max_intensity - uv.y);
	float proximity_to_left = (max_intensity - uv.x);
	float western_weight = 21.0 - western_bias;
	float weighted_proximity_to_left = proximity_to_left / western_weight;
	float vignette = (proximity_to_top + weighted_proximity_to_left) / (1.0 + 1.0 / western_weight);
	
	return pow(vignette, pow((4.0 - (light_intensity * 2.0)), 2));
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	tex.rgba *= (light_rgb.rgba);
	tex.rgba *= vignette(UV);
	
	COLOR = vec4((tex.rgb), tex.a);
}
