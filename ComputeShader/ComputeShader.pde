import com.jogamp.opengl.*;
import com.jogamp.common.nio.Buffers;
import java.nio.FloatBuffer;


float[] vertices = new float[1000000];
FloatBuffer fbVertices;

GL4 gl;

private ShaderProgram shaderProgram;
private ComputeProgram computeProgram;

void setup() {
  size(600, 600, P3D);

  initVerts();
  PGL pgl = ((PGraphicsOpenGL)g).pgl;
  gl = ((PJOGL)pgl).gl.getGL4();

  shaderProgram = new ShaderProgram(gl, "vert.glsl", "frag.glsl");
  computeProgram = new ComputeProgram(gl, "comp.glsl");
}
void draw() {
  background(0);
  computeProgram.beginDispatch(1000, 1, 1);
  shaderProgram.begin();
  shaderProgram.draw();
}
