import com.jogamp.opengl.GL4;

class ShaderProgram {
  GL4 gl;

  int  shaderProgram;
  int  vertShader;
  int  fragShader;


  ShaderProgram(GL4 gl, String vertexFileName, String fragmentFileName) {
    this.gl = gl;

    String vertSrc = PApplet.join(loadStrings(vertexFileName), "\n");
    String fragSrc = PApplet.join(loadStrings(fragmentFileName), "\n");

    vertShader = createAndCompileShader(gl.GL_VERTEX_SHADER, vertSrc);
    fragShader = createAndCompileShader(gl.GL_FRAGMENT_SHADER, fragSrc);

    shaderProgram = gl.glCreateProgram();

    gl.glAttachShader(shaderProgram, vertShader);
    gl.glAttachShader(shaderProgram, fragShader);

    gl.glLinkProgram(shaderProgram);
  }

  void begin() {
    gl.glUseProgram(shaderProgram);
  }
  void draw(int count) {
    gl.glDrawArrays(gl.GL_POINTS, 0, count);
  }


  int createAndCompileShader(int type, String shaderString) {
    int shader = gl.glCreateShader(type);

    String[] vlines = new String[]{shaderString};
    int[] vlengths = new int[]{vlines[0].length()};

    gl.glShaderSource(shader, vlines.length, vlines, vlengths, 0);
    gl.glCompileShader(shader);

    int[] compiled = new int[1];
    gl.glGetShaderiv(shader, gl.GL_COMPILE_STATUS, compiled, 0);

    if (compiled[0] == 0) {
      int[] logLength = new int[1];
      gl.glGetShaderiv(shader, gl.GL_INFO_LOG_LENGTH, logLength, 0);

      byte[] log = new byte[logLength[0]];
      gl.glGetShaderInfoLog(shader, logLength[0], (int[]) null, 0, log, 0);

      throw new IllegalStateException("Error compiling the shader: " + new String(log));
    }

    return shader;
  }

  void release() {
    //gl.glDetachShader(program, vertShader);
    gl.glDeleteShader(vertShader);
    //gl.glDetachShader(program, fragShader);
    gl.glDeleteShader(fragShader);
  }
}