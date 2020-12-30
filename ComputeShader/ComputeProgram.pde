class ComputeProgram
{
  int compute_program;
  int compute_shader;
  int ssbo;
  int[] vbo = new int[1];


  GL4 gl;

  ComputeProgram(GL4 gl, String compute, FloatBuffer verticesFB) {
    this.gl = gl;

    String[] vlines = new String[]{PApplet.join(loadStrings(compute), "\n")};
    int[] vlengths = new int[]{vlines[0].length()};
    compute_shader = gl.glCreateShader(GL4.GL_COMPUTE_SHADER);
    gl.glShaderSource(compute_shader, vlines.length, vlines, vlengths, 0);
    gl.glCompileShader(compute_shader);

    compute_program = gl.glCreateProgram();
    gl.glAttachShader(compute_program, compute_shader);
    gl.glLinkProgram(compute_program);

    gl.glGenBuffers(1, vbo, 0);
    gl.glBindBuffer(GL4.GL_ARRAY_BUFFER, vbo[0]);
    gl.glBufferData(GL4.GL_ARRAY_BUFFER, verticesFB.limit()*4, verticesFB, GL4.GL_DYNAMIC_DRAW);
    gl.glEnableVertexAttribArray(0);
    // Since the Particle struct has 3 vec2 variables, then the stride is 24
    gl.glVertexAttribPointer(0, 2, GL4.GL_FLOAT, false, 24, 0);

    ssbo = vbo[0];
    gl.glBindBufferBase(GL4.GL_SHADER_STORAGE_BUFFER, 0, ssbo);
  }

  void beginDispatch(int x, int y, int z) {
    gl.glUseProgram(compute_program);

    updateUniform2f("mouse", (float)map(mouseX, 0, width, -1, 1), (float)map(mouseY, 0, height, 1, -1));
    if (mousePressed) {
      updateUniform1i("isPressed", 1);
    } else {
      updateUniform1i("isPressed", 0);
    }
    gl.glDispatchCompute(x, y, z);
    gl.glUseProgram(0);
  }


  void updateUniform1i(String uniformName, int uniformValue) {

    int loc = gl.glGetUniformLocation(compute_program, uniformName);
    if (loc != -1)
    {
      gl.glUniform1i(loc, uniformValue);
    }
  }



  void updateUniform1f(String uniformName, float uniformValue) {
    Integer loc = gl.glGetUniformLocation(compute_program, uniformName);
    if (loc != -1)
    {
      gl.glUniform1f(loc, uniformValue);
    }
  }


  void updateUniform2f(String uniformName, float uniformValue1, float uniformValue2) {

    int loc = gl.glGetUniformLocation(compute_program, uniformName);
    gl.glUniform2f(loc, uniformValue1, uniformValue2);

    if (loc != -1)
    {
      gl.glUniform2f(loc, uniformValue1, uniformValue2);
    }
  }

  void updateUniform3f(String uniformName, float uniformValue1, float uniformValue2, float uniformValue3) {

    int loc = gl.glGetUniformLocation(compute_program, uniformName);
    if (loc != -1)
    {
      gl.glUniform3f(loc, uniformValue1, uniformValue2, uniformValue3);
    }
  }

  void release() {
    gl.glDeleteProgram(compute_program);
  }
}
