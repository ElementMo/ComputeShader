#version 430

layout(binding = 0) buffer PosBuffer
{
	vec2 positions[];
};

layout(local_size_x = 1000, local_size_y = 1, local_size_z = 1) in;


void main()
{
	uint index = gl_GlobalInvocationID.x;

    positions[index].x += 0.001f;
}