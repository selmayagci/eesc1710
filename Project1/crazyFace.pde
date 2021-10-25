void setup()
{
size(500,500);
noFill();
strokeWeight(5);
}

int yuk = 100;
int aci = 30;
int yon= -1;
void draw()
{
background(125,240,240);
fill(230,245,140);
ellipse(250,240,360,420);
fill(240,229,220);
ellipse(160,180,80,yuk);

ellipse(340,180,80,yuk);
noFill();
arc(250,250,300,150, radians(aci),radians(180-aci));
line(188,437,180,500);
line(311,439,319,500);
if(keyPressed){
if(keyCode==UP)
yuk ++;
else if(keyCode==DOWN)
yuk--;
if(keyCode==LEFT)
aci ++;
else if(keyCode==RIGHT)
aci--;
}
println(mouseX + "," + mouseY);
if (mousePressed){
  
noFill();
arc(250,250,300,150, radians(0),radians(180));
fill(240,229,220);
ellipse(160,180,80,200);
}
}
