// ボタン
// 参考 https://tofgame.hatenablog.com/entry/2019/07/18/175359

class Button {
  PVector pos;
  float w, h;
  color col;
  String str;
  int state;

  float nb;
  float sb;
  float pb;

  Button(float x, float y, float w_, float h_, color col_, String str_) {
    pos = new PVector();
    pos.x = x;
    pos.y = y;
    w = w_;
    h = h_;
    col = col_;
    str = str_;
    state = 0;
    nb=1;   //normalBrightness
    sb=0.8; //selectBrightness
    pb=0.6; //pushBrightness
  }

  void update(Mouse mouse) {
    state = checkState(mouse);
  }

  void display() {
    changeColor();
    strokeWeight(2);
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
    
    textAlign(CENTER,CENTER);
    fill(0);
    textSize(20);
    text(str, pos.x, pos.y);
  }

  boolean checkInMouse() {
    if (mouseX > pos.x - w/2 && mouseX < pos.x + w/2) {
      if (mouseY > pos.y - h/2 && mouseY < pos.y + h/2) {
        return true;
      }
    }
    return false;
  }

  int checkState(Mouse mouse) {
    if (!checkInMouse()) return 0;
    if (!mouse.isUp) return 1;
    return 2;
  }

  boolean isClicked() {
    if (state == 2) return true;
    return false;
  }

  void changeColor() {
    colorMode(HSB, 255);
    switch(state) {
    case 0:
      fill(hue(col), saturation(col), brightness(col)*nb);
      break;

    case 1:
      fill(hue(col), saturation(col), brightness(col)*sb);
      break;

    case 2:
      fill(hue(col), saturation(col), brightness(col)*pb);
      break;

    default:
      fill(0, 0, 0);
      break;
    }
  }
}
