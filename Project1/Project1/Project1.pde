
//min and max amount of rects to draw
int minNumRectangles = 1;
int maxNumRectangles = 5;

//variable holds actual rect number to be drawn
int numRectangles;

float rectSpacing = 50; // spacing between rects 
float rectWidth = 500; // rect width
float lineWidth = 5; // individual line width (stroke weight)
float lineHeight = 5; // individual line height

float rectHeights[]; // array holds height of individual rects

color randomRed = color(random(150, 255), random(0, 50), random(0, 50));
color randomGreen = color(random(0, 50), random(150, 255), random(0, 50));
color randomBlue = color(random(0, 50), random(100, 200), random(150, 255));

color[] rectColors; //store color for each rect
color backgroundColor; //store background color

void setup() {
  size(600, 600);
  strokeWeight(lineWidth);
  generateRectangles(); //initializes first state of rects
}

void draw() {  
  background(backgroundColor);

  // Loop through the number of rects to draw
  float y = rectSpacing;
  for (int j = 0; j < numRectangles; j++) {
    
    // Set the color of the current rect
    stroke(rectColors[j]);
    
    // Draw the rectangle
    pushMatrix();  
    translate(width/2 - rectWidth/2, y);  // move origin to appropriate position
    linesHorizontal(rectHeights[j]);  // draw the stacked rectangle x axis
    linesVertical(rectHeights[j]);  // draw the stacked rectangle y axis
    popMatrix();  

    // Update y to draw the next rectangle
    y += rectHeights[j] + rectSpacing;
  }
}

void generateRectangles() {
     // Randomly choose the background color
  int colorChoice = int(random(3));
  if (colorChoice == 0) {
    backgroundColor = randomRed;
  } else if (colorChoice == 1) {
    backgroundColor = randomBlue;
  } else {
    backgroundColor = randomGreen;
  }
  
   // Generate a random number of rects to draw
  numRectangles = int(random(minNumRectangles, maxNumRectangles + 1));
  
  // Generate the heights of the rects
  rectHeights = new float[numRectangles];
  
  rectColors = new color[numRectangles];
  
  float maxHeight = height - (numRectangles + 1) * rectSpacing; //make sure doesnt exceed canvas height
  for (int j = 0; j < numRectangles; j++) {
    rectHeights[j] = random(50, maxHeight / (numRectangles - j));
    maxHeight -= rectHeights[j];

   if (backgroundColor == randomRed) {
          rectColors[j] = color(random(150, 255), random(0, 50), random(0, 50));
        } else if (backgroundColor == randomBlue) {
          rectColors[j] = color(random(0, 50), random(100, 200), random(150, 255));
        } else {
         rectColors[j] = color(random(0, 50), random(150, 255), random(0, 50));
       }  
  }
  
}

void linesHorizontal(float rectHeight) {
  
  int numLines = int(rectHeight / lineWidth); // Calculate needed number of lines 

  // Loop iterates through numLines
  for (int i = 0; i < numLines; i++) {
    // Calculate the y position of the current line
    float y = i * lineWidth; //y position of current line, spaced vertically based on lineWidth

    // Variation of start and end position with random factor
    float lineWidthRandom = random(-1, 1);
    float lineStart = lineWidthRandom * lineWidth;
    float lineEnd =  lineWidthRandom * lineWidth;
    
    // Vary line width along x-axis
    float xStart = random(-7, 7);
    float xEnd = rectWidth + random(-7, 7);

    // Draw line as a vector
    PVector start = new PVector(xStart,  y + lineStart); //have the lines be straight horizontal 
    PVector end = new PVector(xEnd, y + lineEnd);
    line(start.x, start.y, end.x, end.y);
  }
}

void linesVertical(float rectHeight) {
  // Calculate the number of lines needed to create the rect
  int numLines = int(rectWidth / lineHeight);

  // Loop through the lines and draw them
  for (int i = 0; i < numLines; i++) {
    // Calculate the x position of the current line
    float x = i * lineHeight;

    // Vary the line width slightly
    float lineWidthRandom = random(-1, 1);
    float lineStart = lineWidthRandom * lineHeight;
    float lineEnd = lineWidthRandom * lineHeight;
    
    // Vary the line width along y-axis
    float yStart = random(-7, 7);
    float yEnd = rectHeight + random(-7, 7);

    // Draw the line as a vector
    PVector start = new PVector(x + lineStart, yStart);
    PVector end = new PVector(x + lineEnd, yEnd);
    
    line(start.x, start.y, end.x, end.y);
  }
}

void mousePressed() {
  generateRectangles();
}
