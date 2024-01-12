class PineTree {
  float xPos;
  float yPos;
  float zPos;
  int numPyramids;
  float pyramidSize;
  float pyramidHeight;

  PineTree(float x, float y, float z) {
    this.xPos = x;
    this.yPos = y;
    this.zPos = z + 6;
    this.numPyramids = 4;
    this.pyramidSize = 20;
    this.pyramidHeight = 18;
  }
  
  void display() {
    pushMatrix();
    
    rotateX(PI/3); // view from an angle
    translate(width / 2, height / 2 - 50, -460);
    
    translate(xPos, yPos, zPos);
    rotateX(-PI/3); // cancel out mountain rotation

  fill(#5C4033); // brown for tree trunk
  box(6);

    for (int i = 0; i < numPyramids; i++) { //i increas -> scale decrease
      float scaleFactor = (float)(numPyramids - i) / (float)numPyramids;//smaller pyramids at the top
      float currentSize = pyramidSize * scaleFactor;
      float currentHeight = pyramidHeight * scaleFactor;
      float yPosition = i * 10; //y of current pyramid 
      
      pushMatrix();
      translate(0, -yPosition - currentHeight / 2, 0);//position of next pyramid 
      fill(#027148);
      
      //Calculation where vertex points for the pyramids are
      PVector top = new PVector(0, -currentHeight / 2, 0);
      PVector frontLeft = new PVector(-currentSize /2 , currentHeight / 2, currentSize / 2);
      PVector frontRight = new PVector(currentSize / 2, currentHeight / 2, currentSize / 2);
      PVector backLeft = new PVector(-currentSize / 2, currentHeight / 2, -currentSize / 2);
      PVector backRight = new PVector(currentSize / 2, currentHeight / 2, -currentSize / 2);
      
      beginShape(TRIANGLES);
      vertex(top.x, top.y, top.z);
      vertex(frontLeft.x, frontLeft.y, frontLeft.z);
      vertex(frontRight.x, frontRight.y, frontRight.z);
      
      vertex(top.x, top.y, top.z);
      vertex(frontRight.x, frontRight.y, frontRight.z);
      vertex(backRight.x, backRight.y, backRight.z);
      
      vertex(top.x, top.y, top.z);
      vertex(backRight.x, backRight.y, backRight.z);
      vertex(backLeft.x, backLeft.y, backLeft.z);
      
      vertex(top.x, top.y, top.z);
      vertex(backLeft.x, backLeft.y, backLeft.z);
      vertex(frontLeft.x, frontLeft.y, frontLeft.z);
      
      vertex(frontLeft.x, frontLeft.y, frontLeft.z);
      vertex(frontRight.x, frontRight.y, frontRight.z);
      vertex(backRight.x, backRight.y, backRight.z);
      
      vertex(frontLeft.x, frontLeft.y, frontLeft.z);
      vertex(backRight.x, backRight.y, backRight.z);
      vertex(backLeft.x, backLeft.y, backLeft.z);
      
      endShape();
      
      popMatrix();
    }
    
    popMatrix();
  }
}
