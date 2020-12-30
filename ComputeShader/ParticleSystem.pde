
class ParticleSystem {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  FloatList v = new FloatList();
  float[] verticesBuffer;
  FloatBuffer fbVertices;
  int numOfParticles;
  ShaderProgram shaderProgram;
  ComputeProgram computeProgram;

  ParticleSystem(int count) {

    numOfParticles = count;
    for (int i=0; i<count; i++) {
      Particle p = new Particle();

      p.pos.x = random(-1, 1);
      p.pos.y = random(-1, 1);

      v.append(p.pos.x);
      v.append(p.pos.y);
      v.append(p.vel.x);
      v.append(p.vel.y);
      v.append(p.acc.x);
      v.append(p.acc.y);
    }

    verticesBuffer = new float[v.size()];
    for (int i = 0; i<verticesBuffer.length; i++) {
      verticesBuffer[i] = v.get(i);
    }

    fbVertices = Buffers.newDirectFloatBuffer(verticesBuffer);
    shaderProgram = new ShaderProgram(gl, "vert.glsl", "frag.glsl");
    computeProgram = new ComputeProgram(gl, "comp.glsl", fbVertices);
  }

  void loadShaer(String v, String f, String c) {
    shaderProgram = new ShaderProgram(gl, v, f);
    computeProgram = new ComputeProgram(gl, c, fbVertices);
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
