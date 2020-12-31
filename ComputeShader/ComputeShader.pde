import com.jogamp.opengl.*;
import com.jogamp.common.nio.Buffers;
import java.nio.FloatBuffer;

ParticleSystem ps;
GL4 gl;

void setup() {https://github.com/ElementMo/ComputeShader/pull/2/conflict?name=ComputeShader%252FComputeShader.pde&ancestor_oid=4fa1c20e94ec3bbf4b3354228201b213fbf44b71&base_oid=f739839442e7087b9df00f083fb09f6b94e8ada8&head_oid=863ca86b019177d9a455b08cba213ab593ac7956
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
