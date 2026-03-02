The code you've been writing in Mosaic has been at the outer-most layer. If we peel that back we can look we can see that the idea of a grid of tiles is a construct built on top of the features of a lower layer. What Mosaic has been doing is drawing a grid of colored "quads", and we've been manipulating those colors by calling `SetTileColor`. That grid has been centered in the screen and the position of these tiles has been fixed. 

To step outside of Mosaic you'll go into `game_code.cpp` and change `#define MOSAIC 1` to `#define MOSAIC 0`. This will skip compiling the`my_mosaic.cpp` file and compile `my_game.cpp` instead. This has a familiar structure where we have an update and an init function. 

Outside the Mosaic layer we have the ability to simply render a colored rectangle of any size and any position. This is done using the `DrawRect` function.

`DrawRect(V2(0, 0), V2(1, 1), RGB(1.0f, 0.3f, 0.3f));`

We have some other nice drawing primitives too.

```
DrawLine(V2(3, 0), V2(4, 0), 0.025f, V4(1));
DrawLine(V2(3, 0), V2(3, 1), 0.025f, V4(1,0,0,1));

// instead of taking a start and end point, it takes a start point
// and a direction extending off of it. 
DrawRay(V2(-5, -5), Rotate(Time, V2(1, 0)), 0.025f, V4(0.0f, 0.5f, 0.8f, 1.0f));

DrawCircle(V2(-5, -5), 1.0f, 0.025f, V4(1));
```



We can also load and draw sprites now. 

```
Sprite mySprite;

// the path is always relative to the top-level directory of mosaic.
// I would recommend storing all of your assets in data/
void MyGameInit() {
  LoadSprite("data/textures/galaga_ship.png", &mySprite);
}

void MyGameUpdate() {
  // This sets the background color. 
  ClearColor(RGB(0.0f, 0.0f, 0.0f));
  
  DrawSprite(V2(0), V2(0.5, 0.5), &mySprite);
}

```

You can change the camera parameters as well.

```
Camera *camera = &Game->camera;
camera->position.x = sinf(Time);
camera->size = 1 + ((1 + sinf(Time)) * 0.5f);

// Always make sure you call UpdateCamera so it can recompute the projection matrix
// at the new size and position.
UpdateCamera(&Game->camera);
```

