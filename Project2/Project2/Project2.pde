import controlP5.*;
import processing.sound.*;

//variables to reference audio files
SoundFile song1;
SoundFile song2;
SoundFile song3;

//variables to reference images
PImage img1;
PImage img2;
PImage img3;
PImage circleImg1;
PImage circleImg2;
PImage circleImg3;
//instance of controlp5 object
ControlP5 sliderbar;
Slider volume;//individual sliders
Slider frequency;
Slider timbre;

// Control album cover visibility
boolean img1Visible = true;
boolean img2Visible = true;
boolean img3Visible = true;

int currentSongIndex = -1; //keeps track of index of currently playing song; -1 because no song is currently selected
boolean isPlaying = false; //determines if a song is currently playing

LowPass lowPass;

void setup () {
  size(800, 600);
  
  song1 = new SoundFile(this, "Music/dreams.mp3");//Royalty Free Music: Bensound.com/royalty-free-music License code: 4Q3I8NLCVH3LRU6D
  song2 = new SoundFile(this, "Music/piano.mp3");//Music by: Bensound.com/free-music-for-videos License code: UHMTZ1RGLAAFOPWY
  song3 = new SoundFile(this, "Music/downtown.mp3"); //Music: Bensound.com/royalty-free-musi License code: PJAYKXUFFYFIZVEG
  
  img1 = loadImage("AlbumCovers/dreams.png");
  img2 = loadImage("AlbumCovers/piano.png");
  img3 = loadImage("AlbumCovers/downtown.png");
  
  circleImg1 = loadImage("CircleCovers/dreams.png");
  circleImg2 = loadImage("CircleCovers/piano.png");
  circleImg3 = loadImage("CircleCovers/downtown.png");
  
  lowPass = new LowPass(this); //Initialize lowpass filter
  
  sliderBars();
}

void draw() {
  background(#523A28);
  
  // Middle record player
  rectMode(CENTER);
  fill(#A47551); 
  rect(width / 2, height / 2, 400, 400);
  
  pushMatrix(); 
  translate(width/2, height/2);
  
  if (isPlaying == true) {
    //Map the frequency slider value to the record rotation speed range
    float rotationSpeed = map(frequency.getValue(), 0, 100, 0.5, 3);
    float rad = radians(frameCount * rotationSpeed);//value increases over time and determines angle of rotation 
    rotate(rad);
  }
  
  drawRecordCircle(0, 0, 180, 10);
  stroke(0);
  line(0, 0, 180, 10);
  
  popMatrix(); 
  
  //Sliderbar text
  fill(#EDE7DC);
  text("Volume", 20, 195);
  text("Frequency", 20, 295);
  text("Timbre", 20, 395);
  
  // Records on right side
  fill(#A47551);
  rect(700, 150, 100, 100);
  rect(700, 300, 100, 100);
  rect(700, 450, 100, 100);  
  drawRecordCircle(700, 150, 50, 3);
  drawRecordCircle(700, 450, 50, 3);
  drawRecordCircle(700, 300, 50, 3);
  
  //Album cover images on the right side
  if(img1Visible){ //checks if img1Visible boolean is true
    image(img1, 640, 95, 115, 115); //if yes display image
  }
  if(img2Visible){
    image(img2, 640, 245, 115, 115);
  }
  if(img3Visible){
    image(img3, 640, 395, 115, 115);
  } 
  
  stylus(); // stylus (pin) function
  
  if(isPlaying){
    // Map the timbre slider value to scratch amount
  float numScratches = map(timbre.getValue(), 0, 100, 0, 50);
  
  for (int i = 0; i < numScratches; i++) {
    float angle = random(TWO_PI); //random position around ellipse center
    float distance = random(180); // Random distance from ellipse center
    
    float x = width / 2 + cos(angle) * distance;//calculate x coordinates
    float y = height / 2 + sin(angle) * distance;//calculate y coordinates 

    drawCircle(x, y);   
  }
 }
}

void drawCircle(float x, float y) {
  fill(128,128,128);
  float radius = random(2, 7); // Random radius between 2 and 7
  ellipse(x, y, radius, radius); // Draw a small circle
}

void drawRecordCircle(float x, float y, float radius, float lineSpacing) {
  strokeWeight(2);
  stroke(128);

  pushMatrix();
  translate(x, y); // Move the coordinate system to the specified (x, y) position

  // Draw black and white circles at the center
  fill(0);
  ellipse(0, 0, radius * 2, radius * 2);
  
  // Display circle shaped album cover on the middle record
  if (currentSongIndex == 0) {
    image(circleImg1,-(radius - 12 * lineSpacing), -(radius - 12 * lineSpacing), (radius - 12 * lineSpacing) * 2, (radius - 12 * lineSpacing) * 2);
  } else if (currentSongIndex == 1) {
    image(circleImg2,-(radius - 12 * lineSpacing), -(radius - 12 * lineSpacing), (radius - 12 * lineSpacing) * 2, (radius - 12 * lineSpacing) * 2);
  } else if (currentSongIndex == 2) {
    image(circleImg3, -(radius - 12 * lineSpacing), -(radius - 12 * lineSpacing), (radius - 12 * lineSpacing) * 2, (radius - 12 * lineSpacing) * 2);
  } else {
    fill(255);
    ellipse(0, 0, (radius - 12 * lineSpacing) * 2, (radius - 12 * lineSpacing) * 2);
  }
  
  fill(0);
  float smallCircleRadius = (radius - 12 * lineSpacing) / 2.5; // Radius of the small black circle
  ellipse(0, 0, smallCircleRadius, smallCircleRadius);
 
  // Loop to draw gray circle lines
  for (int i = 0; i < 24; i++) {
    float lineRadius = radius - i * lineSpacing;//as i increases line spacing decreases
    
      noFill();
      ellipse(0, 0, lineRadius * 2, lineRadius * 2);
    
  }
  
  popMatrix();
  
}

void keyPressed() {
  // Spacebar key to pause/play current song
  if (key == ' ') {
    
    // Check if song is playing
    if (currentSongIndex >= 0 && currentSongIndex <= 2) {
      SoundFile currentSong; //variable to reference to audio files
     
      // Assigns individual song to currentsong based on the currentSongIndex
      if (currentSongIndex == 0) {
        currentSong = song1;
      } else if (currentSongIndex == 1) {
        currentSong = song2;
      } else {
        currentSong = song3;
      }
            
      if (isPlaying) { // if isplaying = false 
        currentSong.pause(); //pause currently playing song
      } else { //if is playing = true
        currentSong.play(); //play current song
      }
      
      // when spacebar pressed change isplaying boolean value
      isPlaying = !isPlaying;
    }
  }
 
  else if (key >= '1' && key <= '3') {//checks if key 1-3 is pressed
    int index = key - '1'; //substracts 1 from key value stores in index -> key values become same as index values
    
    // Checks if index is within valid range
    if (index >= 0 && index <= 2) {

      currentSongIndex = index; // currentsongindex updated to match index
      isPlaying = true; //play song
     
      stopAllSongs(); //only 1 song playing at a time (currentsong)
      playCurrentSong();
    }
  }
}

void stopAllSongs() {
  // Stop all three songs
  song1.stop();
  song2.stop();
  song3.stop();
}

void playCurrentSong() {
  // Play the current song and shows album covers based on the currentSongIndex
  if (currentSongIndex == 0) {
    song1.play();
    lowPass.process(song1);
    
    img1Visible = false;
    img2Visible = true;
    img3Visible = true;
    
  } else if (currentSongIndex == 1) {
    song2.play();
    lowPass.process(song2);
    
    img2Visible = false;
    img1Visible = true;
    img3Visible = true;
    
  } else {
    song3.play();
    lowPass.process(song3);
    
    img3Visible = false;
    img1Visible = true;
    img2Visible = true;
    
  }
  //values in the beginning of running sketch
  volume.setValue(100);
  frequency.setValue(50);
  timbre.setValue(0);
}

void stylus() { //record pin function
  fill(0);
  stroke(255);
  strokeWeight(3);
  
  pushMatrix(); 
  
  float centerX = 570; 
  float centerY = 135;
  translate(centerX, centerY); // Translate to the center of rotation
  
  if (isPlaying == true) { //rotate stylus if song is playing
    float rad = radians(25);
    rotate(rad);
  }
  
  // Draw shapes relative to rotation center
  line(590 - centerX, 145 - centerY, 590 - centerX, 370 - centerY);
  ellipse(0, 0, 45, 45);
  rect(590 - centerX, 370 - centerY, 15, 25);
  
  popMatrix(); 
  
  noStroke();
}

void sliderBars() {
  
  sliderbar = new ControlP5(this);
  
  volume = sliderbar.addSlider("Volume")//Volume
                    .setPosition(width - 780, 200)
                    .setRange(0, 100)//slider value
                    .setWidth(150)
                    .setHeight(20)
                    .setLabelVisible(false);
                    
  frequency = sliderbar.addSlider("Frequency")// Frequency
                       .setPosition(width - 780, 300)
                       .setRange(0, 100)
                       .setWidth(150)
                       .setHeight(20)
                       .setLabelVisible(false);
                       
  timbre = sliderbar.addSlider("Timbre")//Timbre
                   .setPosition(width - 780, 400)
                   .setRange(0, 100)
                   .setWidth(150)
                   .setHeight(20)
                   .setLabelVisible(false);
                   
  Slider[] sliders = {volume, frequency, timbre};//array of slider objects

  for (Slider slider : sliders) { //"for each" loop, iterates over each Slider object in sliders array
    slider.setColorForeground(color(#A47551));
    slider.setColorBackground(color(#EDE7DC));             
  }
}

//slider callback functions - triggered when slider values change
void Volume(float theValue) { // theValue is the current value of the slider

    float volumeValue = map(theValue, 0, 100, 0, 1); 
 
  if (currentSongIndex == 0) {
    song1.amp(volumeValue); // Adjust the volume of song1
  } else if (currentSongIndex == 1) {
    song2.amp(volumeValue); // Adjust the volume of song2
  } else if (currentSongIndex == 2) {
    song3.amp(volumeValue); // Adjust the volume of song3
  }
  
 // println(theValue);//prints slider value to console 
}

void Frequency(float theValue){
  
  // Map the slider value to a desired range of frequencies
  float frequencyValue = map(theValue, 0, 100, 0.5, 2);
  
  if (currentSongIndex == 0) {
    song1.rate(frequencyValue); // Adjust the frequency of song1
  } else if (currentSongIndex == 1) {
    song2.rate(frequencyValue); // Adjust the frequency of song2
  } else if (currentSongIndex == 2) {
    song3.rate(frequencyValue); // Adjust the frequency of song3
  }
  
  //print(theValue);
}

void Timbre(float theValue) {
  float timbreValue = map(theValue, 100, 0, 500, 2500); // Adjust the cutoff range if desired
  lowPass.freq(timbreValue);//cutoff frequency of lowpass filter based on timbre slider value
 // println(theValue);
}
