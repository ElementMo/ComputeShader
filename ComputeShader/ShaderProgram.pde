import com.jogamp.opengl.GL4;

public class ShaderProgram {
  private GL4 gl;

  private int  shaderProgram;
  private int  vertShader;
  private int  fragShader;


  public ShaderProgram(GL4 gl, String vertexFileName, String fragmentFileName) {
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

  public void begin() {
    gl.glUseProgram(shaderProgram);
  }
  public void draw() {
    gl.glDrawArrays(GL4.GL_POINTS, 0, vertices.length/2);
  }


  private int createAndCompileShader(int type, String shaderString) {
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
}
