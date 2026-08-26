
struct Player {
  vec2 position;
};

Player player = {};

void MyMosaicInit() {

}

void SaveGame() {
  FileHandle file;
  if (OpenFileForWrite("data/test_01.sav", &file, &Game->frameMem, Megabytes(4))) {   
    WriteFloat32(&file, player.position.x);
    WriteFloat32(&file, player.position.y);

    CloseFile(&file);
  }
}

void MyMosaicUpdate() {
  float32 speed = 5;
  if (InputHeld(Keyboard, Input_RightArrow)) {
    player.position.x += speed * DeltaTime;
  }
  if (InputHeld(Keyboard, Input_LeftArrow)) {
    player.position.x -= speed * DeltaTime;
  }

  if (InputPressed(Keyboard, Input_Escape)) {
    SaveGame();
  }

  SetTileColor(player.position, 1, 1, 1);
}
