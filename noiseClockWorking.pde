// number of spokes on background;
int numSpokes = 12;
// angle between spokes
float ang;
// number of steps (frames) to build future pixel values
int numSteps = 20;
// background speed control
float dt = 0.1;
// background detain control
float bgDetail = 0.012;
// background alpha setting [0,1]
float alpha = 0.5;

float[] bandStart = { 0.2 , 0.25 , 0.4 , 0.45 , 0.6 , 0.65 , 0.8 , 0.85 };
float bandWidth = 0.01;

/////////////////////////////////////////////////////////
// CLOCK SETTINGS (all in pixels) /////////////
/////////////////////////////////////////////////////////
// clock radius
float clockRadius = 120;
// corner radius
float cornerRadius = 4;
// clock stroke weight
float clockStrokeWeight = 2;
// hand lengths/widths
float hourWidth = 8;
float hourLength = 80;
float minuteWidth = 8;
float minuteLength = 112;
// length of back end of hands
float backEnd = 20;
// time of next second
int nextSecond = 1000;

/////////////////////////////////////////////////////////
// BACKGROUND GLOBAL VARIABLES //////////////////////////
/////////////////////////////////////////////////////////
// number of pixels rendered
int numPixels = 0;
// position values for rendered pixels
float posX[];
float posY[];
// pixel positions
int pixelX[];
int pixelY[];
// pixel values (previous)
float val0[];
// pixel values (next)
float val1[];
// pixel values (future)
float val2[];
// counter for number of frames toward future pixel values
int stepCounter = 0;
// number of pixels to build per step (frame)
int pixPerStep;
// time record-keeping
float t = 0;
// buffer of pixel colors
color[] buf;

/////////////////////////////////////////////////////////
// GLOBAL UTILITY VARIABLES /////////////////////////////
/////////////////////////////////////////////////////////
int halfWidth;
int halfHeight;

/////////////////////////////////////////////////////////
// CONTROL VARIABLES ////////////////////////////////////
/////////////////////////////////////////////////////////
boolean mousePressFlag = false;
int mousePressTime = 0;
int mousePressTimeOut = 4000;

void setup() {
  size( 800 , 480 );
  halfWidth = width / 2;
  halfHeight = height / 2;
  noStroke();
  background(0);
  
  // set angle between spokes
  ang = 2*PI/float(numSpokes);
  
  // build IntLists of pixel values from 0-45 degrees and not in clock radius
  // also, determine how many pixels are to be rendered
  IntList tx = new IntList();
  IntList ty = new IntList();
  for( int x = 0 ; x < halfWidth ; x++ ) {
    for( int y = 0 ; y <= x && y < halfHeight ; y++ ) {
      if( sqrt( float(x)*float(x) + float(y)*float(y) ) >= clockRadius ) {
        tx.append(x);
        ty.append(y);
        numPixels++;
      }
    }
  }
  
  // set up pixel data for pixels to be rendered
  pixPerStep = numPixels / numSteps;
  println( "number of rendered pixels: " + numPixels );
  posX = new float[numPixels];
  posY = new float[numPixels];
  pixelX = new int[numPixels];
  pixelY = new int[numPixels];
  val0 = new float[numPixels];
  val1 = new float[numPixels];
  val2 = new float[numPixels];
  buf = new color[numPixels];
  for( int i = 0 ; i < numPixels ; i++ ) {
    int x = tx.get(i);
    int y = ty.get(i);
    pixelX[i] = x;
    pixelY[i] = y;
    float x2 = float(x) + 0.5;
    float y2 = float(y) + 0.5;
    PVector v = new PVector( x2, y2 );
    float a = (v.heading() + PI)%ang;
    if ( a > 0.5*ang ) { 
      a = ang - a;
    }
    float r = v.mag();
    posX[i] = r*cos(a);
    posY[i] = r*sin(a);
    buf[i] = color(0, 0, 0);
    val0[i] = noise( bgDetail*posX[i] , bgDetail*posY[i] , t );
    val1[i] = noise( bgDetail*posX[i] , bgDetail*posY[i] , t + dt );
  }
  println(bandStart.length );
}

void draw() {
  
  // load pixels for rendering
  loadPixels();
  
  for ( int i = 0; i < numPixels; i++ ) {
      int x = pixelX[i];
      int y = pixelY[i];
      
      float f = lerp( val0[i] , val1[i] , float(stepCounter)/float(numSteps) ) ;
      color c = color(0);
      
      for( int b = 0 ; b < bandStart.length ; b++ ) {
        if ( f > bandStart[b] && f < bandStart[b] + bandWidth ) {
          c = lerpColor( buf[i], color(255, 255, 255), alpha );
        }
      }
      pixels[ (halfWidth+x) + (halfHeight+y)*width ] = c;
      pixels[ (halfWidth+x) + (halfHeight-y)*width ] = c;
      pixels[ (halfWidth-x) + (halfHeight+y)*width ] = c;
      pixels[ (halfWidth-x) + (halfHeight-y)*width ] = c;
      if ( x < halfHeight ) {
        pixels[ (halfWidth+y) + (halfHeight+x)*width ] = c;
        pixels[ (halfWidth+y) + (halfHeight-x)*width ] = c;
        pixels[ (halfWidth-y) + (halfHeight+x)*width ] = c;
        pixels[ (halfWidth-y) + (halfHeight-x)*width ] = c;
      }
  }
  updatePixels();
  
  for( int i = stepCounter*pixPerStep ; i <  (stepCounter+1)*pixPerStep && i < numPixels ; i++ ) {
    val2[i] = noise( bgDetail*posX[i] , bgDetail*posY[i] , t + dt );
  }
  
  stepCounter++;
  if( stepCounter > numSteps ) { 
    stepCounter = 0; 
    t += dt;
    for( int i = 0 ; i < numPixels ; i++ ) {
      val0[i] = val1[i];
      val1[i] = val2[i];
    }
  }
  
  // clock stuff
  if( millis() > nextSecond ) {
    nextSecond += 1000;
    fill(0,0,0);
    ellipse( 0.5*width , 0.5*height , 2*clockRadius , 2*clockRadius );
    float minAng = TWO_PI * (float(minute())+float(second())/60)/60;
    float hourAng = TWO_PI * (float(hour()%12)+float(minute())/60)/12;
    translate( 0.5*width, 0.5*height );
    stroke( 255, 255, 255, 255 );
    fill(0,0,0,128);
    strokeWeight(clockStrokeWeight);
    pushMatrix();
    rotate( PI+minAng );
    rect( -0.5*minuteWidth, -backEnd, minuteWidth, minuteLength + backEnd, cornerRadius, cornerRadius, cornerRadius, cornerRadius );
    popMatrix();
    pushMatrix();
    rotate( PI+hourAng );
    rect( -0.5*hourWidth, -backEnd, hourWidth, hourLength + backEnd , cornerRadius, cornerRadius, cornerRadius, cornerRadius );
    popMatrix();
    noStroke();
  }
  
  // display framerate periodically
  if ( frameCount%25 == 0 ) {
    println(frameRate);
  }
  
  // check and see if it's time to exit (mouse held down)
  if( mousePressFlag && mousePressTime + mousePressTimeOut < millis() ) { exit(); }
}

void mousePressed() {
  mousePressTime = millis();
  mousePressFlag = true;
}

void mouseReleased() {
  mousePressFlag = false;
}