//Press SPACE to jump, W and S to fly

//SOUND INITIALIZATION
import processing.sound.*; //loads sounds
SoundFile laserSound; //laser sound variable
SoundFile bgMusic; //background music variable
SoundFile meowSound; //meow sound variable
SoundFile bossMusic; //boss music variable
SoundFile purrSound; //purr sound variable

//VARIABLES
int startTime; //timer start
int endTime; //timer end
int l1interval; //length of level 1
int l2interval; //length of level 2
int l3interval; //length of level 3
int laserInterval; //length of laser animation
boolean callMethod; //for calling laser timer
int laserStartTime; //laser animation start time
int laserEndTime; //laser animation end time

int switchVal; //state switch

//CLASS VARIABLES
Player p1; //player
ArrayList<Platform> l1Platforms; //creates platform arrays
ArrayList<Platform> l2Platforms;
Platform[] l3Array = new Platform[50];
Button startButton; //level 1 start
Button level2Button; //level 2 start
Button level3Button; //level 3 start
Button retryButton; //button for lose screen
Button winButton; //button for level 3 win screen
Button l1winButton; //button for level 1 win screen
Button l2winButton; //button for level 2 win screen

//ANIMATIONS
Animation catAnimation; //running cat animation
PImage[] catImages = new PImage[3];
Animation catFlyAnimation; //flying cat animation
PImage[] catFlyImages = new PImage[3];
Animation blastAnimation; //level 3 obstacle animation
PImage[] blastImages = new PImage[4];
Animation cthulhuAnimation; //boss animation
PImage[] cthulhuImages = new PImage[2];
Animation laserAnimation; //laser animation
PImage[] laserImages = new PImage[10];

//ART INITIALIZATION
PImage startScreen; //home screen
PImage loseScreen; //lose screen
PImage winScreen; //level 3 win screen
PImage level2Screen; //level 1 win screen
PImage level3Screen; //level 2 win screen
PImage level1bg; //background for level 1
PImage level2bg; //background for level 2
PImage level3bg; //background for level 3
int backgroundX; //starting position of backgrounds
int spaceSpeed; //speed of level 3 background
int backgroundSpeed; //speed of backgrounds



void setup(){
  size(1000,800);
  resetVariables();
  
  //CALLING SOUNDS
  laserSound = new SoundFile(this, "laserblast.wav");
  bgMusic = new SoundFile(this, "sneakymusic.wav");
  bgMusic.amp(.3);
  meowSound = new SoundFile(this, "meowsound.wav");
  meowSound.amp(.4);
  bossMusic = new SoundFile(this, "epicmusic.wav");
  bossMusic.amp(.4);
  purrSound = new SoundFile(this, "purrsound.wav");
  purrSound.amp(.2);
}



void draw(){
  //SWITCH STATES
  
  switch(switchVal){
    //HOME SCREEN
    case 0:
    //background
      image(startScreen,0,0,width,height);
    //starts background music
      if(!bgMusic.isPlaying()){
       bgMusic.play(); 
      }
    //checks if level 1 button is pressed
      if (mousePressed == true && mouseX >= startButton.x && mouseX <= startButton.x+startButton.w && mouseY >= startButton.y && mouseY <= startButton.y+startButton.h){
        switchVal = 1;
        meowSound.play();
        startTime = millis();
        resetVariables();
      }
    //checks if level 2 button is pressed
      if (mousePressed == true && mouseX >= level2Button.x && mouseX <= level2Button.x+level2Button.w && mouseY >= level2Button.y && mouseY <= level2Button.y+level2Button.h){
        switchVal = 2;
        meowSound.play();
        startTime = millis();
        resetVariables();
      }
    //checks if level 3 button is pressed
      if (mousePressed == true && mouseX >= level3Button.x && mouseX <= level3Button.x+level3Button.w && mouseY >= level3Button.y && mouseY <= level3Button.y+level3Button.h){
        switchVal = 3;
        meowSound.play();
        bgMusic.stop();
        startTime = millis();
        resetVariables();
      }
      break;
      
    //LEVEL 1
    case 1:
    //background
      image(level1bg,backgroundX,0);
      backgroundX = backgroundX - backgroundSpeed;
    //set timer
      endTime = millis();
      l1interval = 10700;
      
    //call player functions
      catAnimation.display(p1.x-70,p1.y-40);
      p1.jump();
      p1.reachedTopOfJump();
      p1.fall();
      p1.land();
      p1.resetBoundaries();
      p1.fallOffPlatform(l1Platforms);
      
    //call platform functions
      for (Platform aPlatform : l1Platforms){
        aPlatform.move();
        aPlatform.resetBoundaries();
        aPlatform.landedOn(p1);
        aPlatform.hit(p1);
      }
      
    //detects finish line
      if (endTime - startTime >= l1interval){
      switchVal = 6;
      }
      break;
    
    //LEVEL 2
    case 2:
    //background
      image(level2bg,backgroundX,0);
      backgroundX = backgroundX - backgroundSpeed;
    //set timer
      endTime = millis();
      l2interval = 11800;
      
    //call player functions
      catAnimation.display(p1.x-70,p1.y-40);
      p1.jump();
      p1.reachedTopOfJump();
      p1.fall();
      p1.land();
      p1.resetBoundaries();
      p1.fallOffPlatform(l1Platforms);
      
    //call platform functions
      for (Platform aPlatform : l2Platforms){
        aPlatform.move();
        aPlatform.resetBoundaries();
        aPlatform.landedOn(p1);
        aPlatform.hit(p1);
      }
      
    //detects finish line
      if (endTime - startTime >= l2interval){
        switchVal = 7;
      }
      break;
      
    //LEVEL 3
    case 3:
    //background
      image(level3bg,backgroundX,0);
      backgroundX = backgroundX - spaceSpeed;
    //character animations
      cthulhuAnimation.display(backgroundX,0);
      catFlyAnimation.display(p1.x-70,p1.y-40);
    //set timer
      endTime = millis();
      l3interval = 14000;
      
    //changes background music
      if (bgMusic.isPlaying() == true){
        bgMusic.stop();
      }
      if(!bossMusic.isPlaying()){
        bossMusic.play();
      }
      
    //call player functions
      p1.fly();
      p1.resetBoundaries();
      p1.fallOffPlatform(l1Platforms);
      
    //call platform functions
      for(int i=0; i<l3Array.length; i++){
        l3Array[i].move();
        l3Array[i].resetBoundaries();
        l3Array[i].landedOn(p1);
        l3Array[i].hit(p1);
        blastAnimation.display(l3Array[i].x,l3Array[i].y-3);
      }
      
    //detects finish line
      if (endTime - startTime >= l3interval){
        spaceSpeed = 0;
        
    //plays laser animation
      laserAnimation.display(p1.x+50,p1.y-110);
    //calls laser timer
      if(callMethod == true){
        laserStartTime = millis();
        laserSound.play();
        callMethod = false;
      }
      laserEndTime = millis();
      laserInterval = 5000;
    //end of animation
      if (laserEndTime - laserStartTime >= laserInterval){
        switchVal = 5;
      }
    }
      break;
    
    //LOSE SCREEN
    case 4:
    //background
      background(50);
      image(loseScreen,0,0,width,height);
    //stops boss music if playing
      if(bossMusic.isPlaying()){
        bossMusic.stop();
      }
    //checks if button is pressed
      if (mousePressed == true && mouseX >= retryButton.x && mouseX <= retryButton.x+retryButton.w && mouseY >= retryButton.y && mouseY <= retryButton.y+retryButton.h){
      switchVal = 0;
    //resets background music
      if(bgMusic.isPlaying()){
        bgMusic.stop();
      }
      resetVariables();
      }
      break;
   
    //LEVEL 3 WIN SCREEN
    case 5:
    //background
      background(230);
      image(winScreen,0,0,width,height);
    //stops laser if playing
      if (laserSound.isPlaying()){
        laserSound.stop();
      }
    //checks if button is pressed
      if (mousePressed == true && mouseX >= winButton.x && mouseX <= winButton.x+winButton.w && mouseY >= winButton.y && mouseY <= winButton.y+winButton.h){
        switchVal = 0;
        startTime = millis();
        bossMusic.stop();
        resetVariables();
      }
      break;
    
    //LEVEL 1 WIN SCREEN
    case 6:
    //background
      background(230);
      image(level2Screen,0,0,width,height);
    //plays purr sound
      if(!purrSound.isPlaying()){
        purrSound.play();
      }
    //checks if button is pressed
      if (mousePressed == true && mouseX >= l1winButton.x && mouseX <= l1winButton.x+l1winButton.w && mouseY >= l1winButton.y && mouseY <= l1winButton.y+l1winButton.h){
        switchVal = 2;
        startTime = millis();
        if(purrSound.isPlaying()){
          purrSound.stop();
        }
        resetVariables();
      }
      break;
     
    //LEVEL 2 WIN SCREEN
    case 7:
    //background
      background(230);
      image(level3Screen,0,0,width,height);
    //plays purr sound
      if(!purrSound.isPlaying()){
        purrSound.play();
      }
    //checks if mouse is pressed
      if (mousePressed == true && mouseX >= l2winButton.x && mouseX <= l2winButton.x+l2winButton.w && mouseY >= l2winButton.y && mouseY <= l2winButton.y+l2winButton.h){
        switchVal = 3;
        startTime = millis();
        if(purrSound.isPlaying()){
          purrSound.stop();
        }
      //stops background music
        if(bgMusic.isPlaying()){
          bgMusic.stop();
        }
        resetVariables();
      }
      break;
  }
  
}

//makes player jump
void keyPressed(){
  if (key == ' ' && p1.isJumping == false && p1.isFalling == false){
    p1.isJumping = true;
  }
  if (key == 'w'){
    p1.movingUp = true;
  }
    if (key == 's'){
    p1.movingDown = true;
  }
}

//controls height of jump
void keyReleased(){
  if (key == ' '){
    p1.isJumping = false;
    p1.isFalling = true;
  }
  if (key == 'w'){
    p1.movingUp = false;
  }
  if (key == 's'){
    p1.movingDown = false;
  }
}

//resets game to original settings
void resetVariables(){
  startTime = millis();
  
  //player animation
  for (int i=0;i<catImages.length;i++){
    catImages[i] = loadImage("run"+i+".png");
  }
  catAnimation = new Animation(catImages,.1);
  
  //player level 3 animation
  for (int i=0; i<catFlyImages.length;i++){
    catFlyImages[i] = loadImage("fly"+i+".png");
  }
  catFlyAnimation = new Animation(catFlyImages,.1);
  
  //level 3 obstacle animation
  for (int i=0;i<blastImages.length;i++){
    blastImages[i] = loadImage("blast"+i+".png");
  }
  blastAnimation = new Animation(blastImages,.001);
  
  //boss animation
  for (int i=0;i<cthulhuImages.length;i++){
    cthulhuImages[i] = loadImage("cthulhu"+i+".png");
  }
  cthulhuAnimation = new Animation(cthulhuImages,.02);
  
  //laser animation
  for (int i=0;i<laserImages.length;i++){
    laserImages[i] = loadImage("laser"+i+".png");
  }
  laserAnimation = new Animation(laserImages,.03);
  
  //loading images
  startScreen = loadImage("startscreen.png");
  loseScreen = loadImage("losescreen.png");
  winScreen = loadImage("winscreen.png");
  level2Screen = loadImage("level2screen.png");
  level3Screen = loadImage("level3screen.png");
  level1bg = loadImage("level1background.png");
  level2bg = loadImage("level2background.png");
  level3bg = loadImage("level3background.png");
  backgroundX = 0; 
  spaceSpeed = 5;
  backgroundSpeed = 10;
  callMethod = true;
  
  //creating objects
  p1 = new Player();
  startButton = new Button(50,300,400,125);
  level2Button = new Button(75,475,350,75);
  level3Button = new Button(75,600,350,75);
  retryButton = new Button(450,550,400,100);
  winButton = new Button(450,550,400,100);
  l1winButton = new Button(300,250,400,100);
  l2winButton = new Button(300,250,400,100);
  
  //Obstacles for Level 1
  l1Platforms = new ArrayList();
  l1Platforms.add(new Platform(800, 500, 250, 100));
  l1Platforms.add(new Platform(1500, 450, 100, 150));
  l1Platforms.add(new Platform(2000, 0, 50, 400));
  l1Platforms.add(new Platform(2400, p1.groundY, 400, 200));
  l1Platforms.add(new Platform(2900, 0, 50, 400));
  l1Platforms.add(new Platform(3200, 500, 250, 100));
  l1Platforms.add(new Platform(4000, 450, 100, 150));
  l1Platforms.add(new Platform(4500, p1.groundY, 400, 200));
  l1Platforms.add(new Platform(5000, 0, 50, 400));
  l1Platforms.add(new Platform(5400, 450, 100, 150));
  
  //Obstacles for Level 2
  l2Platforms = new ArrayList();
  l2Platforms.add(new Platform(800, p1.groundY, 270, 200));
  l2Platforms.add(new Platform(1550, 400, 150, 200));
  l2Platforms.add(new Platform(2150, p1.groundY, 300, 200));
  l2Platforms.add(new Platform(3000, 400, 250, 200));
  l2Platforms.add(new Platform(3750, 525, 250, 75));
  l2Platforms.add(new Platform(4500, p1.groundY, 500, 200));
  l2Platforms.add(new Platform(5600, 400, 250, 400));
  
  //Obstacles for Level 3
  for (int i=0; i<l3Array.length; i++){
    l3Array[i] = new Platform(int(random(1000,7000)), int(random(0,height)), 50, 50);
  }
}
