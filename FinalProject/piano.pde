import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;

void setup()
{
  size(512, 200, P3D);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
}
 
void draw()
{
  background(192, 57, 43);
  stroke(235);
  strokeWeight(3);
  text("To play, press from the letter 'A' to ';' on the keyboard.", 100, 100);
  
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
}
 
void keyPressed(){
  SineWave mySine;
  MyNote newNote;

  float pitch = 0;
  switch(key) {
    case 'a': pitch = 466; break; //A
    case 's': pitch = 494; break; //B
    case 'd': pitch = 523; break; //C
    case 'f': pitch = 587; break; //D
    case 'g': pitch = 659; break; //E
    case 'h': pitch = 698; break; //F
    case 'j': pitch = 784; break; //G
    case 'k': pitch = 880; break; //A
    case 'l': pitch = 988; break; //B
    case ';': pitch = 1050; break; //C
    }
  
   if (pitch > 0) {
      newNote = new MyNote(pitch, 0.2);
   }
}

void stop(){
  out.close();
  minim.stop();
  super.stop();
}

class MyNote implements AudioSignal{
     private float freq;
     private float level;
     private float alph;
     private SineWave sine;
     
     MyNote(float pitch, float amplitude){
         freq = pitch;
         level = amplitude;
         sine = new SineWave(freq, level, out.sampleRate());
         alph = 0.9;
         out.addSignal(this);
     }

     void updateLevel(){
         level = level * alph;
         sine.setAmp(level);
         
         if (level < 0.01) {
             out.removeSignal(this);
         }
     }
     
     void generate(float [] samp){
         sine.generate(samp);
         updateLevel();
     }
     
    void generate(float [] sampL, float [] sampR){
        sine.generate(sampL, sampR);
        updateLevel();
    }

}
