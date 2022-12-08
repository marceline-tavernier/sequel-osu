
// Variables
int enemyPosX, enemyPosY, enemySpeedX, enemySpeedY, enemySize;
int damagePosX, damagePosY, damageSpeedX, damageSpeedY, damageSize;
int goodShot, headshot, nbClick, bullet, damageDone, kill;
float accuracy;
color red, green, yellow, blue, white, gray, background, currentColor;
int health, damage;
PFont light, bold, light10, bold10;
boolean mouseOverEnemy, overHead, headDamage;

///////////////////////////////////////////////////////////////////////////////////////////

// Setup :
void setup() {

  // Put the game screen size to 1280x640
  size(1280, 640);
  surface.setTitle("Sequel of Osu");

  // Load the 4 fonts used
  light = loadFont("ArialMT-20.vlw");
  bold = loadFont("Arial-BoldMT-20.vlw");
  light10 = loadFont("ArialMT-10.vlw");
  bold10 = loadFont("Arial-BoldMT-10.vlw");

  //Put the font to the light Arial (size 20)
  textFont(light);

  // Setup variables
  goodShot = 0;
  nbClick = 0;
  bullet = 100;
  damageSize = 40;

  // Setup colors
  red = color(203, 67, 53);
  green = color(34, 153, 84);
  yellow = color( 212, 172, 13);
  blue = color(52, 152, 219);
  white = color(236, 240, 241);
  gray = color( 46, 64, 83);
  background = color(46, 50, 50);
  currentColor = red;

  // Setup the enemy
  enemySetup();

  // Draw the scoreboard
  scoreboard();
}

// Setup the enemy
void enemySetup() {

  // Puts health to 100
  health = 100;

  // Setup a random position, speed and size
  enemyPosX = int(random(100, width - 100));
  enemyPosY = int(random(100, height - 100));
  enemySpeedX = int(random(-5, 5));
  enemySpeedY = int(random(-5, 5));
  enemySize = int(random(10, 30));
}

// Draw the scoreboard
void scoreboard() {

  // Set text size to 20
  textSize(20);

  // Set text color to green if the accuracy is above 30%, red otherwise
  if (accuracy / 100 >= 30) {
    fill(green);
  } else {
    fill(red);
  }

  // Calculate accuracy
  if (nbClick != 0) {
    accuracy = (goodShot * 10000 / nbClick);
  } else {
    accuracy = 0;
  }

  // Draw the scoreboard's text
  text("Accuracy: " + accuracy / 100 + "%", 10, 20);
  text("Damage done in total: " + damageDone, 10, 40);
  text("Kill: " + kill, 10, 60);
  text("Headshot: " + headshot, 10, 80);
  text("goodShotshots: " + goodShot, 10, 100);
  text("Remaining bullets: " + bullet, 10, 120);

  // Draw the damage
  damageDraw();

  // Move slowly the damage text position
  damagePosX += damageSpeedX;
  damagePosY += damageSpeedY;

  // Lower the damage text size slowly
  damageSize -= 0.3;

  // If the damage text size is 0 or below, reset damage
  if (damageSize <= 0) {
    damage = 0;
  }
}

// Draw the damage
void damageDraw() {

  // Puts text in bold, to the correct size, white and centered
  textFont(bold);
  if (damageSize > 0) {
    textSize(damageSize);
  }
  color fillColor = white;
  textAlign(CENTER, CENTER);

  // If it hits the head, puts text color to yellow
  if (headDamage == true) {
    fillColor = yellow ;
  }

  // If it hits the enemy, draw the dammage text with the right color and correct position
  if (damage > 0) {
    fill(fillColor);
    text(damage, damagePosX, damagePosY);
  }

  //Puts text font back to light
  textFont(light);
}

// Draw everything
void draw() {

  // Calls update()
  update();

  // Puts the cursor to a cross
  cursor(CROSS);

  // Draw the background
  background(background);

  // Draw the enemy
  enemyDraw();

  // Draw the scoreboard
  scoreboard();
}

// Update the game
void update() {

  // Spawn a new Enemy if it's dead
  if (health <= 0) {
    kill++;
    enemySetup();
  }
}

// Draw the enemy
void enemyDraw() {

  // Enemy draw parameters
  smooth();
  ellipseMode(CENTER);
  rectMode(CENTER);

  // If the mouse is over the enemy, change coler to green, red otherwise
  if (isOverEnemy()) {
    fill(green);
  } else {
    fill(red);
  }

  // Move the enemy
  enemyPosX += enemySpeedX;
  enemyPosY += enemySpeedY;

  // Make it bounce on the edge
  if (enemyPosX + 50 > width || enemyPosX - 50 < 0) {
    enemySpeedX *= -1;
  }
  if (enemyPosY + enemySize * 2> height || enemyPosY - enemySize / 2 < 0) {
    enemySpeedY *= -1;
  }

  // Draw the enemy
  rect(enemyPosX, enemyPosY + enemySize, enemySize + enemySize / 2, enemySize + enemySize / 2, enemySize / 4);
  ellipse(enemyPosX, enemyPosY, enemySize, enemySize);

  // Setups health bar
  health(0);
}

// Is the mouse over the enemy
boolean isOverEnemy() {

  // If the mouse is over the head, return true
  if ((mouseX >= enemyPosX - enemySize / 2 && mouseX <= enemyPosX + enemySize /2) && (mouseY >= enemyPosY - enemySize / 2 && mouseY <= enemyPosY + enemySize /2)) {

    // Puts overHead and mouseOverEnemy to true and return true
    overHead = true;
    mouseOverEnemy = true;
    return true;
  }

  // If the mouse is over the body, return true
  if ((mouseX >= enemyPosX - (enemySize /2 + enemySize / 2 / 2) && mouseX <= enemyPosX + (enemySize / 2 + enemySize / 2 / 2)) && (mouseY >= enemyPosY  + enemySize - (enemySize + enemySize / 2) / 2 && mouseY <= enemyPosY + enemySize + (enemySize + enemySize / 2) / 2)) {

    // Puts overHead to false and mouseOverEnemy to true, return true
    overHead = false;
    mouseOverEnemy = true;
    return true;
  }

  // Else puts overHead and mouseOverEnemy to false and return false
  overHead = false;
  mouseOverEnemy = false;

  return false;
}


void health(int damage) {

  // Substract the damage from the health
  health -= damage;

  // Puts text to gray, bold and align left
  fill(gray);
  textFont(bold10);
  textAlign(LEFT, CENTER);
  rectMode(CORNER);

  // If there is room to display health over the enemy, and it has health
  if (enemyPosY - (enemySize + enemySize / 2) - 20 <= 0 && health > 0) {

    // Draw the background of the health bar
    rect(enemyPosX - 50, enemyPosY + enemySize + enemySize + enemySize / 2 + 25, 100, 10);

    //Draw the health in green
    fill(green);
    rect(enemyPosX - 50, enemyPosY + enemySize + enemySize + enemySize / 2 + 25, health, 10);

    //Draw text in white
    fill(white);
    text(health + " | 100", enemyPosX - 45, enemyPosY + enemySize + enemySize + enemySize / 2 + 30);
  }

  // Else, display it below
  else if (health > 0) {

    // Draw the background of the health bar
    rect(enemyPosX - 50, enemyPosY - (enemySize + enemySize / 2) - 5, 100, 10);

    //Draw the health in green
    fill(green);
    rect(enemyPosX - 50, enemyPosY - (enemySize + enemySize / 2) - 5, health, 10);

    //Draw text in white
    fill(white);
    text(health + " | 100", enemyPosX - 45, enemyPosY - (enemySize + enemySize / 2));
  }

  // Change back to the light font
  textFont(light);
}

// Stuff to do when the mouse is pressed
void mousePressed() {

  if (bullet > 0) {

    // Make a random choice for the damage
    int choice = int(random(1, 3));

    // Lists of damage
    int damageListLow[] = {8, 16, 24};
    int damageListModerate[] = {30, 32, 45};
    int damageListHight[] = {70, 78, 92};

    //Sets the damage to 0
    damage = 0;

    // If the mouse is over the head and the enemy still has health
    if (overHead && health > 0) {

      // Add to the headshot count and a goodshot and change headDmage to true
      headshot += 1;
      goodShot += 1;
      headDamage = true;

      // If size is between 30 and 17, deal moderate damage
      if (enemySize <= 30 && enemySize >= 17) {
        damage = damageListModerate[choice];
      }

      // If size is between 16 and 10, deal hight damage
      else if (enemySize <= 16 && enemySize >= 10) {
        damage = damageListHight[choice];
      }
    }

    // If the mouse is over the enemy body and it still has health
    else if (mouseOverEnemy && overHead == false && health > 0) {

      // Add to the goodShot count and change headDamage to false
      goodShot += 1;
      headDamage = false;

      // If the size is betwwen 30 and 24, deal low damage
      if (enemySize <= 30 && enemySize >= 24) {
        damage = damageListLow[choice];
      }

      // If the size is betwwen 23 and 17, deal moderate damage
      else if (enemySize <= 23 && enemySize >= 17) {
        damage = damageListModerate[choice];
      }

      // If the size is betwwen 16 and 10, deal hight damage
      else if (enemySize <= 16 && enemySize >= 10) {
        damage = damageListHight[choice];
      }
    }

    // Remove a bullet and add a click, and reset the damageSize
    bullet -= 1;
    nbClick += 1;
    damageSize = 40;

    // Add the damage to damageDone
    damageDone += damage;

    // Change health and draw the healthbar
    health(damage);

    // Change the damage position and speed
    damage();
  }
}

// Sets a random damage text position and speed
void damage() {

  // Sets a random position to the damage text
  damagePosX = int(random(mouseX - 10, mouseX + 10));
  damagePosY = int(random(mouseY - 10, mouseY + 10));

  // Setes a random speed to the damage text
  damageSpeedX = int(random(-3, 3));
  damageSpeedY = int(random(-3, 3));
}

// If escape is pressed, exit
void keyPressed() {

  // If R is pressed, reload gun
  if (key == 'r' || key == 'R') {
    bullet = 100;
  }
}
