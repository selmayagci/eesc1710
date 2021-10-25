void setup(){
  size(500, 500);
  noStroke();
  
  
  for(int i = 0; i < 10; i++){
    foods.add(new food(50 * i + 25, 25));
  }
    for(int k = 0; k < 10; k++){
      for(int i = 0; i < 10; i++){
      foods.add(new food(50 * i + 25, 50 * k + 25));
    }
  }
 }

ArrayList<food> foods = new ArrayList<food>();

int aci = 45;
int yon = -1;
int x = 25, y = 25;
int agizAcisi = 0;

void eatFood(){
  for(int i = 0; i < foods.size(); i++){
    if(x < foods.get(i).x + 10 && x > foods.get(i).x - 10 
    && y < foods.get(i).y + 10 && y > foods.get(i).y - 10 )
    {    
      foods.remove(i);
      break;
    }
  }
}

void draw(){
  
  background(0);
  drawFoods();
  drawPacman();
  eatFood();
  
    
    
   // if(keyPressed)
   {
      if(keyCode == RIGHT){
        x++;
        agizAcisi = 0;
      }
      else if(keyCode == LEFT){
        x--;
        agizAcisi = 180;
      }
      else if(keyCode == DOWN){
        y++;
        agizAcisi = 90;
      }
      else if(keyCode == UP){
        y--;
        agizAcisi = 270;
      }
    }
    
    if(x < 25) x = 25;
    if(x > width - 25) x = width - 25;
    if(y < 25) y = 25;
    if(y > height - 25) y = height - 25;
}

void drawFoods(){
  for(int i = 0; i < foods.size(); i++){
    foods.get(i).drawFood();
  }
  
}


void drawPacman(){
  fill(255, 255, 0);
  
  pushMatrix();
  translate(x, y);
  rotate(radians(agizAcisi));
  translate(-x, -y);
  arc(x, y, 50, 50, radians(aci), radians(360-aci));
  popMatrix();
  
  
  aci+= yon;
  
  if(aci == 45 || aci == 0)
    yon *= -1;
}
