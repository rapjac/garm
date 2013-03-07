class ArmGripper {
  int grip = 1023;
  
  ArmGripper() {
  }
  
  void update( int grip ) {
    this.grip = (int) constrain( map( grip, -1, 0, 0, 1023 ), 0, 1023);
  }
}
