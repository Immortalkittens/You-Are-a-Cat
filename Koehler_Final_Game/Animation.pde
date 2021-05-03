class Animation {
  
  //Variables
  PImage[] images;
  float speed; //speed of gif
  float index; //position of array
  boolean isAnimating; //when true, runs animation
  
  //Constructor
  Animation (PImage[] tempImages, float tempSpeed){
    images = tempImages;
    speed = tempSpeed;
    index = 0;
    isAnimating = true;
  }
  
  //Functions
  //flips through frames
  void next(){
    index = index + speed;
      //resets index
      if (index >= images.length){
        index = 0;
      }
  }
  
  //renders animation
  void display(int x, int y){
    if(isAnimating){
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img,x,y, img.width, img.height);
     
      next();
    } else {
      PImage img = images[0];
      image(img,x,y,img.width,img.height);
    }
  }
  
  }
