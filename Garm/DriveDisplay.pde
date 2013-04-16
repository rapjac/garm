class DriveDisplay {
  
  int width;
  int height;
  int x;
  int y;
  
  int startX = 0;
  int startY = 0;
  
  DriveDisplay( int x, int y, int width, int height ) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    this.startX = this.x - this.width/2;
    this.startY = this.y - this.height/2;
    
  }
  
  void render() {
    drawWindow();
    drawSliders();
    drawMaxPower();
  }
  
  void drawSliders() {
    rectMode( CENTER );
    for( int i = 0; i < 4; i++ ) {
      int x = startX + this.width*(i+1)/8;
      int y = this.y;
      int motorValue = int( ( i < 2 ? 1 : -1 ) * map( drive.motors[i].getValue(), -127, 127, -(this.height*3/8), (this.height*3/8) ) );
      
      strokeWeight( 3 );
      noStroke();
      fill( #CDCDCD );
      rect( x, y, this.width/32, this.height*3/4, 3 );
      
      noStroke();
      fill( #EF5656 );
      rect( x, y - motorValue/2, this.width/32, motorValue, 3 );
      
      noFill();
      stroke( #121212 );
      rect( x, y, this.width/32, this.height*3/4, 3 );
      
      line( x - 15, y, x + 15, y );
      stroke( #450101 );
      fill( #EF1212 );
      rect( x, y - motorValue, this.width/32 + 16, 10, 3 );
    }
  }
  
  void drawMaxPower() {
    int radius = this.width*3/16;
    int startX = this.startX + this.width*3/4;
    int startY = this.y;
    ellipseMode( CENTER );
    stroke( #121212 );
    strokeWeight( 6 );
    fill( #454545 );
    ellipse( startX, startY, radius, radius );
    noStroke();
    fill( #008A00 );
    arc( startX, startY, radius - 5, radius - 5, -HALF_PI, map( drive.maxPower, 0, 127, 0, TWO_PI ) - HALF_PI, PIE );
    stroke( #121212 );
    strokeWeight( 6 );
    fill( #00AC00 );
    ellipse( startX, startY, this.width/12, this.width/12 );
    strokeWeight( 10 );
    line( startX, startY, startX, startY - this.width/10 );
    noStroke();
    fill( #121212 );
    ellipse( startX, startY, this.width/24, this.width/24 );
  }
  
  void drawWindow() {
    rectMode( CORNER );
    stroke( #121212 );
    strokeWeight(5);
    fill( #909090 );
    rect( this.startX, this.startY, this.width, this.height, 20 );
  }
  
}
