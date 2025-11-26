

```


MemoryArena arena = {};

struct Cell {
  vec2i gridPosition;
  vec2 worldPosition;

  // extra data like entities that occupy it
};

struct Grid {
  int32 width;
  int32 height;

  DynamicArray<Cell> cells;
  float32 cellSize;

  vec2 origin;
};

Grid grid = {};

/*
  API:
  WorldPositionToGridPosition
  GridPositionToIndex
  GetCell
  GetNeighbors
*/

vec2i WorldPositionToGridPosition(vec2 worldPt) {
  vec2 origin = grid.origin - gridOffset;
  vec2 relPt = worldPt - origin;

  DrawRect(grid.origin, V2(0.1f, 0.1f), GREEN);
  DrawRect(worldPt, V2(0.1f, 0.1f), BLACK);
  Print("rel %f %f", relPt.x, relPt.y);

  vec2i result = V2i(relPt.x / grid.cellSize,
                     relPt.y / grid.cellSize);

  return result;
}

int32 GridPositionToIndex(int32 x, int32 y) {
  if (x < 0 || x >= grid.width || y < 0 || y >= grid.height) {
    return -1;
  }
  
  return (y * grid.width) + x;
}

Cell *GetCell(int32 x, int32 y) {
  int32 index = GridPositionToIndex(x, y);

  if (index < 0) {
    return NULL;
  }

  return &grid.cells[index];
}

void InitGrid(Grid *grid, int32 width, int32 height, float32 cellSize) {
  grid->width = width;
  grid->height = height;
  grid->cellSize = cellSize;

  grid->cells = MakeDynamicArray<Cell>(&arena, width * height);

  for (int y = 0; y < grid->height; y++) {
    for (int x = 0; x < grid->width; x++) {
      Cell cell = {};
      cell.gridPosition = V2i(x, y);
      PushBack(&grid->cells, cell);
    }
  }
}

void MyGameInit() {
  AllocateMemoryArena(&arena, Megabytes(16));

  InitGrid(&grid, 9, 9, 0.7f);

  //grid.origin = V2(-8.0f, -4.5f);
  // we offset the origin by the cellSize so that each cell's origin
  // is in the bottom left.
  grid.origin = V2(0, 0);
  grid.origin = grid.origin - V2((grid.width * grid.cellSize) * 0.5f,
                                 (grid.height * grid.cellSize) * 0.5f);

  //grid.origin = grid.origin + V2(grid.cellSize * 0.5f, grid.cellSize * 0.5f);
}

void MyGameUpdate() {

  // @TODO: draw with some spacing between them.
  // Or draw grid lines
  //DrawRect(V2(0, 0), V2(1, 1), RGB(1.0f, 0.3f, 0.3f));


  vec2 gridOffset = V2(grid.cellSize * 0.5f, grid.cellSize * 0.5f);
  vec2 startCursor = grid.origin + gridOffset;
  vec2 cursor = startCursor;

  vec2 mousePos = V2(Input->mousePosNormSigned.x * 8.0f,
                     Input->mousePosNormSigned.y * 4.5f);
  vec2i hoveredCellCoord = WorldPositionToGridPosition(mousePos);

  Cell *hoveredCell = GetCell(hoveredCellCoord.x, hoveredCellCoord.y);
  
  for (int y = 0; y < grid.height; y++) {
    for (int x = 0; x < grid.width; x++) {
      Cell *cell = GetCell(x, y);

      vec4 color = V4(1.0f, 0.3f, 0.3f, 1.0f);

      if (y % 2 == 0) {
        if (x % 2 != 0) {
          color = V4(0.2f, 0.3f, 0.7f, 1.0f);
        }
      }
      else {
        if (x % 2 == 0) {
          color = V4(0.2f, 0.3f, 0.7f, 1.0f);
        }
      }

      if (cell == hoveredCell) {
        color = WHITE;
      }

      DrawRect(cursor, V2(grid.cellSize * 0.5f, grid.cellSize * 0.5f), color);

      cursor.x += grid.cellSize;
    }

    cursor.y += grid.cellSize;
    cursor.x = startCursor.x;
  }

  {
    vec2i hoveredCellCoord = WorldPositionToGridPosition(mousePos);
  }
}

```

