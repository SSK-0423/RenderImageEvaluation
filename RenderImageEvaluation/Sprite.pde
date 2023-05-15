// 画像を表示するためのクラス
class Sprite {
  PVector pos;
  float w, h;

  PImage img;

  Sprite(float x, float y, float w_, float h_) {
    w = w_;
    h = h_;
    pos = new PVector(x, y);
    img = null;
  }

  void loadImg(String path) {
    img = loadImage(path);
    img.resize(int(w),int(h));
  }

  void display() {
    strokeWeight(5);
    noFill();
    rectMode(CENTER);
    rect(pos.x, pos.y, w+5, h+5);

    if (img == null) {
      return;
    }

    imageMode(CENTER);
    image(img, pos.x, pos.y, w, h);
  }

  color getPixel(int x, int y) {
    return img.get(x, y);
  }
  
  void setPixel(int x, int y, color col){
    img.set(x,y,col);
  }
}
