Assignment 1

In this assignment you'll modify the my_mosaic.cpp file to do the following things.

    Set the grid size to be 32x32 using the SetMosaicGridSize function.
    In the top left corner of the grid color 3 tiles on the first row red, green, and blue respecitvely.
    Color the top right, bottom right, and bottom left tiles yellow, cyan, and magenta respectively.
    Make a global variable and set it's value to 0; color a tile with it and increase it's value by 0.1f every time the user presses the space bar.
    Make two global variables, xPos and yPos, and set their values to anything inside the grid. When the user pressed Up yPos should decrease by 1, and when the press Down yPos should increase by 1. When they press Left xPos should decrease by 1, and increase by 1 when they press Right.
    Use a conditional to make sure your xPos and yPos do not go off the bounds of the grid.

To submit the assignment you'll create a zip directory of your entire Mosaic project and upload that to this assignment submission. To receive a grade the game must include a working game.exe file.

Assignment 2

In this assignment you will make a program that uses the concepts of real-time programming discussed in the lecture to create an animated sequence.
Your program must do the following:

    Draw multiple tiles
    Change color for multiple tiles
    Use time to change the state
    Scale by delta time correctly to achieve framerate independence
    Have multiple stages of your animation (meaning don't just make a tile move to the right and then finish)
    Have a clear end-state for the program
    Use Print to display values of some of your variables when running in the debugger.
    Use multiple timers to change the state of different variables.

A handy way to represent the stages of your program is to use a timer along with an integer representing your stage.

```
    timer += DeltaTime;
    if (timer > 1.0f) {
        stage += 1;
        timer = 0;
    }
    if (stage == 0) {
        // do the first part
    }
    else if (stage == 1) {
        // do the second part
    }
    // etc
```

This assumes your stages are all the length (1 second), but you could do more elaborate control flow to change that.
Grading rubric: 50% technical correctness, 50% creativity. You are expected to create your own work and not just copy the code from the lecture.

Assignment 3

In this assignment you'll create a simple real-time game using the skills you have so far. The game should be very simple. For example: using the arrow keys try to move your character onto a gold colored tile. 
Your game should have a victory condition, and when that victory condition is met you can display the victory condition using the DrawTextTop function like this:
DrawTextTop(RGB(0.8f, 0.3f, 0.5f), "You win!");
(RGB is one of the ways we can create colors in the engine)
You'll need to store a bool that says if you won or not.
When the player loses, or if they press the R key, you should restart the game (that means you'll need to set all your variables to their initial values).
For this assignment I'm looking to see creativity and playfullness. Don't try to come up with something beyond your current ability; take what you know how to do and think of interesting ways to use it. The game should be approachable for the player tho, you can use text to explain the controls or the goal. You may want to experiment a bit by trying something really simple, and then see if you can make it a bit more complex and interesting.
Some things that may help:
You can generate a random number using the RandiRange function. To generate a random number between 0 and 10.
int32 r = RandiRange(0, 10); 
You also have access to a RandfRange which generates a floating point value.

```
float32 r = RandfRange(0.0f, 1.0f);
```

Make sure to clear your tiles every frame.
You can get the mouse position like this:
int32 mouseX = GetMousePositionX();
int32 mouseY = GetMousePositionY();

Assignment 4


In this assignment you're going to use the concepts of variables, conditionals, and input to create a simple adventure game.
Your game should have a character that moves by pressing the arrow keys. If you hold down the arrow keys the character should continue moving in that direction, but they shouldn't move every frame. You'll want to use the InputHeld function and a timer to determine when a character should move.
You will have different levels in your game. Use an int variable to represent what level the character is on. Then inside your update function you'll use conditionals to determine what code should execute based on the level (for example if an NPC is only on level 2, then when you're on level 1 you don't want to draw that NPC!)
Your basic game structure will look something like this:

```
int32 level = 0;
void MyMoasicUpdate() {
   // get input and update your character every frame.
   if (level == 0) {
      // do all your level 0 stuff
   }
   else if (level == 1) {
     // do all your level 1 stuff
   }
}
```

Note that I use an "else if" instead of another if. This is because we only want to run the code for one level per frame. But if it looked like this

```
if (level == 0) {
    // do all your level 0 stuff
    level = 1; // silly example but you can imagine whatever case would trigger the level change
}
if (level == 1) {
   // do all your level 1 stuff
}
```

Then we will have wound up running both conditional bodies on the same frame when we make the change from level 0 to level 1. 

Your game should have the following features:

    items that you can pick up
    Doors, by which I mean a tile which takes you to a different level when the player stands on it.
    Objects that do different things based on if you have an item. For example you might pick up a key which is required for a door to work. You should stand on top of an object to display its name, and press the space bar to pick it up.
    NPCs that will display a line of text when you stand next to them. You should not be able to stand on top of them. Optionally have them say different things if you are holding a certain item.
    Signs which the player can stand on, and when they do it displays a line of text on the screen.

You do not necessarily need to specify any level geometry like walls and impassable objects because it could be very tedious. When we learn about loops in the future you will be able to do that more easily, but don't worry about it for now.
Tips:

    separate out your gameplay code from your rendering code. Always do your calls to SetTileColor last, this makes your logic simpler because you know everything that needs to happen in a frame will have happened by the time you start drawing tiles.
    Use the TilePositionsOverlap function to make collision simpler
    
Assignment 5
In this assignment you will use loops and conditionals to draw various shapes.

Your program will have N modes (one for each shape you want to draw). You'll use conditionals to choose which mode gets executed. Use the space bar to cycle between the modes. The basic structure looks like this.

if (mode == 0) {

// run code for mode 0

}

if (mode == 1) {

// run code for mode 1

}

Each shape that you draw should use variables representing the size of the shape. For example if you are drawing a box instead of hard-coding the width and height use variables representing the size.

Here are the shapes that each mode should draw:

A line of a solid color
A checkered line going between one color and black.
A checkered line going between two different colors.
A line that's broken into 3 parts. The first part should be red, the second part yellow, and the third part green.
A box of a solid color.
A box where each every even row is colorA and every odd row is colorB
A checkered box of two different colors (both colors must be different than the background color).
A box where one of the color channels increases from left to right.
A box where one of the color channels increases from top to bottom.
A box where one of the color channels increases until it reaches a value of 1 half way along the width, and then decreases from 1 to 0 on the other half.




A useful operator is the "modulo" operator, written as %. This operator gives you the remainder when you divide two numbers. So a % b is equal to the remainder of a / b. For example 4 % 2 == 0 because the remainder of 4 / 2 is 0. However 3 % 2 == 1 because 3 / 2 has a remainder of 1. This is very useful for finding out if a number is even or odd. You can use conditionals inside your for loops.

For example this will draw a row of 10 tiles where every other one goes unset.

for (int32 x = 0; x < 10; x++) {
        if (x % 2 == 0) {
            SetTileColor(x, 0, 0.2f, 0.2f, 0.8f);
        }
 }
 
 Assignment 6
 In this assignment you'll write functions that set the values inside an array. Your program should have a mode corresponding to each item in this list. You should call the function corresponding to the mode your program is in. Your program should have 3 color arrays (1 for each channel) and 2 position arrays (1 for each component). The arrays should have enough capacity to store a position and color value for each tile on the grid (tho you don't have to use every element in the array). For example if your grid is 16x16 (the default value, you'd have a capacity of 256). You must use a larger grid size tho. You'll need a single count value which represents how much of the array you're using. In your MyMosaicUpdate you should loop over the elements in the array up to count and set the tile color for each element.

You arrays should be declared globally, you do not need to pass them into your functions tho since functions have access to all global variables.

To generate a random number you will use RandfRange() which takes two arguments, a minimum and a maximum. So to generate a number between 0 and 1 you'd say:

float32 r = RandfRange(0.0f, 1.0f);

Here are the modes:

Set 10 elements in your array to a random position in your grid, and set each of their colors to red.
Set 10 elements in your array to appear along one row starting in the top left corner; each of the color channels should have a random red value.
Set 10 elements in your array appearing diagonally going from a red value of 1 to a red value of 0.5.
Set 25 elements in your array such that you make a 5x5 square of random colors.
Write a function that takes two arguments representing the starting position of square. Set 25 elements in your array such that you make a 5x5 square of random colors starting at that position.
Set every element in your array such that the entire screen is filled with a random grey-scale value between 0 and 1.
Set every element in your array such that the entire screen is filled with a random color.
Set every element in your array such that the entire screen is filled with random colors generated within a certain range (for example the red value may be randomized between 0.4 and 0.6). The function should take arguments representing the min and max values of the randomized range.

Your program must randomly generate the values once per mode switch, which means it should not generate values for the array every frame.

Note that to generate a random number you must call the RandfRange function inside a function.

Your program will have a similar structure to this example. Your functions should configure the contents of your array and then you simply loop over your arrays and call SetTileColor passing in elements from the array.

// declare your arrays

int32 modeIndex = 0;

void Mode1() {

    //...

}

void MyMosaicUpdate() {

    if (InputPressed(Keyboard, Input_Space)) {

        if (modeIndex == 1) {

          Mode1();

        }

       modeIndex++;

   }

   // Loop over the elements in your array and call SetTileColor

  for (int i = 0; i < elements; i++) {

     SetTileColor(xs[i], ys[i], reds[i], greens[i], blues[i]);

  }

}

