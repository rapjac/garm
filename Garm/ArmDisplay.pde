class ArmDisplay {
  
  PFont displayFont = createFont( "Century Gothic", 16 );
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
  int targetX = 30;
  int targetY = -45;
  
  int grip = 512;
  int rotatorAngle = 511;
  float wristAngle;
  
  int action = 0;
  
  Arm arm;
  
  ArmDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
    
    int[] lengths = { width/18, width/16, width/26 };
    this.arm = new Arm( lengths );
  }
  
  void render() {
    drawWindow();
    drawLiveFeed();
    drawActions();
    drawArm();
    drawRotator();
      
  }
  
  void drawArm() {
    
    int x = this.startX + width*3/4;
    int y = this.startY + height*3/4;
    float angle = 0;
    float anchor = 0;
    for( int i = 0; i < 3; i++ ) {
      angle = -( PI/6 + map( this.arm.links[i].getServoValue(), 0, 1023, radians(0), radians(300) ) ) + HALF_PI + anchor + i*HALF_PI;
      if( i == 2 ) angle -= HALF_PI;
      int dx = x + int( this.arm.links[i].length*cos( angle ) );
      int dy = y + int( this.arm.links[i].length*sin( angle ) );
      stroke( #232323 );
      strokeWeight( width/64 );
      line( x, y, dx, dy );
      stroke( #121212 );
      strokeWeight( width/160 );
      if( !this.arm.links[i].actuator.led ) fill( #00AC00 );
      else fill( #AC0000 );
      ellipse( x, y, width/40, width/40 );
      strokeWeight( width/128 );
      line( x, y, dx, dy );
      noStroke();
      fill( #121212 );
      ellipse( x, y, width/80, width/80 );
      anchor = angle;
      x = dx;
      y = dy;
    }
    
    int dist = (int) map( constrain( this.arm.gripper.getServoValue(), 205, 512 ), 205, 512, 2, width/40 );
    float gripperTopX = x + dist/2*cos(angle + HALF_PI);
    float gripperTopY = y + dist/2*sin(angle + HALF_PI);
    float gripperBottomX = x - dist/2*cos(angle + HALF_PI);
    float gripperBottomY = y - dist/2*sin(angle + HALF_PI);
    
    noStroke();
    fill(#121212);
    quad(
      gripperTopX - this.width/128*cos(angle),
      gripperTopY - this.width/128*sin(angle),
      gripperTopX + this.width/32*cos(angle),
      gripperTopY + this.width/32*sin(angle),
      gripperTopX + this.width/32*cos(angle) + this.width/256*cos(angle + HALF_PI),
      gripperTopY + this.width/32*sin(angle) + this.width/256*sin(angle + HALF_PI),
      gripperTopX + this.width/80*cos(angle + HALF_PI),
      gripperTopY + this.width/80*sin(angle + HALF_PI)
    );
    quad(
      gripperBottomX - width/128*cos(angle),
      gripperBottomY - width/128*sin(angle),
      gripperBottomX + width/32*cos(angle),
      gripperBottomY + width/32*sin(angle),
      gripperBottomX + width/32*cos(angle) - width/256*cos(angle + HALF_PI),
      gripperBottomY + width/32*sin(angle) - width/256*sin(angle + HALF_PI),
      gripperBottomX - width/80*cos(angle + HALF_PI),
      gripperBottomY - width/80*sin(angle + HALF_PI)
    );
    
    stroke( #121212 );
    strokeWeight( width/160 );
    if( !this.arm.gripper.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( x, y, width/40, width/40 );   
    noStroke();
    fill( #121212 );
    ellipse( x, y, width/80, width/80 );
    
  }
  
  void drawRotator() {
    
    float startX = this.x;
    float startY = this.y + height/2;
    float angle = -( PI/6 + map( arm.rotator.getServoValue(), 0, 1023, radians(0), radians(300) ) ) + HALF_PI;
    
    stroke( #121212 );
    strokeWeight( this.width/80 );
    if( !this.arm.rotator.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( startX, startY, this.width/10, this.width/10 );   
    strokeWeight( this.width/48 );
    line( startX, startY, startX + this.width/12*cos( angle ), startY + this.width/12*sin( angle ) );
    noStroke();
    fill( #121212 );
    ellipse( startX, startY, this.width/20, this.width/20 );
    
  }
  
  void drawLiveFeed() {
    if( camera.available() ) camera.read();
    set( armDisplay.startX, armDisplay.startY, camera );
    stroke( #121212 );
    strokeWeight( 5 );
    noFill();
    rect( this.startX, this.startY, this.width, this.height, 20 );
  }
  
  void drawActions() {
    int startX = this.startX + width/4;
    int startY = this.startY + height*3/4;
    
    ellipseMode( CENTER );
    strokeWeight( 3 );
    
    if( control.armControlMode ) {
      
      stroke( #676767 );
      fill( #898989 );
      ellipse( startX, startY - this.width/22, this.width/33, this.width/33 );
      ellipse( startX, startY + this.width/22, this.width/33, this.width/33 );
      ellipse( startX - this.width/22, startY, this.width/33, this.width/33 );
      ellipse( startX + this.width/22, startY, this.width/33, this.width/33 );
      
      fill( #676767 );
      textFont( displayFont );
      textAlign( LEFT, CENTER );
      text( "Grasp", startX + this.width/33, startY - this.width/22  );
      text( "Place Object", startX + this.width/13, startY );
      text( "Push Button", startX + this.width/33, startY + this.width/22 );
      textAlign( RIGHT, CENTER );
      text( "Reset", startX - this.width/13, startY );
      
    } else {
      stroke( #121212 );
      ellipseMode( CENTER );
      if( this.action == 1 ) fill( #F2CE00 );
      else fill( #E0AC00 );
      ellipse( startX, startY - this.width/22, this.width/33, this.width/33 );
      if( this.action == 3 ) fill( #00CE00 );
      else fill( #00AC00 );
      ellipse( startX, startY + this.width/22, this.width/33, this.width/33 );
      if( this.action == 4 ) fill( #5656CE );
      else fill( #3434AC );
      ellipse( startX - this.width/22, startY, this.width/33, this.width/33 );
      if( this.action == 2 ) fill( #CE0000 );
      else fill( #AC0000 );
      ellipse( startX + this.width/22, startY, this.width/33, this.width/33 );
      
      fill( #121212 );
      textFont( displayFont );
      textAlign( LEFT, CENTER );
      text( "Grasp", startX + this.width/33, startY - this.width/22  );
      text( "Place Object", startX + this.width/13, startY );
      text( "Push Button", startX + this.width/33, startY + this.width/22 );
      textAlign( RIGHT, CENTER );
      text( "Reset", startX - this.width/13, startY );
      
    }
    
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
