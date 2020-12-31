
class ParticleSystem {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  FloatList particleAttribList = new FloatList();
  float[] particlesBuffer;
  float[] particlesColorBuffuer;
  FloatBuffer fbParticles;
  FloatBuffer fbParticleColors;
  int numOfParticles;
  ShaderProgram shaderProgram;
  ComputeProgram computeProgram;

  ParticleSystem(int count) {

    numOfParticles = count;
    for (int i=0; i<count; i++) {
      Particle p = new Particle();

      p.pos.x = random(-1, 1);
      p.pos.y = random(-1, 1);

      particleAttribList.append(p.pos.x);
      particleAttribList.append(p.pos.y);
      particleAttribList.append(p.vel.x);
      particleAttribList.append(p.vel.y);
      particleAttribList.append(p.acc.x);
      particleAttribList.append(p.acc.y);
    }
    
    particlesBuffer = new float[particleAttribList.size()];
    for (int i = 0; i<particlesBuffer.length; i++) {
      particlesBuffer[i] = particleAttribList.get(i);
    }

    fbParticles = Buffers.newDirectFloatBuffer(particlesBuffer);
    shaderProgram = new ShaderProgram(gl, "vert.glsl", "frag.glsl");
    computeProgram = new ComputeProgram(gl, "comp.glsl", fbParticles);
  }

  void loadShaer(String v, String f, String c) {
    shaderProgram = new ShaderProgram(gl, v, f);
    computeProgram = new ComputeProgram(gl, c, fbParticles);
  }

  void update() {
    computeProgram.beginDispatch(1024, 1, 1);
    shaderProgram.begin();
  }

  void render() {
    shaderProgram.draw(numOfParticles);
  }

  void release() {
    shaderProgram.release();
    computeProgram.release();
  }
}
