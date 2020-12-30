#version 400 core

layout(location = 0) in vec4 in_position;
in vec2 resolution;

out vec4 color;

void main(void) {
    gl_Position = in_position;
    color = vec4(0, 1, 1, 1);
}
