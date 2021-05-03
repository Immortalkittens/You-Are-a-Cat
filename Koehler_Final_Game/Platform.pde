class Platform {
  
  //Variables
  int x;
  int y;
  int w; //width
  int h; //height
  int c; //color
  int platformSpeed; //speed platform moves
  int topBound; //top boundary of platform
  int bottomBound; //bottom boundary
  int leftBound; //left boundary
  int rightBound; //right boundary
  
  //Constructor
  Platform(int tempX, int tempY, int tempW, int tempH){
    x = tempX;
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    c = color(160);
    platformSpeed = 10;
    
    topBound = x;
    bottomBound = x + h;
    leftBound = y;
    rightBound = y + w;
  }
  
  //Functions
  //makes obstacles move toward player
  void move(){
   x = x - platformSpeed; 
  }
  
  //matches boundaries to object location
   void resetBoundaries(){
   if (y != topBound){
     topBound = y;
   }
   if (y+h != bottomBound){
     bottomBound = y+h;
   }
   if (x != leftBound){
    leftBound = x; 
   }
   if (x+w != rightBound){
    rightBound = x+w; 
   }
 }
 
 //checks if player has landed on platform
 void landedOn(Player p1){
   if (p1.isFalling == true && p1.bottomBound >= topBound && p1.leftBound <= rightBound && p1.rightBound >= leftBound && p1.topBound <= bottomBound){
     p1.isFalling = false;
   }
 }
  
 //checks if player is touching obstacle
 void hit(Player p1){
   if (p1.rightBound >= leftBound && p1.bottomBound >= topBound && p1.leftBound <= rightBound && p1.topBound <= bottomBound){
     switchVal = 4;
   }
 }
 
}
