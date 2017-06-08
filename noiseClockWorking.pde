// number of spokes on background;
int numSpokes = 12;
// angle between spokes
float ang;
// number of steps (frames) to build future pixel values
int numSteps = 20;
float oneOverNumSteps;
// background speed control
float dt = 0.175;
// background detain control
float bgDetail = 0.009;
// background alpha setting [0,1]
float alpha = 0.5;

float[] bandStart = { 0.2 , 0.23 , 0.26 , 0.4 , 0.43 , 0.46 , 0.6 , 0.63 , 0.66 , 0.8 , 0.83 , 0.86 };
color[] bandColors;
boolean colorBands = false;
float bandWidth = 0.01;
int numBands;

/////////////////////////////////////////////////////////
// CLOCK SETTINGS (all in pixels) /////////////
/////////////////////////////////////////////////////////
// clock radius
float clockRadius = 120;
// corner radius
float cornerRadius = 4;
// clock stroke weight
float clockStrokeWeight = 3;
// hand lengths/widths
float hourWidth = 9;
float hourLength = 80;
float minuteWidth = 8;
float minuteLength = 110;
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
// previous band value
int[] prevBand;

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
  frameRate( 25 );
  size( 800 , 480 );
  halfWidth = width / 2;
  halfHeight = height / 2;
  noStroke();
  background(0);
  
  
  
  // utility variables
  ang = 2*PI/float(numSpokes);
  numBands = bandStart.length;
  oneOverNumSteps = 1/float(numSteps);
  
  // set band colors
  bandColors = new color[numBands];
  for( int i = 0 ; i < numBands ; i++ ) {
    float h = 120+360*( float(i) / float(numBands) );
    bandColors[i] = hsbColor( h , 0.75 , 1 );
  }
  
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
  prevBand = new int[numPixels];
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
    prevBand[i] = numBands;
    val0[i] = noise( bgDetail*posX[i] , bgDetail*posY[i] , t );
    val1[i] = noise( bgDetail*posX[i] , bgDetail*posY[i] , t + dt );
  }
  println(bandStart.length );
}

void draw() {
  
  // load pixels for rendering
  loadPixels();
  
  if( colorBands ) {
    for ( int i = 0; i < numPixels; i++ ) {
      int x = pixelX[i];
      int y = pixelY[i];
      
      float f = lerp( val0[i] , val1[i] , float(stepCounter)*oneOverNumSteps ) ;
      color c = color(0);
      
      int newBand = numBands;
      for( int b = 0 ; b < numBands ; b++ ) {
        if ( f > bandStart[b] && f < bandStart[b] + bandWidth ) {
          c = bandColors[b];
          newBand = b;
        }
      }
      if( newBand != prevBand[i] ) {
        prevBand[i] = newBand;
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
    }
  } else {
    for ( int i = 0; i < numPixels; i++ ) {
      int x = pixelX[i];
      int y = pixelY[i];
      
      float f = lerp( val0[i] , val1[i] , float(stepCounter)*oneOverNumSteps ) ;
      color c = color(0);
      
      int newBand = numBands;
      for( int b = 0 ; b < numBands ; b++ ) {
        if ( f > bandStart[b] && f < bandStart[b] + bandWidth ) {
          c = color(255,255,255);
          newBand = b;
        }
      }
      if( newBand != prevBand[i] ) {
        prevBand[i] = newBand;
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
  colorBands = !colorBands;
}

void mouseReleased() {
  mousePressFlag = false;
}


color hsbColor( float h, float s, float b ) {
  h %= 360;
  float c = b*s;
  float x = c*( 1 - abs( (h/60) % 2 - 1 ) );
  float m = b - c;
  float rp = 0;
  float gp = 0;
  float bp = 0;
  if ( 0 <= h && h < 60 ) {
    rp = c;  
    gp = x;  
    bp = 0;
  }
  if ( 60 <= h && h < 120 ) {
    rp = x;  
    gp = c;  
    bp = 0;
  }
  if ( 120 <= h && h < 180 ) {
    rp = 0;  
    gp = c;  
    bp = x;
  }
  if ( 180 <= h && h < 240 ) {
    rp = 0;  
    gp = x;  
    bp = c;
  }
  if ( 240 <= h && h < 300 ) {
    rp = x;  
    gp = 0;  
    bp = c;
  }
  if ( 300 <= h && h < 360 ) {
    rp = c;  
    gp = 0;  
    bp = x;
  }
  return color( (rp+m)*255, (gp+m)*255, (bp+m)*255 );
}