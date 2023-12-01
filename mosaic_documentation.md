How this documentation works:
Function names are listed followed by their arguments. If there are multiple overloaded versions of a function all versions will be listed.

## Global Varibales
### Time
Gives the current time in seconds since the program launched.

### DeltaTime
Gives the amount of time in seconds between the start of the last frame and the start of the current frame.

### Input
A pointer to the InputManager. 

## Mosaic Functions
### SetTileColor()
```
SetTileColor(float32 x, float32 y, float32 r, float32 g, float32 b)
SetTileColor(vec2 position, vec4 color)
```

Sets the tile at the given coordinate to the specified color.

Example:
```
SetTileColor(0, 0, 0.5f, 0.1f, 0.2f);
```

### GetMouseX()
### GetMouseY()

## Math Functions
