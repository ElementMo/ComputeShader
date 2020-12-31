import com.jogamp.opengl.*;
import com.jogamp.common.nio.Buffers;
import java.nio.FloatBuffer;

ParticleSystem ps;
GL4 gl;

void setup() {
  size(1000, 1000, P3D);

  PGL pgl = ((PGraphicsOpenGL)g).pgl;
  gl = ((PJOGL)pgl).gl.getGL4();

  ps = new ParticleSystem(500000);
}

void draw() {
  background(0);
  ps.update();
  ps.render();
}

void dispose() {
  ps.release();
}
