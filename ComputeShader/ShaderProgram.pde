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

    vertShader = createAndCompileShader(GL4.GL_VERTEX_SHADER, vertSrc);
    fragShader = createAndCompileShader(GL4.GL_FRAGMENT_SHADER, fragSrc);

    shaderProgram = gl.glCreateProgram();

    gl.glAttachShader(shaderProgram, vertShader);
    gl.glAttachShader(shaderProgram, fragShader);

    gl.glLinkProgram(shaderProgram);
  }

  void begin() {
    gl.glUseProgram(shaderProgram);
  }
  void draw(int count) {
    updateUniform2f("hue_range", 0.34, -0.45);
    gl.glDrawArrays(GL4.GL_POINTS, 0, count);
  }


  int createAndCompileShader(int type, String shaderString) {
    int shader = gl.glCreateShader(type);

    String[] vlines = new String[]{shaderString};
    int[] vlengths = new int[]{vlines[0].length()};

    gl.glShaderSource(shader, vlines.length, vlines, vlengths, 0);
    gl.glCompileShader(shader);

    int[] compiled = new int[1];
    gl.glGetShaderiv(shader, GL4.GL_COMPILE_STATUS, compiled, 0);

    if (compiled[0] == 0) {
      int[] logLength = new int[1];
      gl.glGetShaderiv(shader, GL4.GL_INFO_LOG_LENGTH, logLength, 0);

      byte[] log = new byte[logLength[0]];
      gl.glGetShaderInfoLog(shader, logLength[0], (int[]) null, 0, log, 0);

      throw new IllegalStateException("Error compiling the shader: " + new String(log));
    }

    return shader;
  }

  void updateUniform1f(String uniformName, float uniformValue) {
    Integer loc = gl.glGetUniformLocation(shaderProgram, uniformName);
    if (loc != -1)
    {
      gl.glUniform1f(loc, uniformValue);
    }
  }


  void updateUniform2f(String uniformName, float uniformValue1, float uniformValue2) {

    int loc = gl.glGetUniformLocation(shaderProgram, uniformName);
    gl.glUniform2f(loc, uniformValue1, uniformValue2);

    if (loc != -1)
    {
      gl.glUniform2f(loc, uniformValue1, uniformValue2);
    }
  }

  void updateUniform3f(String uniformName, float uniformValue1, float uniformValue2, float uniformValue3) {

    int loc = gl.glGetUniformLocation(shaderProgram, uniformName);
    if (loc != -1)
    {
      gl.glUniform3f(loc, uniformValue1, uniformValue2, uniformValue3);
    }
  }

  void release() {
    //gl.glDetachShader(program, vertShader);
    gl.glDeleteShader(vertShader);
    //gl.glDetachShader(program, fragShader);
    gl.glDeleteShader(fragShader);
  }
}
