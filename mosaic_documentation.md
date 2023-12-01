How this documentation works:
Function names are listed followed by their arguments. If there are multiple overloaded versions of a function all versions will be listed.

## Input

### InputPressed()
```
bool InputPressed(InputDevice *device, InputID id)
```

Returns true on the frame where the given InputID for device is pressed, otherwise returns false.

### InputHeld()
```
bool InputHeld(InputDevice *device, InputID id)
```

Returns true if the given InputID for device is held down, otherwise returns false.


### InputHeldSeconds()
```
bool InputHeldSeconds(InputDevice *device, InputID id, float32 time)
```

Returns true if the given InputID for device has been held down for at least N seconds, otherwise returns false.

### InputReleased()
```
bool InputReleased(InputDevice *device, InputID id)
```

Returns true if the given InputID for device was released this frame, otherwise returns false.

## Mosaic Functions

### SetTileColor()
```
void SetTileColor(float32 x, float32 y, float32 r, float32 g, float32 b)
void SetTileColor(vec2 position, vec4 color)
```

Sets the tile at the given coordinate to the specified color.

Example:
```
SetTileColor(0, 0, 0.5f, 0.1f, 0.2f);
```

### int32 GetMouseX()
Returns the x coordinate of the tile the mouse is hovered over. If the mouse is off the grid returns -1.

### int32 GetMouseY()
Returns the y coordinate of the tile the mouse is hovered over. If the mouse is off the grid returns -1.


## Math Functions
### V2()
```
vec2 V2(int32 x, int32 y)
vec2 V2(float32 x, float32 y)
vec2 V2(float32 n)
```
Evaluates to a vec2 with specified x and y values. If only one value is passed in sets both x and y to that value.



## Global Varibales
### Time
Gives the current time in seconds since the program launched.

### DeltaTime
Gives the amount of time in seconds between the start of the last frame and the start of the current frame.

### Keyboard
A pointer to the keyboard device. Used to pass in to input functions.

### Mouse
A pointer to the mouse device. Used to pass in to input functions.

