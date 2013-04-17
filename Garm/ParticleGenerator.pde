// Particles 4 originally by Seb Lee-Delisle
// http://www.openprocessing.org/sketch/49197

Particle[] particles = new Particle[0]; 
 
int maxParticles = 100;

void generateParticles() {
  particles = (Particle[]) append(particles, new Particle());
  for (int i=0; i<particles.length; i++) {
    particles[i].update();
  }
  while (particles.length > maxParticles) {
    // take the oldest of the front of the array
    particles = (Particle[]) subset(particles, 1);
  }
}
 
class Particle {
 
  // position properties for our particle
  float x;
  float y;
 
  // velocity is the change in position every frame.
  float velX;
  float velY;
   
  float drag;
    
  float particleSize;
  float shrink;
   
  float gravity;
  int opacity;
  int fade;
 
  // constructor : this is a special function that is
  // called whenever a Particle is instantiated.
  Particle() {
 
    // set the x and y position
    x = width/8 + 60;
    y = height/8 + 30;
 
    // set the velocity to be a random number between
    // in both x and y directions.
    velX = random( -5, 4 );
    velY = random( -4, 5 );
     
    drag = 0.96;
     
    particleSize = random( 50, 65 );
    shrink = 0.97;
     
    gravity = 0;
    opacity = 255;
    fade = 1; 
  }
 
  void update() {
    // apply drag to our velocity
    velX *= drag;
    velY *= drag;
     
    // add gravity;
    velY += gravity;
     
    // add the velocity to the position
    x += velX;
    y += velY; 
     
    particleSize *= shrink;
    opacity -= fade;
     
    if(opacity > 0) {
      noStroke();
      fill( #C9C9C9, opacity );
      ellipse( x, y, particleSize, particleSize);
    }
  }
}

