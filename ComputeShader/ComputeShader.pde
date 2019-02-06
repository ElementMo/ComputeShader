import com.jogamp.opengl.*;
import com.jogamp.common.nio.Buffers;
import java.nio.FloatBuffer;

ParticleSystem ps;
GL4 gl;
boolean toggle = false;
void setup() {
  size(1000, 1000, P3D);
  //考虑到可能多个粒子系统同时使用
  //所以此处OpenGL的相关初始化工作就不打包到粒子系统里
  PGL pgl = ((PGraphicsOpenGL)g).pgl;
  gl = ((PJOGL)pgl).gl.getGL4();

  //粒子系统初始化需要在OpenGL相关初始化完成之后
  ps = new ParticleSystem(3000000);
}


void draw() {
  background(0);
    ps.update();
    ps.render();
}

void dispose() {
  ps.release();
}
void keyPressed() {
  if (key == 's')
    toggle = true;
}
