Every now and then we want to express the idea of something representing multiple types. A common example is in a game where we have an object that collides with a subset of all our possible object types. 

Let's take an example:

```
enum ColliderType {
	ColliderType_Player,
	ColliderType_Ghost,
	ColliderType_Wall,
	ColliderType_Box,
};
```

Each body in the game is only one of these types, but they can each collide with multiple types. For example the player collides with walls and boxes, but not ghosts. Now we could say that each object has an array of ColliderTypes which we check against, but there's another way.

Let's leverage the fact that our data is binary. If we have an int32 we know there's 32 bits, and let's say that we use each of those bits to represent our different ColliderTypes. We'll see why very soon.

We can write that:

```
enum ColliderType {
	ColliderType_Player = 1 << 0,
	ColliderType_Ghost = 1 << 1,
	ColliderType_Wall = 1 << 2,
	ColliderType_Box = 1 << 3,
};
```

This expression is known as a "left shit", and it's taking our value and shifting the bits left by the value on the right side. If we view these numbers in their binary representation we have:

```
0001
0010
0100
1000
```

This is useful because now we can use the "bitwise or" operator to combine these values. For example if we said:

````
ColliderType collidesWith = (ColliderType)(ColliderType_Wall | ColliderType_Box)
````

We're gonna get a value:

```
0100 | 1000 = 1100
```

Now notice that we don't have an explicit definition for something of ColliderType with the value 6, which is why we need to cast it. 

Okay, so we've successfully combined multiple types into a single value, but how do we actually use this? That's where the "bitwise and" operator comes in. Let's take our collidesWith value and see the result of using the and operator with various values

```
// let's & it with the value for ColliderType_Player
1100 & 0001 = 0000 
// Now let's try ColliderType_Ghost
1100 & 0010 = 0000 
// Then ColliderType_Wall
1100 & 0100 = 0100
// And finall ColliderType_Box
1100 & 1000 = 1000
```

Notice that when our left-hand side didn't have the same bit from the right-hand side we got a value of 0, and when they did share a bit in the same place the result was non-zero (technically it was just the value of the bit they shared). So now we can take our collidesWith value and compare it to any type to see if we should test for collision or not.
