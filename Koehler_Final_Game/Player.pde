class Player {
  
  //Variables
 int x;
 int y;
 int w; //width
 int h; //height
 color c; //color
 int runSpeed; //speed of running player
 int jumpSpeed; //speed player jumps up
 int fallSpeed; //speed player falls
 int topBound; //top boundary of player
 int bottomBound; //bottom bound of player
 int leftBound; //left boundary of player
 int rightBound; //right boundary
 boolean movingUp; //when true, player moves up
 boolean movingDown; //when true, player moves down
 boolean isJumping; //when true, player will be rising
 boolean isFalling; //when true, player will be falling
 int jumpHeight; //distance player moves up when jumping
 int peakY; //y value player will have when it reaches top of jump
 int groundY;{ //y value of playing floor
 
 //Constructor
 runSpeed = 8;
 jumpSpeed = 10;
 fallSpeed = 10;
 topBound = y;
 bottomBound = y+h;
 leftBound = x;
 rightBound = x+w;
 movingUp = false;
 movingDown = false;
 isJumping = false;
 isFalling = false;
 jumpHeight = 500;
 groundY = 600;
 peakY = groundY-jumpHeight;}

Player() {
   w = 75;
   h = 75;
   x = 150;
   y = groundY - h;
   c = color(152,255,235);  
}

 //Functions
 
 //moves player up and down on level 3
 void fly(){
   if (movingUp == true && y >= 0){
     y = y - jumpSpeed;
   }
   if (movingDown == true && y <= height-h){
     y = y + jumpSpeed;
   }
 }
 
 //checks if player is jumping
 void jump(){
   if (isJumping == true && isFalling == false){
     y = y - jumpSpeed;
   }
 }
 
 //checks if player has reached top of jump
 void reachedTopOfJump(){
   if (y <= peakY && isJumping == true){
     isJumping = false;
     isFalling = true;
   }
 }
 
 //checks if player is falling
 void fall(){
   if (isFalling == true && isJumping == false){
     y = y + fallSpeed;
   }
 }
 
 //checks if player has landed
 void land(){
  if (y >= groundY - h){
    isFalling = false; 
  }
 }
 
 //matches boundaries to player location
 void resetBoundaries(){
   if (y != topBound){
     topBound = y;
     //println(topBound);
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
 
 //checks if player is falling off of platform
 void fallOffPlatform(ArrayList<Platform> l1Platforms){
   if (isJumping == false && y < groundY-h){
     boolean onPlatform = false;
    
     for(Platform aPlatform : l1Platforms){
       if (leftBound <= aPlatform.rightBound && rightBound >= aPlatform.leftBound && bottomBound >= aPlatform.topBound && topBound <= aPlatform.bottomBound)
        onPlatform = true;
     }
     
     if(onPlatform == false){
       isFalling = true;
     }
   }
 }
}
