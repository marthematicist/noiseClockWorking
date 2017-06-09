ClockSettings applySetup() {
    
  /////////////////////////////////////////////////////////////
  // SETTINGS EXPLAINED ///////////////////////////////////////
  /////////////////////////////////////////////////////////////
  // n: set at the beginning of each setting block
  // bgDetail: controls how detailed noise pattern is
  // bgSpeed: controls how fast noise pattern morphs
  // bgColor: background color
  // handsStroke: color of the clock hand outline
  // handsFill: color of the clock hand infill
  // addBand: adds a color band to the noise pattern interpreter
  //    addBand( n , bandStart , bandWidth , bandColor )
  //        - n: leave it be. Change the n-value at the beginning of each setting block
  //        - bandStart: a value from 0-1 that sets the position of the band
  //        - bandWidth: how wide the band is 
  //        - bandColor: the color of the band
  //        { bands may overlap, but unpredictable behavior may result }
  //        { for bandColor use either:
  //            color( red[0,255] , green[0,255] , blue[0,255] )     
  //               or
  //            hsbColor( hue[0,360] , saturation[0,1] , brightness[0,1] )
  //        }
  // Click or touch screen while running to cycle through settings.
  // next setting: right half of screen
  // prev setting: left half of screen
  /////////////////////////////////////////////////////////////
  
  
  // MAKE SURE THIS MATCHES THE NUMBER OF SETTINGS
  int numberOfSettings = 4;
  
  // Don't mess with these
  ClockSettings CS = new ClockSettings( numberOfSettings );
  int n;
  

  /////////////////////////////////////////////////////////////
  // Setting 0 ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  n = 0;
  CS.Settings[n].bgDetail = 0.01;
  CS.Settings[n].bgSpeed = 0.175;
  CS.Settings[n].bgColor = color( 0, 0, 0, 255 );
  CS.Settings[n].handsStroke = color( 255, 255, 255, 255 );
  CS.Settings[n].handsFill = color( 0, 0, 0, 128 );
  CS.addBand( n, 0.20, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.23, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.26, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.40, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.43, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.46, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.60, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.63, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.66, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.80, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.83, 0.01, color( 255, 255, 255 ) );
  CS.addBand( n, 0.86, 0.01, color( 255, 255, 255 ) );


  /////////////////////////////////////////////////////////////
  // Setting 1 ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  n = 1;
  CS.Settings[n].bgDetail = 0.005;
  CS.Settings[n].bgSpeed = 0.075;
  CS.Settings[n].bgColor = color( 255, 255, 255, 255 );
  CS.Settings[n].handsStroke = color( 0, 0, 0, 255 );
  CS.Settings[n].handsFill = color( 255, 255, 255, 128 );
  CS.addBand( n, 0.20, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.23, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.26, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.40, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.43, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.46, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.60, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.63, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.66, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.80, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.83, 0.02, color( 0, 0, 0 ) );
  CS.addBand( n, 0.86, 0.02, color( 0, 0, 0 ) );
  
  /////////////////////////////////////////////////////////////
  // Setting 2 ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  n = 2;
  CS.Settings[n].bgDetail = 0.01;
  CS.Settings[n].bgSpeed = 0.075;
  CS.Settings[n].bgColor = color( 0, 0, 0, 255 );
  CS.Settings[n].handsStroke = color( 255, 255, 255, 255 );
  CS.Settings[n].handsFill = color( 0, 0, 0, 128 );
  CS.addBand( n, 0.05, 0.01, hsbColor( 0, 1, 1 ) );
  CS.addBand( n, 0.1, 0.01, hsbColor( 30, 1, 1 ) );
  CS.addBand( n, 0.15, 0.01, hsbColor( 60, 1, 1 ) );
  CS.addBand( n, 0.2, 0.01, hsbColor( 90, 1, 1 ) );
  CS.addBand( n, 0.25, 0.01, hsbColor( 120, 1, 1 ) );
  CS.addBand( n, 0.3, 0.01, hsbColor( 150, 1, 1 ) );
  CS.addBand( n, 0.35, 0.01, hsbColor( 180, 1, 1 ) );
  CS.addBand( n, 0.4, 0.01, hsbColor( 210, 1, 1 ) );
  CS.addBand( n, 0.45, 0.01, hsbColor( 240, 1, 1 ) );
  CS.addBand( n, 0.5, 0.01, hsbColor( 270, 1, 1 ) );
  CS.addBand( n, 0.55, 0.01, hsbColor( 300, 1, 1 ) );
  CS.addBand( n, 0.6, 0.01, hsbColor( 330, 1, 1 ) );
  CS.addBand( n, 0.65, 0.01, hsbColor( 30, 1, 1 ) );
  CS.addBand( n, 0.7, 0.01, hsbColor( 60, 1, 1 ) );
  CS.addBand( n, 0.75, 0.01, hsbColor( 90, 1, 1 ) );
  CS.addBand( n, 0.8, 0.01, hsbColor( 120, 1, 1 ) );
  CS.addBand( n, 0.85, 0.01, hsbColor( 150, 1, 1 ) );
  CS.addBand( n, 0.9, 0.01, hsbColor( 180, 1, 1 ) );
  CS.addBand( n, 0.95, 0.01, hsbColor( 210, 1, 1 ) );
  
  /////////////////////////////////////////////////////////////
  // Setting 3 ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  n = 3;
  CS.Settings[n].bgDetail = 0.015;
  CS.Settings[n].bgSpeed = 0.075;
  CS.Settings[n].bgColor = color( 0, 0, 0, 255 );
  CS.Settings[n].handsStroke = color( 255, 255, 255, 255 );
  CS.Settings[n].handsFill = color( 0, 0, 0, 128 );
  CS.addBand( n, 0.05, 0.03, hsbColor( 0, 1, 1 ) );
  CS.addBand( n, 0.10, 0.03, hsbColor( 30, 1, 1 ) );
  CS.addBand( n, 0.15, 0.03, hsbColor( 60, 1, 1 ) );
  CS.addBand( n, 0.20, 0.03, hsbColor( 90, 1, 1 ) );
  CS.addBand( n, 0.25, 0.03, hsbColor( 120, 1, 1 ) );
  CS.addBand( n, 0.30, 0.03, hsbColor( 150, 1, 1 ) );
  CS.addBand( n, 0.35, 0.03, hsbColor( 180, 1, 1 ) );
  CS.addBand( n, 0.40, 0.03, hsbColor( 210, 1, 1 ) );
  CS.addBand( n, 0.45, 0.03, hsbColor( 240, 1, 1 ) );
  CS.addBand( n, 0.50, 0.03, hsbColor( 270, 1, 1 ) );
  CS.addBand( n, 0.55, 0.03, hsbColor( 300, 1, 1 ) );
  CS.addBand( n, 0.60, 0.03, hsbColor( 330, 1, 1 ) );
  CS.addBand( n, 0.65, 0.03, hsbColor( 30, 1, 1 ) );
  CS.addBand( n, 0.70, 0.03, hsbColor( 60, 1, 1 ) );
  CS.addBand( n, 0.75, 0.03, hsbColor( 90, 1, 1 ) );
  CS.addBand( n, 0.80, 0.03, hsbColor( 120, 1, 1 ) );
  CS.addBand( n, 0.85, 0.03, hsbColor( 150, 1, 1 ) );
  CS.addBand( n, 0.90, 0.03, hsbColor( 180, 1, 1 ) );
  CS.addBand( n, 0.95, 0.03, hsbColor( 210, 1, 1 ) );
  
  
  // Cleaning up...
  CS.updateSettings();
  return CS;
}



class ClockSettings {
  int numSettings;
  int currentSetting;
  Setting[] Settings;
  int numBands;
  float bgDetail;
  float bgSpeed;
  color bgColor;
  color handsFill;
  color handsStroke;


  ClockSettings( int numSettingsIn ) {
    this.numSettings = numSettingsIn;
    this.currentSetting = 0;
    this.Settings = new Setting[ numSettings ];
    for ( int i = 0; i < numSettings; i++ ) {
      this.Settings[i] = new Setting( 0.009, 0.175, color(0, 0, 0), color(255, 255, 255, 255), color(0, 0, 0, 128) );
    }
  }

  void updateSettings() {
    numBands = Settings[currentSetting].numBands;
    bgDetail = Settings[currentSetting].bgDetail;
    bgSpeed = Settings[currentSetting].bgSpeed;
    bgColor = Settings[currentSetting].bgColor;
    handsFill = Settings[currentSetting].handsFill;
    handsStroke = Settings[currentSetting].handsStroke;
  }

  void setColors( int settingNumber, color bgColorIn, color handsStrokeIn, color handsFillIn ) {
    if ( settingNumber < numSettings ) {
      Settings[settingNumber].bgColor = bgColorIn;
      Settings[settingNumber].handsFill = handsFillIn;
      Settings[settingNumber].handsStroke = handsStrokeIn;
    }
  }

  void addBand( int settingNumber, float bandStartIn, float bandWidthIn, color bandColorIn ) {
    if ( settingNumber < numSettings ) {
      Settings[settingNumber].addBand( bandStartIn, bandWidthIn, bandColorIn );
    }
  }

  int whichBand( float f ) {
    int output = numBands;
    for ( int i = 0; i < numBands; i++ ) {
      if ( Settings[currentSetting].isInBand( i, f ) ) {
        output = i;
      }
    }
    return output;
  }


  void nextSetting() {
    currentSetting++;
    if ( currentSetting >= numSettings ) { 
      currentSetting = 0;
    }
    updateSettings();
  }

  void prevSetting() {
    currentSetting--;
    if ( currentSetting < 0 ) { 
      currentSetting = numSettings - 1;
    }
    updateSettings();
  }
}


class Setting {
  int numBands;
  Band[] Bands;
  float bgDetail;
  float bgSpeed;
  color bgColor;
  color handsFill;
  color handsStroke;

  Setting( float bgDetailIn, float bgSpeedIn, color bgColorIn, color handsStrokeIn, color handsFillIn ) {
    this.numBands = 0;
    this.Bands = new Band[0];
    this.bgDetail = bgDetailIn;
    this.bgSpeed = bgSpeedIn;
    this.bgColor = bgColorIn;
    this.handsFill = handsFillIn;
    this.handsStroke = handsStrokeIn;
  }

  void addBand( float bandStartIn, float bandWidthIn, color bandColorIn ) {
    Band[] tempBands = new Band[ numBands + 1 ];
    for ( int i = 0; i < numBands; i++ ) {
      tempBands[i] = new Band( Bands[i].bandStart, Bands[i].bandWidth, Bands[i].bandColor );
    }
    tempBands[ numBands ] = new Band( bandStartIn, bandWidthIn, bandColorIn );
    Bands = tempBands;
    numBands++;
  }

  Boolean isInBand( int bandNumber, float f ) {
    if ( bandNumber < numBands ) {
      return Bands[bandNumber].isInBand( f );
    } else {
      return false;
    }
  }
}


class Band {
  float bandStart;
  float bandWidth;
  color bandColor;

  Band( float bandStartIn, float bandWidthIn, color bandColorIn ) {
    this.bandStart = bandStartIn;
    this.bandWidth = bandWidthIn;
    this.bandColor = bandColorIn;
  }

  Boolean isInBand( float f ) {
    if ( f >= bandStart && f <= bandStart + bandWidth ) {
      return true;
    } else {
      return false;
    }
  }
}