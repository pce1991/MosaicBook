A struct is a way to bundle data together into one type.
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
