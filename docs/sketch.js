let asteroids = [];
let bullets = [];
let player;
let manager;
let keys = [false, false, false, false, false];

class GameManager {
  constructor() {
    this.bulletIndex = 0;
    for (let i = 0; i < 20; i++) {
      bullets.push(new Bullet());
    }
    for (let i = 0; i < 10; i++) {
      asteroids.push(new Asteroid(random(width), random(height), random(1), random(1), random(360)));
    }
    player = new Ship();
  }

  drawGame() {
    this.checkCollisions();
    fill(0, 50);
    rect(0, 0, width, height);
    fill(255);
    player.drawShip();
    for (let a of asteroids) {
      a.drawAsteroid();
    }
    for (let b of bullets) {
      b.drawBullet();
    }
  }

  checkCollisions() {
    for (let i = asteroids.length - 1; i >= 0; i--) {
      let testHolder = asteroids[i];
      if (dist(testHolder.asteroidPosition.x, testHolder.asteroidPosition.y, player.shipPosition.x, player.shipPosition.y) < testHolder.asteroidSize) {
        player.destroyShip();
      }
      for (let j = 0; j < bullets.length; j++) {
        let bulletHolder = bullets[j];
        if (bulletHolder.bulletHidden) continue;
        if (dist(testHolder.asteroidPosition.x, testHolder.asteroidPosition.y, bulletHolder.bulletPosition.x, bulletHolder.bulletPosition.y) < testHolder.asteroidSize) {
          testHolder.split();
          bulletHolder.bulletHidden = true;
          j++;
        }
      }
    }
  }

  fireBullet(pos, spe, dir) {
    bullets[this.bulletIndex].reset(pos, spe, dir);
    this.bulletIndex++;
    this.bulletIndex %= bullets.length;
  }
}

class Asteroid {
  constructor(px, py, vx, vy, inD, s) {
    this.asteroidVelocity = createVector(vx, vy);
    this.asteroidPosition = createVector(px, py);
    this.asteroidDirection = inD;
    this.asteroidSize = s !== undefined ? random(s / 3, s / 1.5) : random(15, 30);
    this.numAnchors = 6;
    this.rotAngle = 0;
    this.anchorsX = new Array(this.numAnchors);
    this.anchorsY = new Array(this.numAnchors);
  }

  drawAsteroid() {
    this.updateAsteroid();
    push();
    noStroke();
    beginShape();
    for (let i = 0; i < this.numAnchors; i++) {
      curveVertex(this.anchorsX[i], this.anchorsY[i]);
    }
    for (let i = 0; i < this.numAnchors; i++) {
      curveVertex(this.anchorsX[i], this.anchorsY[i]);
    }
    endShape(CLOSE);
    pop();
  }

  updateAsteroid() {
    this.asteroidPosition.add(this.asteroidVelocity);
    this.asteroidPosition.x = (this.asteroidPosition.x + width) % width;
    this.asteroidPosition.y = (this.asteroidPosition.y + height) % height;
    this.rotAngle = 0;
    for (let i = 0; i < this.numAnchors; i++) {
      this.anchorsX[i] = this.asteroidPosition.x + cos(radians(this.rotAngle) + noise(this.asteroidPosition.x / 20 + i * 4)) * this.asteroidSize;
      this.anchorsY[i] = this.asteroidPosition.y + sin(radians(this.rotAngle) + noise(this.asteroidPosition.y / 20 + i * 4)) * this.asteroidSize;
      this.rotAngle += 360 / this.numAnchors;
    }
    this.asteroidSize += 0.01;
    if (this.asteroidSize < 10) {
      this.die();
    }
    if (this.asteroidSize > 50) {
      this.split();
    }
  }

  split() {
    asteroids.push(new Asteroid(this.asteroidPosition.x, this.asteroidPosition.y, this.asteroidVelocity.x + random(-2, 2), this.asteroidVelocity.y + random(-2, 2), this.asteroidDirection + random(-40, 40), this.asteroidSize));
    asteroids.push(new Asteroid(this.asteroidPosition.x, this.asteroidPosition.y, this.asteroidVelocity.x + random(-2, 2), this.asteroidVelocity.y + random(-2, 2), this.asteroidDirection + random(-40, 40), this.asteroidSize));
    this.die();
  }

  die() {
    let idx = asteroids.indexOf(this);
    if (idx !== -1) {
      asteroids.splice(idx, 1);
    }
  }
}

class Bullet {
  constructor() {
    this.bulletHidden = true;
    this.bulletSize = 5;
    this.bulletPosition = createVector();
    this.bulletVelocity = createVector();
    this.bulletCreationTime = 0;
    this.bulletLifespan = 2000;
    this.bulletSpeed = 3;
  }

  updateBullet() {
    if (!this.bulletHidden) {
      this.bulletPosition.add(this.bulletVelocity);
      if (millis() - this.bulletCreationTime > this.bulletLifespan) {
        this.bulletHidden = true;
      }
      this.bulletPosition.x = (this.bulletPosition.x + width) % width;
      this.bulletPosition.y = (this.bulletPosition.y + height) % height;
    }
  }

  drawBullet() {
    if (!this.bulletHidden) {
      this.updateBullet();
      ellipse(this.bulletPosition.x, this.bulletPosition.y, this.bulletSize, this.bulletSize);
    }
  }

  reset(pos, spe, direct) {
    this.bulletPosition = createVector(pos.x + 20 * cos(radians(direct) - PI / 2), pos.y + 20 * sin(radians(direct) - PI / 2));
    this.bulletVelocity.x = this.bulletSpeed * cos(radians(direct) - PI / 2) + spe.x;
    this.bulletVelocity.y = this.bulletSpeed * sin(radians(direct) - PI / 2) + spe.y;
    this.bulletCreationTime = millis();
    this.bulletHidden = false;
  }
}

class Ship {
  constructor() {
    this.shipAcceleration = createVector();
    this.shipVelocity = createVector();
    this.shipPosition = createVector(width / 2, height / 2);
    this.shipDirection = 0;
    this.shipLastFire = 0;
    this.shipDelayTime = 300;
  }

  drawShip() {
    this.updateShip();
    push();
    translate(this.shipPosition.x, this.shipPosition.y);
    rotate(radians(this.shipDirection));
    // match Processing scale that draws shipShape at size 10x10
    scale(2.5, 10 / 6);
    fill(255);
    strokeWeight(1);
    beginShape();
    vertex(0, -4);
    vertex(2, 0);
    vertex(2, 2);
    vertex(0, 1);
    vertex(-2, 2);
    vertex(-2, 0);
    vertex(0, -4);
    endShape();
    pop();
  }

  destroyShip() {
    fill(150);
    textAlign(CENTER, CENTER);
    textSize(72);
    noLoop();
    text('You Lose', width / 2, height / 2);
  }

  updateShip() {
    this.shipAcceleration.x = 0;
    this.shipAcceleration.y = 0;
    if (keys[0]) {
      this.shipAcceleration.x = 0.5 * cos(radians(this.shipDirection) - PI / 2);
      this.shipAcceleration.y = 0.5 * sin(radians(this.shipDirection) - PI / 2);
    }
    if (keys[1] && !keys[2]) {
      this.shipDirection -= 5;
    }
    if (keys[2] && !keys[1]) {
      this.shipDirection += 5;
    }
    this.shipVelocity.add(this.shipAcceleration);
    this.shipPosition.add(this.shipVelocity);
    this.shipVelocity.mult(0.95);
    this.shipPosition.x = (this.shipPosition.x + width) % width;
    this.shipPosition.y = (this.shipPosition.y + height) % height;
    if (keys[4]) {
      if (millis() - this.shipLastFire > this.shipDelayTime) {
        this.shipLastFire = millis();
        manager.fireBullet(this.shipPosition, this.shipVelocity, this.shipDirection);
      }
    }
  }
}

function setup() {
  createCanvas(1080, 480);
  background(0);
  manager = new GameManager();
}

function draw() {
  manager.drawGame();
}

function keyPressed() {
  if (keyCode === UP_ARROW) keys[0] = true;
  if (keyCode === LEFT_ARROW) keys[1] = true;
  if (keyCode === RIGHT_ARROW) keys[2] = true;
  if (keyCode === DOWN_ARROW) keys[3] = true;
  if (key === 'w') keys[0] = true;
  if (key === 'a') keys[1] = true;
  if (key === 'd') keys[2] = true;
  if (key === 's') keys[3] = true;
  if (key === ' ') keys[4] = true;
}

function keyReleased() {
  if (keyCode === UP_ARROW) keys[0] = false;
  if (keyCode === LEFT_ARROW) keys[1] = false;
  if (keyCode === RIGHT_ARROW) keys[2] = false;
  if (keyCode === DOWN_ARROW) keys[3] = false;
  if (key === 'w') keys[0] = false;
  if (key === 'a') keys[1] = false;
  if (key === 'd') keys[2] = false;
  if (key === 's') keys[3] = false;
  if (key === ' ') keys[4] = false;
}
