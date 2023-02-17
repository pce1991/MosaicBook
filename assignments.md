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

