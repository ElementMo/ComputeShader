void initVerts() {
  for (int i=0; i<vertices.length; i+=2) {
    vertices[i] = (float)Math.random()-0.5f;
    vertices[i+1] = (float)Math.random()-0.5f;
  }
  fbVertices = Buffers.newDirectFloatBuffer(vertices);
}
