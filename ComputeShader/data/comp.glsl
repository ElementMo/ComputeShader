#version 430
uniform vec2 mouse;
uniform int isPressed;

struct Particle{
	vec2 pos;
	vec2 vel;
	vec2 acc;
};

layout(std430, binding = 0) buffer particlesBuffer
{
	Particle particles[];
};

layout(local_size_x = 1024, local_size_y = 1, local_size_z = 1) in;

void main()
{
	uint i = gl_GlobalInvocationID.x;

	if(isPressed == 0)
	{
		vec2 force = mouse - particles[i].pos;
		force = normalize(force);
		force *= 0.001f;
		particles[i].acc = force;
		particles[i].pos += particles[i].vel;
		particles[i].vel += particles[i].acc;
	}
	else if(isPressed == 1)
	{
		vec2 force = particles[i].pos - mouse;
		force = normalize(force);
		force *= 0.001f;
		particles[i].acc = force;
		particles[i].pos += particles[i].vel;
		particles[i].vel += particles[i].acc;
	}



	// vec2 dir = attractor - particles[i].pos;

	// float d = dot(dir, dir);
    // particles[i].acc = strength*(d+0.001)*dir;
	// particles[i].vel += particles[i].acc;
	// particles[i].vel *= drag;

	// particles[i].pos += particles[i].vel;
}