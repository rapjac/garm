class DataDisplay {
  
  PFont displayFont = createFont( "Century Gothic", 16 );
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
  int action = 0;
  
  PFont headerFont = createFont( "Courier New Bold", 14 );
  PFont dataFont = createFont( "Courier New", 14 );
  
  DataDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
  }
  
  void render() {
    drawWindow();
    drawData();
    drawActions();
    drawSerialIndicator();
  }
  
  void drawData() {
    int textStartX = this.startX + 50;
    int startX = this.startX + 30;
    int startY = this.startY + 30;
    int i = 0;
    
    drawAx12Data( arm.rotator.actuator, "Rotator", startX, startY + 60*i++ );
    drawAx12Data( arm.links[0].actuator, "Link 0", startX, startY + 60*i++ );
    drawAx12Data( arm.links[1].actuator, "Link 1", startX, startY + 60*i++ );
    drawAx12Data( arm.links[2].actuator, "Link 2", startX, startY + 60*i++ );
    drawAx12Data( arm.gripper.actuator, "Gripper", startX, startY + 60*i++ );
    
  }
  
  void drawAx12Data( Ax12 actuator, String name, int startX, int startY ) {
    float angle = -( PI/6 + map( actuator.presentPosition, 0, 1023, radians(0), radians(300) ) ) + HALF_PI;
    int i = 0;
    int textStartX = this.startX + 55;
    
    stroke( #121212 );
    strokeWeight( 4 );
    if( actuator.led ) fill( #AC0000 );
    else fill( #00AC00 );
    ellipse( startX, startY, 20, 20 );
    
    line( startX, startY, startX + 15*cos( angle ), startY + 15*sin( angle ) );
    fill( #121212 );
    ellipse( startX, startY, 5, 5 );
    fill( #121212 );
    textAlign( LEFT, CENTER );
    textFont( headerFont );
    text( "[" + actuator.id + "] " + name, textStartX, startY );
    textFont( dataFont );
    text( actuator.presentTemperature + "ºC", textStartX + 65*i++, startY + 20);
    text( actuator.presentVoltage + "V", textStartX + 65*i++, startY + 20);
    text( actuator.presentLoad + "kg", textStartX + 65*i++, startY + 20);
    text( actuator.presentSpeed + " rad/s", textStartX + 65*i++, startY + 20);
  }
  
  void drawModeIndicators() {
    for( int i = 0; i < 3; i++ ) {
      stroke( #121212 );
      fill( #ACACAC );
      rectMode( CENTER );
      rect( this.startX + this.width*(2*i+1)/6, this.startY + this.height*25/32, this.width*5/24, this.height*7/48, 20 );
    }
  }
  
  void drawActions() {
    int startX = this.x;
    int startY = this.startY + this.height*25/32;
    
    ellipseMode( CENTER );
    strokeWeight( 3 );
    
    if( control.armControlMode ) {
      
    } else {
      stroke( #121212 );
      ellipseMode( CENTER );
      if( this.action == 1 ) fill( #F2CE00 );
      else fill( #E0AC00 );
      ellipse( startX, startY - 30, 20, 20 );
      if( this.action == 3 ) fill( #00CE00 );
      else fill( #00AC00 );
      ellipse( startX + 30, startY, 20, 20 );
      if( this.action == 4 ) fill( #5656CE );
      else fill( #3434AC );
      ellipse( startX, startY + 30, 20, 20 );
      if( this.action == 2 ) fill( #CE0000 );
      else fill( #AC0000 );
      ellipse( startX - 30, startY, 20, 20 );
      
      fill( #121212 );
      textFont( displayFont );
      textAlign( LEFT, CENTER );
      text( "   Grasp", startX, startY - 30 );
      text( "   Place Object", startX + 30, startY );
      text( "   Push Button", startX, startY + 30 );
      textAlign( RIGHT, CENTER );
      text( "Reset   ", startX - 30, startY );
      
    }
    
  }
  
  void drawSerialIndicator() {
    stroke( #121212 );
    strokeWeight( 4 );
    if( communication.serialActive ) fill( #00AC00 );
    else fill( #004500 );
    ellipse( this.startX + 30, this.startY + height - 30, 20, 20 );
    fill( #121212 );
    textAlign( LEFT, CENTER );
    textFont( headerFont );
    text( "Serial Activity", this.startX + 50, this.startY + height - 30);
  }
  
  void drawWindow() {   
    rectMode( CORNER );
    stroke( #121212 );
    strokeWeight(5);
    fill( #909090 );
    rect( this.startX, this.startY, this.width, this.height, 20 );
  }
}
