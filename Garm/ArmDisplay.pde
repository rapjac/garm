class ArmDisplay {
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
  int targetX = 35;
  int targetY = -68;
  
  int grip = 512;
  int rotatorAngle = 511;
  float wristAngle;
  
  Arm arm;
  
  ArmDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
    
    int[] lengths = { width/9, width/8, width/13 };
    this.arm = new Arm( lengths );
  }
  
  void render() {
    drawWindow();
    drawArm();
    drawRotator();
  }
  
  void drawArm() {
    int x = this.startX + width/2;
    int y = this.startY + height/2;
    for( int i = 0; i < 3; i++ ){
      int dx = x + this.arm.links[i].x;
      int dy = y + this.arm.links[i].y;
      stroke( #232323 );
      strokeWeight( width/32 );
      line( x, y, dx, dy );
      stroke( #121212 );
      strokeWeight( width/80 );
      if( !this.arm.links[i].actuator.led ) fill( #00AC00 );
      else fill( #AC0000 );
      ellipse( x, y, width/20, width/20 );   
      strokeWeight( width/64 );
      line( x, y, dx, dy );
      noStroke();
      fill( #121212 );
      ellipse( x, y, width/40, width/40 );
      x = dx;
      y = dy;
    }
    int dist = (int) map( constrain( this.grip, 205, 512 ), 205, 512, 2, width/20 );
    float angle = this.arm.links[2].angle;
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
    if( !this.arm.gripper.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( x, y, width/20, width/20 );   
    noStroke();
    fill( #121212 );
    ellipse( x, y, width/40, width/40 );
    
  }
  
  void drawRotator() {
    
    float startX = this.x;
    float startY = this.y + height/2;
    float angle = PI/6 + map( arm.rotator.getServoValue(), 0, 1023, radians(0), radians(300) );
    
    stroke( #121212 );
    strokeWeight( this.width/80 );
    if( !this.arm.rotator.actuator.led ) fill( #00AC00 );
    else fill( #AC0000 );
    ellipse( startX, startY, this.width/10, this.width/10 );   
    strokeWeight( this.width/48 );
    line( startX, startY, startX + this.width/12*cos(-angle+ HALF_PI), startY + this.width/12*sin(-angle+HALF_PI) );
    noStroke();
    fill( #121212 );
    ellipse( startX, startY, this.width/20, this.width/20 );
  }
  
  void drawWindow() {   
    rectMode( CORNER );
    stroke( #121212 );
    strokeWeight(5);
    fill( #909090 );
    rect( this.startX, this.startY, this.width, this.height, 20 );
  }
  
}
