Sprite renderImg;
Sprite referenceImg; 

float imgW;
float imgH;

void setup(){
  size(800,400);
  imgW = width/3;
  imgH = width/3;
  
  renderImg = new Sprite(width/10 + imgW/2, height/10 + imgH/2,imgW,imgH);
  renderImg.loadImg("CornellBox.png");
  
  referenceImg = new Sprite(width - width/10 - imgW/2,height/10 + imgH/2,imgW,imgH);
  referenceImg.loadImg("CornellBox.png");
}

void draw(){
  background(255);
  
  // 画像表示
  renderImg.display();
  referenceImg.display();
}
