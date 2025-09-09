An axis-aligned bounding box (hereby referred to as an *AABB*) is defined by two points: the point with the minimum coordinates, and the point with the maximum coordinates, here by referred to as *min* and *max*. 

To determine if a point lies within a bounding box we need to check if that point's x coordinate lies between the min and max values on the x-axis, and then do the same for the y-axis. This function in Mosaic does just that. I recommend drawing this out on graph paper to visualize what it is doing and the cases that succeed and those that fail. 

```
bool TestPointAABB(vec2 p, vec2 min, vec2 max) {
    return (p.x > min.x && p.x < max.x) &&
        (p.y > min.y && p.y < max.y);
}
```

When testing two AABBs for collision there are two pieces of information we want: 1) whether they overlap or not; 2) what the axis of minimum penetration is so we know which direction to move one of the boxes to resolve the collision so that they no longer overlap. 

We have a function that does that in Mosaic called `TestAABBAABB`

To call it we need to provide the following arguments: `bool TestAABBAABB(vec2 minA, vec2 maxA, vec2 minB, vec2 maxB, vec2 *dir)`

We'll get to what the weird asterisk before `dir` means in more detail, but for now you can think of it as "writing out data". Normally we've been getting information from a function by having it return a value, but here we want two pieces of information: do they overlap, and how much do they overlap. The way we write out data is to give the function the memory address of the variable we want to write into, which you can see in the example below. 

An usage example of this code: 

```
vec2 minA = V2(2, 2);
vec2 maxA = V2(6, 6);
vec2 minB = V2(4, 3);
vec2 maxB = V2(7, 5);


void MyMosaicUpdate() {
// we'll treat the position of each box as being the minimum
if (InputPressed(Input, Input_RightArrow)) {
   minB.x += 1;
}

// the & operator gets the memory address of the variable which is what
// we need to pass to the TestAABBAABB function. This lets the function
// write out the result of the overlap into outDir if there was one. 
vec2 outDir = {};
if (TestAABBAABB(minA, maxA, minB, maxB, &outDir)) {
  SetBlockColor(minA, 4, 4, V4(1, 0, 0, 1));
  SetBlockColor(minB, 3, 2, V4(0, 1, 0, 1));
}
else {
  SetBlockColor(minA, 4, 4, V4(1, 0, 0, 1));
  SetBlockColor(minB, 3, 2, V4(0, 0, 1, 1));
}

}
```

