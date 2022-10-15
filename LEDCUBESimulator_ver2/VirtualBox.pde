//このクラスに保管された125個のLEDがHighになっているかどうか判定したり，フレームごとにピンのデータを返すクラス

class VirtualBox{
  LED[][][] leds; //LEDオブジェクト125個を用意　
  PVector location_ground;　//led-cube基準点
  float space;
  
  VirtualBox(float setx,float sety,float setz,float space){
    leds = new LED[5][5][5];
    location_ground = new PVector(setx,sety,setz);
    this.space = space;
    
    //LEDに基準点と座標と間隔
    for(int x=0; x<5; x++){
      for(int y=0; y<5; y++){
        for(int z=0; z<5; z++){
          leds[x][y][z] = new LED(float(x)*space,float(y)*space,float(z)*space,setx,sety,setz,space);
        }
      }
    }
  }
  
  void run(){
    display(); 
    update();
  }
  
  void update(){
    //LEDの初期化
    for(int x=0; x<5; x++){
      for(int y=0; y<5; y++){
        for(int z=0; z<5; z++){
          leds[x][y][z]._isHigh = "0";
        }
      }
    }
  }
  
  void display(){
    for(int x=0; x<5; x++){
      for(int y=0; y<5; y++){
        for(int z=0; z<5; z++){
          leds[x][y][z].display();
        }
      }
    }
  }
  
  //LEDがHighになっている要素を探索
  void search(PVector target1){
    PVector target2 = PVector.sub(target1,location_ground);
    //println(target2);
    
    SEARCH: for(int x=0; x<5; x++){
      for(int y=0; y<5; y++){
        for(int z=0; z<5; z++){
          if(target2.x>=x*space && target2.x<x*space+space && target2.y >= y*space && target2.y < y*space+space && target2.z >= z*space && target2.z < z*space+space){
            leds[x][y][z]._isHigh = "1";
            
            break SEARCH;
          }
        }
      }
    }
  }
  
  //ピンデータの文字列生成
  void dataPin(String[][] bitdata){   
    for(int y=0; y<5; y++){
      for(int z=0; z<5; z++){
        for(int x=0; x<5; x++){
          bitdata[z][y] = bitdata[z][y] + leds[x][y][z]._isHigh; //lowの場合0,highの場合1を連結する
        }
      }
    }
  }
}
