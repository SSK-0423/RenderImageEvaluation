Sprite renderImg;
Sprite referenceImg;

int imgW;
int imgH;
Mouse mouse;
Button calcButton;
Button viewSimilarityButton;

Button loadRenderImgButton;
Button loadReferenceImgButton;

float textSize = 20;

float[] cosList;
float similarity;

void setup() {
  size(800, 400);
  imgW = width/3;
  imgH = width/3;

  renderImg = new Sprite(width/10 + imgW/2, height/50 + imgH/2, imgW, imgH);

  referenceImg = new Sprite(width - width/10 - imgW/2, height/50 + imgH/2, imgW, imgH);

  mouse = new Mouse();

  calcButton = new Button(width/2, height - height/6, 100, 40, color(255, 255, 255), "Calculate");
  viewSimilarityButton = new Button(width/2, height - height/19, 140, 40, color(255, 255, 255), "ViewSimilarity");
  
  loadRenderImgButton = new Button(renderImg.pos.x+5, height - height/10, 200, 40, color(255, 255, 255), "Load Render Image");
  loadReferenceImgButton = new Button(referenceImg.pos.x+10, height - height/10, 200, 40, color(255, 255, 255), "Load Reference Image");

  cosList = new float[int(imgH)*int(imgW)];
  similarity = 0.0;
}

void update() {
  mouse.update();
  calcButton.update(mouse);
  viewSimilarityButton.update(mouse);
  loadRenderImgButton.update(mouse);
  loadReferenceImgButton.update(mouse);

  // ボタンが押されたら
  if (calcButton.isClicked()) {
    onClickCalcButton();
  }
  if(viewSimilarityButton.isClicked()){
    onClickViewSimilarityButton();
  }
  if (loadRenderImgButton.isClicked()) {
    onClickRenderImgButton();
  }
  if (loadReferenceImgButton.isClicked()) {
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
  text("Similarity: "+similarity, calcButton.pos.x, calcButton.pos.y - textSize*2);

  // ボタン表示
  calcButton.display();
  viewSimilarityButton.display();
  loadRenderImgButton.display();
  loadReferenceImgButton.display();
}

void onClickCalcButton() {
  // nullチェック
  if (renderImg.img == null || referenceImg.img == null) {
    return;
  }
  // コサイン類似度を計算
  calcCosineSimilarity();
}

void calcCosineSimilarity() {
  // 前回の計算結果が格納されている場合があるので類似度を初期化
  similarity = 0;

  for (int h = 0; h < imgH; h++) {
    for (int w = 0; w < imgW; w++) {
      color renderCol = renderImg.getPixel(w, h);
      color referenceCol = referenceImg.getPixel(w, h);
        
      // 0～1に正規化
      PVector vec1 = new PVector(red(renderCol)/255, green(renderCol)/255, blue(renderCol)/255);
      PVector vec2 = new PVector(red(referenceCol)/255, green(referenceCol)/255, blue(referenceCol)/255);
      // 単位ベクトル化
      vec1.normalize();
      vec2.normalize();
      
      float cos = PVector.dot(vec1,vec2);
      
      cosList[int(imgW) * h + w] = cos;
      similarity += cos;
    }
  }
  // 平均値を類似度とする
  similarity /= (imgW * imgH);
}

void onClickViewSimilarityButton() {
    // nullチェック
  if (renderImg.img == null || referenceImg.img == null) {
    return;
  }
  
  for (int y = 0; y < imgH; y++) {
    for (int x = 0; x < imgW; x++) {
      int similarityCol = int(cosList[int(imgW) * y + x] * 255.0);
      colorMode(RGB,255);
      color col;
      if(similarityCol < 255 * 0.9){
        similarityCol = 0;
      }else{
        similarityCol = 255;
      }
      col = color(similarityCol);
      renderImg.setPixel(x,y,col);
    }
  }
}

void onClickRenderImgButton() {
  selectInput("Select a render image file", "loadRenderImage");
}
// レンダー画像読み込みのコールバック
void loadRenderImage(File selection) {
  if (selection == null) {
    println("canceled");
  } else {
    println("User selected:" + selection.getAbsolutePath());
    renderImg.loadImg(selection.getAbsolutePath());
  }
}

void onClickReferenceImgButton() {
  selectInput("Select a reference image file", "loadReferenceImage");
}
// リファレンス画像読み込みのコールバック
void loadReferenceImage(File selection) {
  if (selection == null) {
    println("canceled");
  } else {
    println("User selected:" + selection.getAbsolutePath());
    referenceImg.loadImg(selection.getAbsolutePath());
  }
}
