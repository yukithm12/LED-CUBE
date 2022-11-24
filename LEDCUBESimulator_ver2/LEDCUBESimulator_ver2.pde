//runメゾット...クラスの更新&描画,updateメゾット...更新,displayメゾット...描画
import processing.sound.*;
import java.util.TimerTask;
import java.util.Timer;
import java.text.SimpleDateFormat;
import java.util.Date;

VirtualBox vb; //仮想のキューブをセットするオブジェクト

//アニメーションクラス
Ball b; //反射ボールオブジェクト
ForceMode fm; //物理エンジンオブジェクト
LifeGame lg; //ライフゲームオブジェクト

AudioIn in;
Amplitude amp;

PVector location_ledbox; //仮想キューブの基準値
float space; //LED間の間隔
boolean _isOn;

String bitdata[][]; //ビットデータ格納

int animation_num;
int an5_state;

String ag_m;

float an5_time;

SimpleDateFormat sdFormat = null;
Timer timer = null;
boolean runninngTimer = false;
int count = 0;

OtherRun otherRun;

void setup(){
  size(640,480,P3D);
  frameRate(60);
  
  in = new AudioIn(this);
  in.start();
  
  amp = new Amplitude(this);
  amp.input(in);
  
  timer = new Timer();
 
  otherRun = new OtherRun();
  timer.schedule( otherRun, 1000, 5000 );
  runninngTimer = true;
  
  space = 50;
  _isOn = false;
  location_ledbox = new PVector(width/2-space*4/2,height/2-space*4/2,-space*5/2); 
  bitdata = new String[5][5];

  b = new Ball(location_ledbox,location_ledbox.x+space*5,location_ledbox.y+space*5,location_ledbox.z+space*5);
  vb = new VirtualBox(location_ledbox.x,location_ledbox.y,location_ledbox.z,space);
  fm = new ForceMode(location_ledbox,space);
  lg = new LifeGame(0);
  animation_num = 0;
  an5_state=0;
  an5_time=0;
}

void draw(){
  background(0);
  
  animation_run();
  
  //ピンデータ更新
  vb.dataPin(bitdata);

  //VirtualboxのLEDの値を更新と光らせる描写
  vb.run();
}

void lifegame_update(){
  //10フレームに一回更新
  if(frameCount%10==0){
    lg.lifeGame();
  }
  
  //Lifegameで呼び出した配列要素の_isHighに"1"を格納
  vb.leds[lg.array_point[0][0]][lg.array_point[0][1]][lg.array_point[0][2]]._isHigh = "1";
  vb.leds[lg.array_point[1][0]][lg.array_point[1][1]][lg.array_point[1][2]]._isHigh = "1";
  vb.leds[lg.array_point[2][0]][lg.array_point[2][1]][lg.array_point[2][2]]._isHigh = "1";
}

void lifegame_update_small(){
  //10フレームに一回更新
  if(frameCount%8==0){
    lg.lifeGame_small();
  }
  
  //Lifegameで呼び出した配列要素の_isHighに"1"を格納
  vb.leds[lg.array_point[0][0]][lg.array_point[0][1]][lg.array_point[0][2]]._isHigh = "1";
  vb.leds[lg.array_point[1][0]][lg.array_point[1][1]][lg.array_point[1][2]]._isHigh = "1";
  vb.leds[lg.array_point[2][0]][lg.array_point[2][1]][lg.array_point[2][2]]._isHigh = "1";
}

void keyPressed(){
  if(key=='a'){
    animation_num=0;
    b = new Ball(location_ledbox,location_ledbox.x+space*5,location_ledbox.y+space*5,location_ledbox.z+space*5);
  }
  else if(key=='b'){
    fm = new ForceMode(location_ledbox,space);
    animation_num=1;
  }
  else if(key=='c'){
    lg = new LifeGame(0);
    animation_num=2;
  }
  else if(key=='d'){
    ag_m = null;
    fm = new ForceMode(location_ledbox,space);
    animation_num=3;
  }
  else if(key=='e'){
    fm = new ForceMode(location_ledbox,space);
    animation_num=4;
  }
  else if(key=='f'){
    an5_state=0;
    an5_time=0;
    lg = new LifeGame(1);
    fm = new ForceMode(location_ledbox,space);
    animation_num=5;
  }
}

void animation_run(){
  //ビットデータ初期化
  for(int i=0; i<5; i++){
    for(int j=0; j<5; j++){
      bitdata[i][j] = "00000"; 
    }
  }

  if(animation_num==0){
    //反射ボール
    b.run();
    vb.search(b.location);
  }

  else if(animation_num==1){
    //噴水みたいなアニメーション
    if(frameCount%70==0){
      fm.add_parabola();
    }
    fm.run();
    for(int i=0; i<fm.particles.size(); i++){
      vb.search(fm.particles.get(i).location);
    }
  }

  else if(animation_num==2){
    //ライフゲーム
    lifegame_update();
  }

  else if(animation_num==3){
    if(ag_m=="CONTINUE" || ag_m==null){
      ag_m = fm.antiGravity();
      fm.run();
      for(int i=0; i<fm.particles.size(); i++){
        vb.search(fm.particles.get(i).location);
      }
    }
    else if(ag_m=="FINISH"){
      overflow();

      fm.ag_p=-1;
    }
  }

  else if(animation_num==4){
    fm.rain();
    fm.run();
    for(int i=0; i<fm.particles.size(); i++){
      vb.search(fm.particles.get(i).location);
    }
  }
  
  else if(animation_num==5){
    
    if(an5_state==0){
      lifegame_update_small();
    }
    else if(an5_state==1){
      fm.antiforce();
      fm.run();
      for(int i=0; i<fm.particles.size(); i++){
        vb.search(fm.particles.get(i).location);
      }
      
      if(an5_time>450){
        an5_state=2;
      }
      
      an5_time++;
    }
    else if(an5_state==2){
      
    }
  }
  
  else if(animation_num==6){
    
  }
}

void pin_debug(){
  println(frameCount + "frame");
  for(int i=0; i<5; i++){
    println(bitdata[0][i]);
    println(bitdata[1][i]);
    println(bitdata[2][i]);
    println(bitdata[3][i]);
    println(bitdata[4][i]);
    println();
  }
  println("******************");
}

void overflow(){
  if(frameCount%10==0){
    if(_isOn==false){
      for(int x=0; x<5; x++){
        for(int y=0; y<5; y++){
          for(int z=0; z<5; z++){
            vb.leds[x][y][z]._isHigh = "1";
          }
        }
      }

      _isOn=true;
    }
    else if(_isOn==true){
      for(int x=0; x<5; x++){
        for(int y=0; y<5; y++){
          for(int z=0; z<5; z++){
            vb.leds[x][y][z]._isHigh = "0";
          }
        }
      }

      _isOn=false;
    }
  }

  if(_isOn==true){
      for(int x=0; x<5; x++){
        for(int y=0; y<5; y++){
          for(int z=0; z<5; z++){
            vb.leds[x][y][z]._isHigh = "1";
          }
        }
      }
    }
    else if(_isOn==false){
      for(int x=0; x<5; x++){
        for(int y=0; y<5; y++){
          for(int z=0; z<5; z++){
            vb.leds[x][y][z]._isHigh = "0";
          }
        }
      }
    }
}

class OtherRun extends TimerTask {
  @Override
  public void run() {
    //回数と現在時刻を表示
    if(animation_num==5 && an5_state==0){
      float a = amp.analyze()*200;
      if(a>30){
      an5_state=1;
      }
      println(a);
    }
}
}
