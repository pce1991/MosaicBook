I've said that our function MyMosaicUpdate() is being called from inside a while loop, but so far we haven't really seen any evidence of that. We have been using it as if it runs one time. It has however been running many times, it's just that each time we were telling it to do the same thing. Now we'll use variables to store and change data over time as our update function runs multiple times.


First, instead of declaring my variable inside the scope of MyMosaicUpdate (which means that each time our function runs it we'll declare a variable and give it a value), I'm going to declare it once outside the scope of our function, and then change it's value each time MyMosaicUpdate() executes.

```
real32 realRedWagon = 0.0f;

void MyMosaicUpdate() {
   SetTileColor(4, 4, realRedWagon, 0, 0);
}
```

If you run and compile this code you'll see that nothing happens, and that's because I set realRedWagon to be 0, but never changed it's value. Now I'm going to use an expression so that it changes each time MyMosaicUpdate() is called.



```
void MyMosaicUpdate() {
   realRedWagon += 0.01f;
   SetTileColor(4, 4, realRedWagon, 0, 0);
}
```

Neat! We can see that the color of our tile changes over time.


We call each time it runs our code a "frame". This name comes from film and animation where the illusion of motion is created by displaying still images in a rapid sequence (traditionally 24 frames per second in film). This is exactly the same thing that happens in a game. Monitors, screens, and tvs all update at a certain rate, called the "refresh rate." Our game tells the graphics card what image to display, and we need to continually update that image to create a sense of smooth motion or change.


Note that if we did something like this:


void MyMosaicUpdate() {
   real32 realRedWagon = 0;
   realRedWagon += 0.01f;
   SetTileColor(4, 4, realRedWagon, 0, 0);
}


we wouldn't ever see any change because each time our function is called we create a new variable called realRedWagon, add 0.01 to it, then get rid of it when we finish running thru the scope of our function.


Now there is a very important point to note about this: the rate at which our color changes is dependent on how many frames we display per second (put another way, how many times we update our simulation per second). This is very dependent on the specs of the computer you're running on.


Let's take this code:

```
real32 realRedWagon = 0.0f;

void MyMosaicUpdate() {
   realRedWagon += 0.1f;
   SetTileColor(4, 4, realRedWagon, 0, 0);
}
```


It will always take 10 frames for red to reach a value of 1, but this means that our frame rate will determine how much time it takes to reach that value.

If we're running at 60 fps then red would reach a value of 1 in 1/6th of a second (10 frames / 60 frames per second)

If we're running at 120 fps then red would reach a value of 1 in 1/12th of a second (10 frames / 120 frames per second)

If we're running at 144 fps then red would reach a value of 1 in 1/14th of a second (10 frames / 144 frames per second)

This is actually very undesirable behavior for a real time application. Consider the consequences: our animations now get faster or slower depending on the device. And we aren't even doing physics simulations which would also vary in speed.


To solve this issue we want to change our value by some increment that will vary depending on our frame rate. For this we use a value called "delta time", which stores the number of seconds between the start of our last frame and the start of our current frame; in other words it stores how many seconds it took our last frame to do everything (get input, update state, render images, play audio, etc). 


Let's call the time between the start of one frame and the start of another "deltaTime" (we get this name from physics and calculus where delta is used to represent the change between two values over a period of time).


If we look at our different frame rates we can find the values of deltaTime
At 60 FPS deltaTime = 1 / 60 = 16.6ms
At 120 FPS deltaTime = 1/120 = 8.3ms
At 144 FPS deltaTime = 6.9ms


    See how our delta time gets smaller the faster our frame rate is. This makes sense because we're doing more stuff in the same amount of time, so obviously we must be doing each frame more quickly. 
    Now if we use this delta time value in our calculation we can achieve "frame rate independence."


In the Mosaic engine we have access to a variable called DeltaTime which is calculated for us.

```
real32 realRedWagon = 0.0f;
void MyMosaicUpdate() {
    SetTileColor(4, 4, red, 0, 0);
    realRedWagon= realRedWagon + DeltaTime;
}
```

We now see that no matter how many FPS our game is running at, realRedWagon will reach a value of 1 after 1 second.


We can of course scale deltaTime to achieve different speeds.


realRedWagon = realRedWagon + (2 * DeltaTime);


Now it will get to a value of 1 in half a second.


Experiment with this yourself: create variables for each of the color channels and vary them at different rates using deltaTime. Try creating a variable for the x and y position and then change those values over time using deltaTime.


Note that our tiles are always at integer positions (0, 0), (1, 0), (2, 0) and so on; but we can use a real number when calling SetTileColor, it's just that the decimal/fractional part of the number will get lopped off. So an x position of 1.5 is really just 1, as is 1.9999, and 2.00001 is 2, and so on.


If you haven't tried changing the position yet, please do so. If you have then read on.


You see that when we change the position we still see a colored tile where we were previously. This is because we're never changing the color of the tile back. This is something we want to do so often in graphics programming we have a function for it: ClearTiles() which takes 3 color channel values and sets all the tiles to that color. We do this at the beginning of every frame so that we start from a clean slate. This may seem unnecessary now (why not just change the color back when I realize I've moved to a new tile), but as the state of our program becomes more complex it is much simpler (and even faster computationally) to just wipe the screen and draw everything again.


```
real32 x = 0.0f;
void MyMosaicUpdate() {
    ClearTiles(0, 0, 0);

    SetTileColor(x, 4, 1, 0, 0);
    x = x + (2 * DeltaTime);
}
```
