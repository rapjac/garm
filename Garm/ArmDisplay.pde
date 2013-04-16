class ArmDisplay {
  
  PFont displayFont = createFont( "Century Gothic", 15 );
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
  int action = 0;
  
  ArmDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
    
  }
  
  void render() {
    drawWindow();
    drawActions();
    drawArm();
    drawRotator();
  }
  
    
  void drawActions() {
    int startX = this.startX + width/4;
    int startY = this.startY + this.height*25/32;
    
    ellipseMode( CENTER );
    strokeWeight( 3 );
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
    text( "Lower Arm", startX + 20, startY - 30 );
    text( "Open Gripper", startX + 50, startY );
    text( "Close Gripper", startX + 20, startY + 30 );
    textAlign( RIGHT, CENTER );
    text( "Raise Arm", startX - 50, startY );
    
  }
  
  void drawArm() {
    
    int x = this.x;
    int y = this.y;
    float angle = 0;
    float anchor = 0;
    for( int i = 0; i < 3; i++ ) {
      angle = -( PI/6 + map( arm.links[i].getServoValue(), 0, 1023, radians(0), radians(300) ) ) + HALF_PI + anchor + i*HALF_PI;
      if( i == 2 ) angle -= HALF_PI;
      int dx = x + int( arm.links[i].length*cos( angle ) );
      int dy = y + int( arm.links[i].length*sin( angle ) );
      stroke( #232323 );
      strokeWeight( width/32 );
      line( x, y, dx, dy );
      stroke( #121212 );
      strokeWeight( width/80 );
      if( !arm.links[i].actuator.led ) fill( #00AC00 );
      else fill( #AC0000 );
      ellipse( x, y, width/20, width/20 );
      strokeWeight( width/64 );
      line( x, y, dx, dy );
      noStroke();
      fill( #121212 );
      ellipse( x, y, width/40, width/40 );
      anchor = angle;
      x = dx;
      y = dy;
    }
    
    int dist = (int) map( constrain( arm.gripper.getServoValue(), 205, 512 ), 205, 512, 2, width/20 );
    float gripperTopX = x + dist/2*cos(angle + HALF_PI);
    float gripperTopY = y + dist/2*sin(angle + HALF_PI);
    float gripperBottomX = x - dist/2*cos(angle + HALF_PI);
    float gripperBottomY = y - dist/2*sin(angle + HALF_PI);
    
    noStroke();
    fill(#121212);
    quad(
      gripperTopX - this.width/64*cos(angle),
      gripperTopY - this.width/64*sin(angle),
      gripperTopX + this.width/16*cos(angle),
      gripperTopY + this.width/16*sin(angle),
      gripperTopX + this.width/16*cos(angle) + this.width/128*cos(angle + HALF_PI),
      gripperTopY + this.width/16*sin(angle) + this.width/128*sin(angle + HALF_PI),
      gripperTopX + this.width/40*cos(angle + HALF_PI),
      gripperTopY + this.width/40*sin(angle + HALF_PI)
    );
    quad(
      gripperBottomX - width/64*cos(angle),
      gripperBottomY - width/64*sin(angle),
      gripperBottomX + width/16*cos(angle),
      gripperBottomY + width/16*sin(angle),
      gripperBottomX + width/16*cos(angle) - width/128*cos(angle + HALF_PI),
      gripperBottomY + width/16*sin(angle) - width/128*sin(angle + HALF_PI),
      gripperBottomX - width/40*cos(angle + HALF_PI),
      gripperBottomY - width/40*sin(angle + HALF_PI)
    );
    
    stroke( #121212 );
    strokeWeight( width/80 );
    if( !arm.gripper.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( x, y, width/20, width/20 );   
    noStroke();
    fill( #121212 );
    ellipse( x, y, width/40, width/40 );
    
  }
  
  void drawRotator() {
    
    float startX = this.x;
    float startY = this.y + height/2;
    float angle = -( PI/6 + map( arm.rotator.getServoValue(), 0, 1023, radians(0), radians(300) ) ) + HALF_PI;
    
    stroke( #121212 );
    strokeWeight( this.width/80 );
    if( !arm.rotator.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( startX, startY, this.width/10, this.width/10 );   
    strokeWeight( this.width/48 );
    line( startX, startY, startX + this.width/12*cos( angle ), startY + this.width/12*sin( angle ) );
    noStroke();
    fill( #121212 );
    ellipse( startX, startY, this.width/20, this.width/20 );
    
  }
  
  void drawWindow() {   
    rectMode( CORNER );
    stroke( #121212 );
    strokeWeight( 5 );
    fill( #909090 );
    rect( this.startX, this.startY, this.width, this.height, 20 );
  }
  
  void setAction( int action ) {
    this.action = action;
  }
  
}
