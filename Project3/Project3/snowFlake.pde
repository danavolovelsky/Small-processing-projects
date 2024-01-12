class SnowFlake {
  PVector position;
  PVector velocity;
  PVector gravity;
  PVector wind;
  
  float size;
  PImage img;
  
  float windIntensity = 0.03; // Initial wind intensity
  float windDirection = 0; // Initial wind direction
  float windChangeRate = 0.003; // Rate of change for wind direction
  float windMaxIntensity = 0.07; // Maximum wind intensity
  float windMinIntensity = 0.01; // Minimum wind intensity
  int windChangeInterval = 5000; // Interval for wind direction change (in milliseconds)
  int lastWindChangeTime = 0; // Time of the last wind direction change
 
  boolean collided = false;
 
  SnowFlake(float x, float z, float size, PImage img) {
this.position = new PVector(
  x - 100 - width/2, 
  (0 - height/2 + 50) , 
  (z + 460) 
  //(0 - height * 0.7) * cos(-PI/3) + z * sin(-PI/3),
  //(0 - height * 0.7) * -sin(-PI/3) + z * cos(-PI/3)
);
this.velocity = new PVector(0, 1, 0); // Adjust the z-axis velocity to control falling
    this.gravity = new PVector(0, 0.05, 0);
    this.wind = new PVector(0.03, 0, 0);
    this.size = size;
    this.img = img;
  }
  
void update() {
  velocity.add(gravity);
  
  // Check if it's time to change the wind direction
  int currentTime = millis();
  if (currentTime - lastWindChangeTime >= windChangeInterval) {
    // Generate a random direction change
    float directionChange = random(-1, 1); // Adjust the range as needed
    windDirection += directionChange;
    lastWindChangeTime = currentTime; // Update the time of the last wind direction change
  }

  // Adjust wind intensity gradually
  float intensityChange = random(-0.003, 0.003); // Adjust the range as needed
  
  if(winterMode){
  intensityChange +=0.04;
    windDirection += random(-0.1, 0.1); // Adjust the range as needed
}
  
  windIntensity += intensityChange;
  windIntensity = constrain(windIntensity, windMinIntensity, windMaxIntensity);

  // Calculate wind velocity based on intensity and direction
  float windX = cos(windDirection) * windIntensity;
  float windY = 0;
  float windZ = sin(windDirection) * windIntensity;// Adjust if you want wind in the z-axis

  wind.set(windX, windY, windZ);

  velocity.add(wind);
  position.add(velocity);
}

void display() {
  imageMode(CENTER);
  pushMatrix();  
  //rotateX(-PI/3);
    translate(width / 2, height / 2 - 50, -460); // Position the mountain in the middle of the screen
     translate(position.x, position.y, position.z);

    rotateZ(frameCount * 0.003);
    image(img, 0, 0, size, size);
  popMatrix();
}

}
