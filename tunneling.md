If we have an object that is moving very fast it can "tunnel" thru a collider. Say that it's moving with a speed of 300, that means it's moving 5 units per frame at 60FPS. So let's say that our starting x position is 0, and our current x position is 5, if there is an object at 2 we will "tunnel" thru the object because we were never on a position either at the beginning or end of the frame where our position overlapped the object. 

There are several ways to solve this problem, but the simplest (tho most costly), is to break our movement down into segments. So if we know that our minimum width of objects is 1, we can make sure that our object never moves more than 1 unit without checking for a collision. We of course still want to allow speeds greater than 1, but we must do it in pieces. 

![](C:\Users\pce\MosaicBook\images\tunneling1.PNG)

So let's take our code 

```
position = position + velocity * DeltaTime;
if (TestPointAABB(position, min, max)) {
   // collision detected
}
```

And we want to change it so that we only move in increments of 1.

```
real32 maxMoveDelta = 1.0;
real32 moveDelta = velocity * DeltaTime;
real32 moveDeltaLength = Length(moveDelta);
vec2 moveDeltaDir = Normalize(moveDelta);
real32 distanceToTravel = moveDeltaLength;

while (distanceToTravel >= 0.0) {
   real32 moveAmount = maxMoveDelta;
   if (distanceToTravel < maxMoveDelta) {
       moveAmount = distanceToTravel;
   }
   position = position + moveDeltaDir * moveAmount;
   distanceToTravel -= moveAmount;
   
   if (TestPoint(position, min, max)) {
      // collision happened and we want to stop moving and fix up our position.
   }
}

```



[NOTE TO AUTHOR: show examples using actual AABB collision which gives us the direction of overlap]