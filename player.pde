final int POINTS_FOR_COIN = 1;
// final int POINTS_FOR_GEMS = 10;
// ...

int playerX;
int playerY;
int playerScore = 0;

final int PLAYER_IDLING_STATE = 0;
final int PLAYER_WALKING_STATE = 1;

int playerState = PLAYER_IDLING_STATE;
int walkingFrames = 0;

void placePlayer(int x, int y) {
  playerX = x;
  playerY = y;
}

void movePlayer(int dx, int dy) {
  int nextX = playerX + dx;
  int nextY = playerY + dy;
  playerState = PLAYER_WALKING_STATE;
  walkingFrames = 20;
  
  if (currentLevel[nextY][nextX] != '#') {
    playerX = nextX;
    playerY = nextY;
    if (currentLevel[nextY][nextX] == 'E') {
      loadNextLevel();
      doorSound.play();
      doorSound.rewind();
    } else if (currentLevel[nextY][nextX] == '*') {
      playerScore += POINTS_FOR_COIN;
      currentLevel[nextY][nextX] = ' ';
      coinSound.play();
      coinSound.rewind();
    } // else if...
  }
}

void drawPlayer() {
  int pixelX = playerX * cellSize + centeringShiftX;
  int pixelY = playerY * cellSize + centeringShiftY;

  if (playerState == PLAYER_WALKING_STATE) {
    playerSprite.draw(pixelX, pixelY, cellSize, cellSize);
  } else if (playerState == PLAYER_IDLING_STATE) {
    image(playerSprite.images[0], pixelX, pixelY, cellSize, cellSize);
  }
  
  if (walkingFrames > 0) {
    walkingFrames--;
  } else {
    playerState = PLAYER_IDLING_STATE;
  }
}

void drawPlayerScore() {
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Score " + playerScore, width / 2, 50);
}
