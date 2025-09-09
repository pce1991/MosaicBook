To generate a random integer value you can use `RandiRange()` which takes two arguments, a min and max value.

```
int32 r = RandiRange(0, 100);
Print("%d", r);
```

To generate a random floating point value you can use `RandfRange()`

```
real32 r = RandfRange(-10.0, 10.0f);
Print("%f", r);
```

Let's say you want to generate a vec2 pointing in a random direction. If you did this:
```
vec2 v = V2(0, 0);
v.x = RandfRange(-1.0, 1.0);
v.y = RandfRange(-1.0, 1.0);
```

You have a couple problems. First, it's not normalized, but second, it's possible that that the vector has no magnitude if you generate a value of 0 for both.

You can use this function instead:

```
real32 angle = RandfRange(0.0, _2PI); 
// _2PI is a constant in Mosaic representing the value of Pi * 2, 
// in other words, 360 degrees.

vec2 v = Rotate(angle, V2(1, 0));
// this function gives you back a vector rotated by angle, 
// expressed in radians.

// if you prefer there are functions that can convert between
// radians and degrees, RadToDeg(), and DegToRad()
```

