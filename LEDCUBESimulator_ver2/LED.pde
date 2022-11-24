//仮想的なLEDCUBEのLED部分のデータを管理するクラス，位置やHighLowの判定値，また描画をする

class LED{
  PVector location_ground; //led-cubeの基準点
  PVector location; //LED単体の位置
  String _isHigh; //high...1,low...0
  float space;
  
  LED(float x,float y,float z,float setx,float sety,float setz,float space){
    location = new PVector(x,y,z);
    location_ground = new PVector(setx,sety,setz);
    _isHigh = "0";
    this.space = space;
  }
  
  void display(){
    pushMatrix();
    blendMode(ADD);
    noFill();
    if(_isHigh == "1"){ //もしHighの場合，fillデータを青に変更する
      fill(100,100,240,100);
    }
    stroke(255,20);
    translate(location_ground.x,location_ground.y,location_ground.z);
    translate(location.x,location.y,location.z);
    box(space);
    blendMode(NORMAL);
    popMatrix();
  }
}
