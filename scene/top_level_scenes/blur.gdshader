shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float radius = 4.0;

void fragment() {
    vec4 col = texture(screen_texture, SCREEN_UV);
    vec2 ps = TEXTURE_PIXEL_SIZE;

    col += texture(screen_texture, SCREEN_UV + vec2(0.0, -radius) * ps);
    col += texture(screen_texture, SCREEN_UV + vec2(0.0, radius) * ps);
    col += texture(screen_texture, SCREEN_UV + vec2(-radius, 0.0) * ps);
    col += texture(screen_texture, SCREEN_UV + vec2(radius, 0.0) * ps);
    col /= 5.0;

    COLOR = col;
}
