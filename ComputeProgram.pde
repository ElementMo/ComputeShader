class ComputeProgram
{
  private int compute_program;
  private int compute_shader;
  private int ssbo;
  private int[] vbo = new int[1];

  private GL4 gl;

  ComputeProgram(GL4 gl, String compute) {
    this.gl = gl;

    String[] vlines = new String[]{PApplet.join(loadStrings(compute), "\n")};
    int[] vlengths = new int[]{vlines[0].length()};
    compute_shader = gl.glCreateShader(gl.GL_COMPUTE_SHADER);
    gl.glShaderSource(compute_shader, vlines.length, vlines, vlengths, 0);
    gl.glCompileShader(compute_shader);

    compute_program = gl.glCreateProgram();
    gl.glAttachShader(compute_program, compute_shader);
    gl.glLinkProgram(compute_program);

    gl.glGenBuffers(1, vbo, 0);
    gl.glBindBuffer(gl.GL_ARRAY_BUFFER, vbo[0]);
    gl.glBufferData(GL.GL_ARRAY_BUFFER, fbVertices.limit() * 4, fbVertices, gl.GL_STATIC_DRAW);
    gl.glEnableVertexAttribArray(0);
    gl.glVertexAttribPointer(0, 2, gl.GL_FLOAT, false, 8, 0);

    ssbo = vbo[0];
    gl.glBindBufferBase(gl.GL_SHADER_STORAGE_BUFFER, 0, ssbo);
  }

  void beginDispatch(int x, int y, int z) {
    gl.glUseProgram(compute_program);
    gl.glDispatchCompute(x, y, z);
  }
}
