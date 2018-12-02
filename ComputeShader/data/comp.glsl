#version 430

layout(binding = 0) buffer PosBuffer
{
	vec2 positions[];
};

layout(local_size_x = 1000) in;


void main()
{
	uint index = gl_GlobalInvocationID.x;

    positions[index] *= 1.01f;
}