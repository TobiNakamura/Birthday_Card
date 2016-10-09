//----------------------------------------------------------------------------------------------------//
                                              //DON'T CRITICIZE MY CODE//
//----------------------------------------------------------------------------------------------------//     
//also try and find the eastereggs in the game
//and yes I'm calling this half-assed interactive thing a game





Charector cyrus;   //---------------------------------------the protagonist
LandScape presentation;
int score;     //------------------------------------------the antagonist


//-----------------------javascript
interface JavaScript {
  void playSound();
}
void bindJavascript(JavaScript js) {
  javascript = js;
}
JavaScript javascript;
//---------------------------------------

void setup() {
  size(700, 700);
  cyrus = new Charector(350, 650);
  presentation = new LandScape();
  if (javascript != null){
    javascript.playSound(); //-----------------javascript
  }
  

}


void draw() {
  background(#f2e7ba);
  boolean scrolling = presentation.scroll();
  cyrus.move(scrolling);
}


class Charector {
  PVector pos = new PVector();
  float speed = 50;           //    -------------------------charector speed
  Charector(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  
  void move(boolean scroll){
    if (!scroll){
    
    pos.y += (mouseY - pos.y + 50) / speed; 
    }
    pos.x += (mouseX - pos.x) / speed;
    noStroke();
    fill(#EDC05D);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 50, 50);
  }
}


class LandScape {
  float detection = 100;
  PImage finalImg;
  float goodiesY[] = {-2300, 150, 50, -50, 150, 50, -50, 175, -188, -530, -1070, -1081, -873, -1634, -1381, -2900, -3500, -4100, -6000, -6100, -6200, -300, -2250, -200};
  Candle[] candles = new Candle[15];
  Sparkly theCake = new Sparkly(350);
  LandScape(){
    candles[0] = new Candle(100);
    candles[1] = new Candle(100);
    candles[2] = new Candle(100);
    candles[3] = new Candle(600);
    candles[4] = new Candle(600);
    candles[5] = new Candle(600);
    candles[6] = new Candle(340);
    
    candles[7] = new Candle(142);
    candles[8] = new Candle(678);
    candles[9] = new Candle(49);
    candles[10] = new Candle(295);
    candles[11] = new Candle(349);
    candles[12] = new Candle(464);
    candles[13] = new Candle(565);
    candles[14] = new Candle(165);
    finalImg = loadImage("img/hbdyo.png");
  }
  
  boolean scroll(){
    boolean returning = false;
    float scrollSpeed = 2;                        //------------scroll speed
    if (mouseY < detection){  //--------------up
      int i = 0;
      while (i < goodiesY.length){
        goodiesY[i] += scrollSpeed;
        i++;
      }
      returning = true;
    } else if(mouseY > height - detection){ //-------------down
      int i = 0;
      while (i < goodiesY.length){
        goodiesY[i] -= scrollSpeed;
        i++;
      }
      returning = true;
    } else {returning = false;}
    
    goodies();
    return returning;
  }
  
  private void goodies(){
    imageMode(CENTER);
    image(finalImg, 350, goodiesY[0]);
    //--------------------------guidence candles
    candles[0].draw(goodiesY[1]);
    candles[1].draw(goodiesY[2]);
    candles[2].draw(goodiesY[3]);
    candles[3].draw(goodiesY[4]);
    candles[4].draw(goodiesY[5]);
    candles[5].draw(goodiesY[6]);
    candles[6].draw(goodiesY[7]);
    
    candles[7].draw(goodiesY[8]);
    candles[8].draw(goodiesY[9]);
    candles[9].draw(goodiesY[10]);
    candles[10].draw(goodiesY[11]);
    candles[11].draw(goodiesY[12]);
    candles[12].draw(goodiesY[13]);
    candles[13].draw(goodiesY[14]);
    candles[14].draw(goodiesY[21]);
    
    //------------------------credits
    fill(#CB6F50);
    textSize(50);
    textAlign(CENTER);
    text("Score: " + score, 350, goodiesY[15]);
    textSize(250);
    fill(#e95624);
    text("Tobi", 350, goodiesY[16]);
    text("Bryan", 350, goodiesY[17]);
    textSize(50);
    text("He's a real nowhere man", 350, goodiesY[20]);
    text("Sitting in his nowhere land", 350, goodiesY[19]);
    textSize(30);
    text(" - Nowhere Man, The Beatles", 450, goodiesY[18]);
    
    //-----------sparkling candle
    theCake.draw(goodiesY[0] - 170);
  }
  
}

class Candle{
  int cycleCount = 0;
  int frame = 0;
  float x;
  PImage[] flame = new PImage[3];
  PImage smoke, wax;
  boolean extinguished = false;
  Candle(float x){
    this.x = x;
    flame[0] = loadImage("img/a.png");
    flame[1] = loadImage("img/b.png");
    flame[2] = loadImage("img/c.png");
    smoke = loadImage("img/smoke.png");
    wax = loadImage("img/wax.png");
  }
  
  void draw(float y){
    image(wax, x+3, y + 40);
    
    if(!extinguished){  //normal flameing
      image(flame[frame], x, y);
      if (cycleCount > 7){    //skips changing of images for a few frames
        cycleCount = 0;
        frame++;
      }
      cycleCount++;
      if (frame > 2){
        frame = 0;
      }
      
      
      if (abs(cyrus.pos.x - x) < 50 && abs(cyrus.pos.y - y) < 50){  //collision mesh
        extinguished = true;
        frame = 70; //length of smoke animation
        score++;
      }
    }
    
    if (frame > 0 & extinguished == true){    //smoke animation
      image(smoke, x, y - cycleCount);
      frame--;
      cycleCount++; //speed if smoke
    }
    
    //ignor method when extinguished == true
    
  }
}


class Sparkly {
  int reflect = 1;
  int currentColor;
  int cycleCount = 0;
  int frame = 0;
  float x;
  PImage[] flame = new PImage[3];
  boolean extinguished = false;
  PVector[] sparks;
  int[] colours = {#91D691, #F25862, #1BF5EF, #CC1BF5};
  Sparkly(float x){
    this.x = x;
    flame[0] = loadImage("img/a.png");
    flame[1] = loadImage("img/b.png");
    flame[2] = loadImage("img/c.png");
    sparks = new PVector[10];
    int i = 0;
    while (i < sparks.length){
      sparks[i] = new PVector(0, 0);
      i++;
    }
  }
  
  void draw(float y){
    
    if(!extinguished){  //normal flameing
      image(flame[frame], x, y);
      if (cycleCount > 7){    //skips changing of images for a few frames
        cycleCount = 0;
        frame++;
      }
      cycleCount++;
      if (frame > 2){
        frame = 0;
      }
      
      
      if (abs(cyrus.pos.x - x) < 50 && abs(cyrus.pos.y - y) < 50){  //collision mesh
        extinguished = true;
        score++;
        frame = 0;
        currentColor = colours[round(random(0, 3))];
      }
    }
    
    if (extinguished == true){    //smoke animation
    
      if (cycleCount > 30){
        cycleCount = 0;
        frame++;
        reflect = round(random(1, 2));
        if (reflect == 1){reflect = -1;}
        else{reflect = 1;}
        currentColor = colours[round(random(0, 3))];
      }
      if(frame > 9){
        frame = 0;
      }
      
      sparks[frame].x = x - cycleCount*reflect;
      sparks[frame].y = y - sqrt(cycleCount)*20;
      fill(currentColor);
      noStroke();
      ellipse(sparks[frame].x, sparks[frame].y, 5, 5);

      cycleCount++; //speed of smoke
    }
    
    //ignor method when extinguished == true
    
  }
}

