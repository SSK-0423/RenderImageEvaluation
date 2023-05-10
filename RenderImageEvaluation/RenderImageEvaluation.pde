Sprite renderImg;
Sprite referenceImg; 

float imgW;
float imgH;
Mouse mouse;
Button test;
Button 

void setup(){
  size(800,400);
  imgW = width/3;
  imgH = width/3;
  
  renderImg = new Sprite(width/10 + imgW/2, height/10 + imgH/2,imgW,imgH);
  renderImg.loadImg("CornellBox.png");
  
  referenceImg = new Sprite(width - width/10 - imgW/2,height/10 + imgH/2,imgW,imgH);
  referenceImg.loadImg("CornellBox.png");
  
  mouse = new Mouse();
  test = new Button(width/2,height/2,100,100,color(255,255,255),"PUSH");
}

void update(){
  mouse.update();
  test.update(mouse);
}

void draw(){  
  colorMode(RGB,255);
  background(255);
  
  // 画像表示
  renderImg.display();
  referenceImg.display();
  
  test.display();
}
