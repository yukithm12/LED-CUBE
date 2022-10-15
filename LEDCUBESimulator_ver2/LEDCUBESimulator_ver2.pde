//runメゾット...クラスの更新&描画,updateメゾット...更新,displayメゾット...描画

VirtualBox vb; //仮想のキューブをセットするオブジェクト

//アニメーションクラス
Ball b; //反射ボールオブジェクト
ForceMode fm; //物理エンジンオブジェクト
Lifegame lg; //ライフゲームオブジェクト

PVector location_ledbox; //仮想キューブの基準値
float space; //LED間の間隔

String bitdata[][]; //ビットデータ格納

void setup(){
  size(640,480,P3D);
  frameRate(60);
  
  space = 50;
  location_ledbox = new PVector(width/2-space*4/2,height/2-space*4/2,-space*5/2); 
  bitdata = new String[5][5];

  b = new Ball(location_ledbox,location_ledbox.x+space*5,location_ledbox.y+space*5,location_ledbox.z+space*5);
  vb = new VirtualBox(location_ledbox.x,location_ledbox.y,location_ledbox.z,space);
  fm = new ForceMode(location_ledbox,space);
  lg = new Lifegame();
}

void draw(){
  background(0);
  
  //ビットデータ初期化
  for(int i=0; i<5; i++){
    for(int j=0; j<5; j++){
      bitdata[i][j] = "00000"; 
    }
  }
  
  /************pattern1**************/
  //反射ボール
  /*b.run();
  vb.search(b.location);
  */
  /************pattern2**************/
  //噴水みたいなアニメーション
  /*if(frameCount%70==0){
    fm.addParticle();
  }
  fm.run();
  for(int i=0; i<fm.particles.size(); i++){
    vb.search(fm.particles.get(i).location);
  }*/
  /************pattern3**************/
  //ライフゲーム
  lifegame_update();
  
  /**********************************/
  
  //ピンデータ更新
  vb.dataPin(bitdata);
  
  //ピンのdebug用コード
  /*println(frameCount + "frame");
  for(int i=0; i<5; i++){
    println(bitdata[0][i]);
    println(bitdata[1][i]);
    println(bitdata[2][i]);
    println(bitdata[3][i]);
    println(bitdata[4][i]);
    println();
  }
  println("******************");*/
  
  //VirtualboxのLEDの値を更新と光らせる描写
  vb.run();
}

void lifegame_update(){
  //10フレームに一回更新
  if(frameCount%10==0){
    lg.update();
  }
  
  //Lifegameで呼び出した配列要素の_isHighに"1"を格納
  vb.leds[lg.array_point[0][0]][lg.array_point[0][1]][lg.array_point[0][2]]._isHigh = "1";
  vb.leds[lg.array_point[1][0]][lg.array_point[1][1]][lg.array_point[1][2]]._isHigh = "1";
  vb.leds[lg.array_point[2][0]][lg.array_point[2][1]][lg.array_point[2][2]]._isHigh = "1";
}
