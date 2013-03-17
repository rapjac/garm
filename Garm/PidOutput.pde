class PidOutput{
  
  //Outputs
  float processVar;
  
  //Tuning Parameters
  private float kP;
  private float kI;
  private float kD;
  
  //Variables
  private float previousError;
  private float previousOutput;
  private float integral;
  private float derivative;
  
  //Constructor
  PidOutput( float kP, float kI, float kD, float processVar ){
    this.kP = kP;
    this.kI = kI;
    this.kD = kD;
    
    this.processVar = processVar;
    
    this.previousError = 0;
    this.previousOutput = 0;
    this.integral = 0;
    this.derivative = 0;
  }
  
  void output( float setPoint ){
    if( !Double.isNaN( setPoint ) ) {
      float error = setPoint - this.processVar;
      if( error != 0 ) {
      this.integral += error;
      this.derivative = error - this.previousError;
      float output = ( this.kP * this.processVar ) + ( this.kI * this.integral ) + ( this.kD * this.derivative );
      this.previousError = error;
      this.previousOutput = output;
      this.processVar = output;
      } else this.processVar = this.previousOutput;
    }
  }
  
}
