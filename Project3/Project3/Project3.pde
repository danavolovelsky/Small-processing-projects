import peasy.*; //<>//
import processing.sound.*;

PeasyCam cam;

SoundFile birds;
SoundFile thunder;

PImage snowflakeIMG;

float noiseScale = 0.017; // Scale for Perlin noise
float heightScale = 120; // Scale for mountain height

ArrayList<PVector> vertices = new ArrayList<PVector>(); 
ArrayList<PineTree> pineTrees = new ArrayList<PineTree>();
ArrayList<SnowFlake> snowflakes = new ArrayList<SnowFlake>();
ArrayList<SnowFlake> collidedSnowflakes = new ArrayList<SnowFlake>();
ArrayList<PVector> snowSpheres = new ArrayList<PVector>();

int nextSnowflakeTime = 0;

boolean collisionDetected = false;

boolean summerMode = false;
boolean winterMode = false;

void setup() {
  size(800, 600, P3D);// 3D mode
  //cam = new PeasyCam(this, 200);
  
  birds = new SoundFile(this, "birds.wav");// Sound effect from Pixabay
  thunder = new SoundFile(this, "thunder.wav");
  snowflakeIMG = loadImage("snowFlake.png");
  
  mountain();
  drawTrees();
}

void draw() {
  background(112, 128, 144); // Blue color for the sea
  
  summer(); 
  winter();
  mountain();
  for (PineTree pineTree : pineTrees) {
    pineTree.display();
  }
  performCollisionDetection();
  
  //update and display snowflakes
  for (SnowFlake snowflake : snowflakes) {//type (Class object) individual : arraylist
    if (!snowflake.collided) { //if individual snowflake not collided
      snowflake.update();
      snowflake.display();
    }
  }

  // Display collided snowflakes as spheres
  for (SnowFlake snowflake : collidedSnowflakes) { // for each snowflake in collidedsnowflakes
    snow(new PVector(snowflake.position.x, snowflake.position.y, snowflake.position.z), snowflake.size); //draw sphere
  }

  if (!summerMode && !winterMode) {
    stopBirdsSound(); // Stop birds sound if not in summer mode
    stopThunderSound(); // Stop thunder sound if not in winter mode
    
  // Generate new snowflakes
    if (millis() > nextSnowflakeTime) { //currenttime > snowflaketime
      generateSnowflakes(2);
      calculateNextSnowflakeTime();
    }
  }
  //println("vertices size: " + vertices.size());
  //println("snowflakes size: " + snowflakes.size());
  //println(collidedSnowflakes);
  //println("snowSpheres size: " + snowSpheres.size());
}

void mountain() {
  pushMatrix();
  rotateX(PI/3); // view from an angle
  translate(width / 2, height / 2 - 50, -460);
  
  vertices.clear();//otherwise list will grow infinitely
  
  float yOff = 0; // Y offset for Perlin noise

  // Loop through each row of the terrain (vertical)
  for (int y = -height/2; y < height/2; y += 8) { //8 us spacing between each row
    beginShape(TRIANGLE_STRIP);

    float xOff = 0; // X offset Perlin noise

    // Loop through each column of the mountain(horizontal)
    for (int x = -width; x <= width; x += 8) { //8 us spacing between each column
      float distanceFromCenter = abs(x); // distance mountain center

      float offset = map(distanceFromCenter, 0, width/2, 0, heightScale * 2); // smooth offset used for perlin noise from center to edges
      
      // calculates z coordinate of vertex
      float z = map(noise(xOff, yOff), 0, 1, -heightScale, heightScale) + offset;//create 2 mountain heights on sides
      
      if (winterMode) {
        fill(255); // White
      } else if (summerMode) {
         fill(#19a119); //Light blue
      } else {
          fill(139, 69, 19); // Brown 
      } 
      
      // Add vertices to the shape and vertices array
      PVector vertexPosition = new PVector(x, y, z);
      vertices.add(vertexPosition); // adds coordinates to vertices array
      vertex(x, y, z); // adds vertex to shape (same as vertex position)
      vertex(x, y + 10, z); // creates small vertical offset (depth)

      xOff += noiseScale; // each vertex different perlin noise 
    }

    endShape();

    yOff += noiseScale; // vertical position of perlin noise
  }
  popMatrix();
}

void drawTrees() {
  int numTrees = 300;

  // Place pine trees on random positions of the mountain
  for (int i = 0; i < numTrees; i++) {
    PVector vertex = vertices.get((int) random(vertices.size())); // Random vertex from vertices array

    float treeX = vertex.x; // Extract vertex coordinates
    float treeY = vertex.y;
    float treeZ = vertex.z;

    PineTree pineTree = new PineTree(treeX, treeY, treeZ); //new pinetree object

    pineTree.display();
    pineTrees.add(pineTree);
  }
}

void generateSnowflakes(int numSnowflakes) {

  for (int i = 0; i < numSnowflakes; i++) {//number of snowflakes at a time
    float randomX = random(width);
    float randomZ = random(-heightScale, heightScale);
    float size = random(20, 40);
    SnowFlake snowflake = new SnowFlake(randomX, randomZ, size, snowflakeIMG); //new snowflake object
    snowflakes.add(snowflake); //add to snowflake array
  }
}

void calculateNextSnowflakeTime() {
  int interval;
  if (!winterMode) {
    interval = int(random(200, 500)); // Random interval between 0.2 to 0.5 seconds
  } else {
    interval = int(random(100, 300)); // Random interval between 0.1 to 0.3 seconds (faster in winter)
  }
  nextSnowflakeTime = millis() + interval; //sets next time generatesnowflake will bhe called
}


float getMountainHeight(float x, float z) {
  //pushMatrix(); 
   //rotateX(PI/3); // view from an angle
  float closestDistance = Float.MAX_VALUE; // Large value
  PVector closestVertex = null; // Store the closest vertex
  
  for (PVector vertex : vertices) { 

    float distance = dist(vertex.x, vertex.z, x, z); // distance between current vertex and given coordinates (snowflake)
    
    if (distance < closestDistance) {//if distance closer than previous distance
      closestDistance = distance; //update closest distance
      closestVertex = vertex;//update closest vertex
    } 
  }
  //popMatrix();
  if (closestVertex != null) {
    return closestVertex.z; //returns height
  } else {
      return 0; //default value
    }
}

void performCollisionDetection() {
  if(!winterMode){
    for (SnowFlake snowflake : snowflakes) {
      if (!snowflake.collided) {//if snowflake not collided
        boolean collisionDetected = false;
        
       // Check for collision with mountain surface
        float mountainHeight = getMountainHeight(snowflake.position.x, snowflake.position.z);
        
        if (snowflake.position.y >= mountainHeight) {
          collisionDetected = true;
          snowflake.position.y = mountainHeight; // Set the snowflake's y-coordinate to the mountain height to prevent sinking into the mountain
        }
        
        if (collisionDetected) {
          snowflake.collided = true; //mark snowflake as collided
          collidedSnowflakes.add(snowflake);//add to collidedsnowflakes array
          snow(snowflake.position, snowflake.size);//draw sphere at collision point
         // println("snowflake position:" +snowflake.position.y);
         // println("mountain height2:" +mountainHeight);
        }
      }
    }
  }
}

void snow(PVector position, float radius) {//laying snow sphere
  pushMatrix();
  //rotateX(radians(60)); 
  translate(width / 2, height / 2 +50, -460); 
  translate(position.x, position.y, position.z - radius/2); // Adjust the position by subtracting half of the radius
  //println("snow:" +position.y);
  pushStyle();
  noStroke();
  fill(255);
  sphere(radius);
  popStyle();
  popMatrix();
}

void playBirdsSound() {
  if (!birds.isPlaying()) {
    birds.loop();
  }
}

void stopBirdsSound() {
  if (birds.isPlaying()) {
    birds.stop();
  }
}

void playThunderSound() {
  if (!thunder.isPlaying()) {
    thunder.loop();
  }
}

void stopThunderSound() {
  if (thunder.isPlaying()) {
    thunder.stop();
  }
}

void summer() {
  if (summerMode) {
    background(#86c5da); // Set light blue background

    playBirdsSound(); // Play birds sound during summer
    stopThunderSound(); // Stop thunder sound during summer

    snowflakes.clear(); // Stop snowflakes from falling by clearing the snowflakes array
    collidedSnowflakes.clear(); // Clear the collided snowflakes array

    // Draw a yellow sphere at the top of the mountain
    PVector sun = new PVector(0, -height / 2 + 10, 0); // Position at the top of the mountain
    
    pushMatrix();
    translate(width / 2, height / 2 - 50, -460); // Position the mountain in the middle of the screen
    translate(sun.x, sun.y, sun.z - 35); // substracting half of sun radius
    pushStyle();
    noStroke();
    fill(255, 255, 0); // Yellow color
    sphereDetail(30); // Increase the sphere detail for a smoother appearance
    sphere(70);
    popStyle();
    popMatrix();
  } 
}

void winter() {
  if(winterMode){
    background(#1E3A4C);
    
    playThunderSound(); 
    stopBirdsSound(); 
    
    snowSpheres.clear(); //clear past drawn snow()
    collidedSnowflakes.clear(); // Clear the collided snowflakes array
    
    if (millis() > nextSnowflakeTime) {   
      generateSnowflakes(12); // More snowflakes faster
      calculateNextSnowflakeTime();
    }
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    summerMode = !summerMode; // toggle the value of summerMode
    winterMode = false; // set Winter to false
  } else if (key == 'w' || key == 'W') {
    winterMode = !winterMode; // toggle the value of winterMode
    summerMode = false; // set summer to false
  }
} 
