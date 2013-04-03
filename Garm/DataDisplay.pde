class DataDisplay {
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
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
    drawModeIndicators();
    drawSerialIndicator();
  }
  
  void drawData() {
    int textStartX = this.startX + 50;
    int startX = this.startX + 30;
    int startY = this.startY + 30;
    
    int i = 0;
    
    drawAx12Data( armDisplay.arm.rotator.actuator, "Rotator", startX, startY + 60*i++ );
    drawAx12Data( armDisplay.arm.links[0].actuator, "Link 0", startX, startY + 60*i++ );
    drawAx12Data( armDisplay.arm.links[1].actuator, "Link 1", startX, startY + 60*i++ );
    drawAx12Data( armDisplay.arm.links[2].actuator, "Link 2", startX, startY + 60*i++ );
    drawAx12Data( armDisplay.arm.gripper.actuator, "Gripper", startX, startY + 60*i++ );
    
  }
  
  void drawAx12Data( Ax12 actuator, String name, int startX, int startY ) {
    float angle = PI/6 + map( actuator.presentPosition, 0, 1023, radians(0), radians(300) );
    int i = 0;
    int textStartX = this.startX + 55;
    
    stroke( #121212 );
    strokeWeight( 4 );
    if( actuator.led ) fill( #AC0000 );
    else fill( #00AC00 );
    ellipse( startX, startY, 20, 20 );
    
    line( startX, startY, startX + 15*cos(-angle+HALF_PI), startY + 15*sin(-angle+HALF_PI) );
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
    //text( actuator.presentPosition, textStartX + 55*i++, startY + 20);
  }
  
  void drawModeIndicators() {
    for( int i = 0; i < 3; i++ ) {
      stroke( #121212 );
      fill( #ACACAC );
      rectMode( CENTER );
      rect( this.startX + this.width*(2*i+1)/6, this.startY + this.height*25/32, this.width*5/24, this.height*7/48, 5 );
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
