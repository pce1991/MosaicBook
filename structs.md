We've been using several built-in types such as int32 and float32. Now we're going to learn how to create our own types out of these built-in types. The way we do this is with a struct, which is a way to bundle a group of data together in one type. 

```
struct <name> {
    <member variables>
};

struct Guy {
   int32 health;
   int32 x;
   int32 y;
};
```

Remember that when we declare a variable we're telling the compiler that we need enough bytes to store data of that type, and that we'll access that data using the name. So when we declare a variable of type Guy we're asking for enough space to store 3 int32s (which is 12 bytes). 

```
Guy myGuy;
```

When we say "myGuy" we're getting the value of that data. Now we haven't assigned any values to it yet, right now we've simply declared the variable, but the data stored there is going to be untouched from whatever it was before we declared our variable. We can use the {} initializer to zero out all the memory

```
Guy myGuy = {};		
```

Now we know that all 12 bytes there are set to 0. 

How do we actually access this data tho. Since Guy is a collection of data it doesn't really mean anything to just have something of type Guy, we want to get at the "member variables." We do that using the dot operator "."

```
myGuy.health = 100;
myGuy.x = 5;
myGuy.y = 2;
```

What this is doing is telling the compiler to fetch the data for myGuy, and then based off of that to fetch the sub data from there using the variable name. This is similar to an array where the array name tells us the start of the data, and we use the [] operator to offset past the beginning. Unlike an array however the data in a struct can be of different sizes, so we can't just use an index, but use the variable name, and since the compiler knows the types of each member variable it can figure out how many bytes past the beginning to go. So health is 0 bytes past the beginning, x is 4, and y is 8. 

If we changed our definition to use smaller data for health

```
struct MyGuy {
	int8 health;
	int32 x;
	int32 y;
};
```

Now our total size is only 9 bytes since health is 8 bits instead of 32. So health is still at 0 bytes, but x is at 1 byte, and y is at 5 bytes. 

For example we've already seen and been using a struct: vec2

```
struct vec2 {
   float32 x;
   float32 y;
};
```

Whenever we make a thing of type vec2 we're telling the computer we need enough data to store 2 float32s.

```
struct Ball {
    // Member variables or parameters or fields
    vec2 position;
    vec2 velocity;
};
```

When we declare a variable of a type that's a struct, we are requesting enough memory from the computer to store all the member variable of that struct next to each other in memory.

```
Ball ball = {};
// the {} operator initalizes all the data in a struct to be 0.


void MyMosaicInit() {
    SetMosaicGridSize(40, 40);
    SetMosaicScreenColor(0.2f, 0.2f, 0.2f);
    // We can access the different members of a struct by using the dot operator.
    // notice that we can "drill down" using this operator. We say "take the ball,
    // give me the position, now take that position, and give me x."
    ball.position.x = 5;
    ball.position.y = 9;
    ball.velocity.x = 0;
    ball.velocity.y = 5;
}

void MyMosaicUpdate() {
    ClearTiles(0, 0, 0);
    ball.position.y += ball.velocity.y * DeltaTime;
    if (ball.position.y > 39) {
        ball.velocity.y *= -1;
        ball.position.y = 39;
        // clamp our position so it's not invalid
    }
    SetTileColor(ball.position, 0.3f, 0.8f, 0.7f);    
}
```
