int circleSize;
float circlePosX, circlePosY, circleX, circleY;
int good;
int goodX;
int headshot;
float accuracy;
int nbClique;
color red;
color background;
color currentColor;
color green;
boolean circleOver = false;
boolean squareOver = false;
int health;
int damage;
int damageDeal;
int kill;
int bullet;
color yellow, blue, white, gray;
PFont light, bold, light10, bold10;
int choice;
boolean head = false;
boolean shield = false;
float damageX, damageY, damagePosX, damagePosY, damageSize;
boolean damageReset = false;

void setup() {
  fullScreen();
  light = loadFont("ArialMT-20.vlw");
  bold = loadFont("Arial-BoldMT-20.vlw");
  light10 = loadFont("ArialMT-10.vlw");
  bold10 = loadFont("Arial-BoldMT-10.vlw");
  textFont(light);
  good =0;
  nbClique = 0;
  red = color(203, 67, 53);
  background = color(17, 122, 101);
  green = color(34, 153, 84);
  yellow = color( 212, 172, 13);
  blue = color(52, 152, 219);
  white = color(236, 240, 241);
  gray = color( 46, 64, 83);
  currentColor = red;
  bullet = 100;
  damageSize = 40;
  circle();
  scoreboard();
}

void draw() {
  update(mouseX, mouseY);
  cursor(CROSS);
  background(background);
  circleDraw();
  scoreboard();
}

void update(float x, float y) {
  if (health <= 0) {
    kill = kill + 1;
    //delay,play dead animation, circle
    circle();
  }
}

void damage(){
  damageX = int(random(mouseX - 10, mouseX + 10));
  damageY = int(random(mouseY - 10, mouseY + 10));
  damagePosX = random(-3, 3);
  damagePosY = random(-3, 3);
}

void damageDraw(){
  textFont(bold);
  textSize(damageSize);
  fill(0);
  textAlign(CENTER, CENTER);
  if (damage <= 0) {
    fill(0);
    text(" ", damageX, damageY);
    damageSize = 40;
  }
  if (damage > 0 && shield == false && head == false) {
    fill(white);
    text(damage, damageX, damageY);
  }
  if (damage > 0 && shield == true) {
    fill(blue);
    text(damage, damageX, damageY);
  }
  if (damage > 0 && head == true) {
    fill(yellow);
    text(damage, damageX, damageY);
  }
  textFont(light);
}

void circle() {
  health = 100;
  circleX = int(random(100, width - 100));
  circleY = int(random(100, height - 100));
  circlePosX = random(-5, 5);
  circlePosY = random(-5, 5);
  circleSize = int(random(10, 30));
}

void circleDraw() {
  isOverCircle();
  isOverSquare();
  smooth();
  ellipseMode(CENTER);
  rectMode(CENTER);

  if (circleOver || squareOver) {
    currentColor = green;
  } else {
    currentColor = red;
  }

  fill(currentColor);
  circleX = circleX + circlePosX;
  circleY = circleY + circlePosY;

  if (circleX + 50 > width) {
    circlePosX = circlePosX * -1;
  }
  if (circleX - 50 < 0) {
    circlePosX = circlePosX * -1;
  }
  if (circleY + circleSize * 2> height) {
    circlePosY = circlePosY * -1;
  }
  if (circleY - circleSize / 2 < 0) {
    circlePosY = circlePosY * -1;
  }
  rect(circleX, circleY + circleSize, circleSize + circleSize / 2, circleSize + circleSize / 2, circleSize / 4);
  ellipse(circleX, circleY, circleSize, circleSize);
  health(0);
}

void health(int damage) {
  health = health - damage;
  fill(gray);
  textFont(bold10);
  textAlign(LEFT, CENTER);
  rectMode(CORNER);
  if (circleY - (circleSize + circleSize / 2) - 20 <= 0 && health > 0) {
    rect(circleX - 50, circleY + circleSize + circleSize + circleSize / 2 + 25, 100, 10);
    fill(green);
    rect(circleX - 50, circleY + circleSize + circleSize + circleSize / 2 + 25, health, 10);
    fill(white);
    text(health + " | 100", circleX - 45, circleY + circleSize + circleSize + circleSize / 2 + 30);
  }
  if (!(circleY - (circleSize + circleSize / 2) - 20 <= 0) && health > 0) {
    rect(circleX - 50, circleY - (circleSize + circleSize / 2) - 5, 100, 10);
    fill(green);
    rect(circleX - 50, circleY - (circleSize + circleSize / 2) - 5, health, 10);
    fill(white);
    text(health + " | 100", circleX - 45, circleY - (circleSize + circleSize / 2));
  }
  textFont(light);
}

void scoreboard() {
  textSize(20);

  if (accuracy / 100 >= 30) {
    fill(green);
  } else {
    fill(red);
  }

  int goodX = good * 10000;

  if (nbClique != 0) {
    accuracy = (goodX / nbClique);
  } else {
    accuracy = 0;
  }

  text("Accuracy: " + accuracy / 100 + "%", 10, 20);
  text("Damage deals in total: " + damageDeal, 10, 40);
  text("Kill: " + kill, 10, 60);
  text("Headshot: " + headshot, 10, 80);
  text("Good shots: " + good, 10, 100);
  //text("Shots fired: " + nbClique, 10 , 120);
  text("Remaining bullets: " + bullet, 10, 120);
  damageDraw();
  damageX = damageX + damagePosX;
  damageY = damageY + damagePosY;
  damageSize = damageSize - 0.3;
  if (damageSize <= 0){
    damage = 0;
  }
}

void isOverCircle() {
  if ((mouseX >= circleX - circleSize / 2 && mouseX <= circleX + circleSize /2) && (mouseY >= circleY - circleSize / 2 && mouseY <= circleY + circleSize /2)) {
    circleOver = true;
  } else {
    circleOver = false;
  }
}

void isOverSquare() {
  if ((mouseX >= circleX - (circleSize /2 + circleSize / 2 / 2) && mouseX <= circleX + (circleSize / 2 + circleSize / 2 / 2)) && (mouseY >= circleY  + circleSize - (circleSize + circleSize / 2) / 2 && mouseY <= circleY + circleSize + (circleSize + circleSize / 2) / 2)) {
    squareOver = true;
  } else {
    squareOver = false;
  }
}

void mousePressed() {
  if (circleOver && health > 0) {
    bullet = bullet - 1;
    nbClique = nbClique + 1;
    good = good + 1;
    headshot = headshot + 1;
    head = true;
    if (circleSize <= 30 && circleSize >= 17) {
      choice = int(random(1, 3));
      if (choice == 1) {
        damage = 30;
      }
      if (choice == 2) {
        damage = 32;
      }
      if (choice == 3) {
        damage = 45;
      }
    }
    if (circleSize <= 16 && circleSize >= 10) {
      choice = int(random(1, 3));
      if (choice == 1) {
        damage = 70;
      }
      if (choice == 2) {
        damage = 78;
      }
      if (choice == 3) {
        damage = 92;
      }
    }
    damageDeal = damageDeal + damage;
    health(damage);
    damageSize = 40;
    damage();
  }
  if (squareOver && circleOver == false && health > 0) {
    bullet = bullet - 1;
    nbClique = nbClique + 1;
    good = good + 1;
    head = false;
    if (health > 100){
      shield = true;
    }
    else{
      shield = false;
    }
    if (circleSize <= 30 && circleSize >= 24) {
      choice = int(random(1, 3));
      if (choice == 1) {
        damage = 8;
      }
      if (choice == 2) {
        damage = 16;
      }
      if (choice == 3) {
        damage = 24;
      }
    }
    if (circleSize <= 23 && circleSize >= 17) {
      choice = int(random(1, 3));
      if (choice == 1) {
        damage = 30;
      }
      if (choice == 2) {
        damage = 32;
      }
      if (choice == 3) {
        damage = 45;
      }
    }
    if (circleSize <= 16 && circleSize >= 10) {
      choice = int(random(1, 3));
      if (choice == 1) {
        damage = 70;
      }
      if (choice == 2) {
        damage = 78;
      }
      if (choice == 3) {
        damage = 92;
      }
    }
    damageDeal = damageDeal + damage;
    health(damage);
    damageSize = 40;
    damage();
  }
  if (circleOver == false && squareOver == false) {
    damage = 0;
    damageSize = 40;
    bullet = bullet - 1;
    nbClique = nbClique + 1;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == ESC) {
      exit();
    }
  }
}
