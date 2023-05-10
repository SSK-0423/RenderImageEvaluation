Sprite renderImg;
Sprite referenceImg;

float imgW;
float imgH;
Mouse mouse;
Button calcButton;
Button loadRenderImgButton;
Button loadReferenceImgButton;

float textSize = 20;

void setup() {
  size(800, 400);
  imgW = width/3;
  imgH = width/3;

  renderImg = new Sprite(width/10 + imgW/2, height/20 + imgH/2, imgW, imgH);
  //renderImg.loadImg("CornellBox.png");

  referenceImg = new Sprite(width - width/10 - imgW/2, height/20 + imgH/2, imgW, imgH);
  //referenceImg.loadImg("CornellBox.png");

  mouse = new Mouse();
  calcButton = new Button(width/2, height - height/10, 100, 40, color(255, 255, 255), "Calculate");
  loadRenderImgButton = new Button(renderImg.pos.x+5,height - height/10,200,40,color(255,255,255),"Load Render Image");
  loadReferenceImgButton = new Button(referenceImg.pos.x+10,height - height/10,200,40,color(255,255,255),"Load Reference Image");
}

void update() {
  mouse.update();
  calcButton.update(mouse);
  loadRenderImgButton.update(mouse);
  loadReferenceImgButton.update(mouse);

  // ボタンが押されたら
  if (calcButton.isClicked()) {
    onClickCalcButton();
  }
  if(loadRenderImgButton.isClicked()){
    onClickRenderImgButton();
  }
  if(loadReferenceImgButton.isClicked()){
    onClickReferenceImgButton();
  }
}

void draw() {
  update();

  colorMode(RGB, 255);
  background(255);

  // 画像表示
  renderImg.display();
  referenceImg.display();
  // テキスト表示
  textAlign(CENTER, CENTER);
  textSize(textSize);
  text("Render Image", renderImg.pos.x, renderImg.pos.y + renderImg.h/2 + textSize);
  text("Reference", referenceImg.pos.x, referenceImg.pos.y + referenceImg.h/2 + textSize);
  // ボタン表示
  calcButton.display();
  loadRenderImgButton.display();
  loadReferenceImgButton.display();
}

void onClickCalcButton() {
  println("コサイン類似度計算するぞ");
}

void onClickRenderImgButton(){
  selectInput("Select a render image file","loadRenderImage");
}

void loadRenderImage(File selection){
  if(selection == null){
    println("canceled");
  }
  else{
    println("User selected:" + selection.getAbsolutePath());
    renderImg.loadImg(selection.getAbsolutePath());
    //renderImg.loadImg(selection.getAbsolutePath());
  }
}

void onClickReferenceImgButton(){
  selectInput("Select a reference image file","loadReferenceImage");
}

void loadReferenceImage(File selection){
  if(selection == null){
    println("canceled");
  }
  else{
    println("User selected:" + selection.getAbsolutePath());
    referenceImg.loadImg(selection.getAbsolutePath());
  }
}
