// Mouseの入力を管理するクラス

class Mouse {
  boolean isUp;
  boolean isDown;
  boolean previousState;
  
  Mouse(){
    isUp = false;
    isDown = false;
    previousState = false;
  }
  
  void update(){
    // 押された瞬間
    if(!previousState && mousePressed){
        isDown = true;
        previousState = true;
    }
    // 離された瞬間
    else if(previousState && !mousePressed){
      isUp = true;
      previousState = false;
    }
    else {
      isUp = false;
      isDown = false;
      previousState = mousePressed;
    }
  }
}
