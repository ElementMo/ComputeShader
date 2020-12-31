#version 400 core

layout(location = 0) in vec2 in_position;
layout(location = 1) in vec2 in_velocity;

out vec4 color;

uniform vec2 hue_range;

float map(float val, float a, float b, float c, float d) {
	float result = c + (d - c) * ((val - a) / (b - a));
	return result;
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void) {
    gl_Position = vec4(in_position.xy, 0.0, 1.0);
    float hue = map(length(in_velocity), 0, 0.03, hue_range.x, hue_range.y);
    vec3 rgb = hsv2rgb(vec3(hue, 0.8, 0.9));
    color = vec4(rgb, 0.8);
}
