shader_type canvas_item;

uniform sampler2D screen: hint_screen_texture, filter_nearest;
uniform sampler2D noise: repeat_enable;
uniform sampler2D icon;

void fragment() {
	float flow;
	float offset = texture(noise, vec2(UV.x, UV.y)).b;
	COLOR = texture(screen, SCREEN_UV / offset);
}