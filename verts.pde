void initVerts() {
  int x = 0;
  for (int i=0; i<vertices.length/2; i++) {
    vertices[x] = (float)Math.random()-0.5f;
    vertices[x+1] = (float)Math.random()-0.5f;
    x += 2;
  }
  fbVertices = Buffers.newDirectFloatBuffer(vertices);
}
