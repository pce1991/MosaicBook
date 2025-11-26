
MemoryArena arena = {};

struct Snake {
  float32 moveRate;
  float32 moveTimer;

  vec2 moveDirection;
  DynamicArray<vec2> positions;
};

Snake snake = {};

void MyMosaicInit() {
  SetMosaicGridSize(42, 42);

  AllocateMemoryArena(&arena, Megabytes(8));

  memset(arena.ptr, 0xFAF0, arena.capacity);

  snake.positions = MakeDynamicArray<vec2>(&arena, 64);

  snake.moveRate = 0.125f;

  snake.moveDirection = V2(1, 0);

  PushBack(&snake.positions, V2(21, 21));
  PushBack(&snake.positions, V2(20, 21));
  PushBack(&snake.positions, V2(19, 21));
  PushBack(&snake.positions, V2(18, 21));
  PushBack(&snake.positions, V2(18, 20));
  PushBack(&snake.positions, V2(18, 19));
  PushBack(&snake.positions, V2(17, 19));
}


void MyMosaicUpdate() {
  if (InputPressed(Keyboard, Input_LeftArrow)) {
    snake.moveDirection = V2(-1, 0);
  }
  if (InputPressed(Keyboard, Input_RightArrow)) {
    snake.moveDirection = V2(1, 0);
  }
  if (InputPressed(Keyboard, Input_UpArrow)) {
    snake.moveDirection = V2(0, -1);
  }
  if (InputPressed(Keyboard, Input_DownArrow)) {
    snake.moveDirection = V2(0, 1);
  }

  snake.moveTimer += DeltaTime;

  while (snake.moveTimer >= snake.moveRate) {
    vec2 newPosition = snake.positions[0] + snake.moveDirection;

    for (int i = snake.positions.count - 1; i > 0; i--) {
      snake.positions[i] = snake.positions[i - 1];
    }
    
    snake.positions[0] = newPosition;
    snake.moveTimer -= snake.moveRate;
    // @WARNING: this means the snake can never move more than one
    // unit per frame. 
  }

  for (int i = 0; i < snake.positions.count; i++) {
    if (i == 0) {
      SetTileColor(snake.positions[i], 0.2f, 0.9f, 0.3f);
    }
    else {
      SetTileColor(snake.positions[i], 0.1f, 0.6f, 0.2f);
    }
  }
}
