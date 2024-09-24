In this assignment you'll write functions that set the values inside an array. Your program should have a mode corresponding to each item in this list. You should call the function corresponding to  the mode your program is in. Your program should have 3 color arrays (1  for each channel) and 2 position arrays (1 for each component). The  arrays should have enough capacity to store a position and color value  for each tile on the grid (tho you don't have to use every element in  the array). For example if your grid is 16x16 (the default value, you'd  have a capacity of 256). You must use a larger grid size tho. You'll  need a single count value which represents how many elements of your arrays you're using. In your MyMosaicUpdate you should loop over the elements in the  array up to count and set the tile color for each element.

You arrays should be declared globally, you do not need to pass them into your functions tho since functions have access to all  global variables.

To generate a random number you will use RandfRange()  which takes two arguments, a minimum and a maximum. So to generate a  number between 0 and 1 you'd say:

float32 r = RandfRange(0.0f, 1.0f);

Here are the modes:

1. Set 10 elements in your array to a random position in your grid, and set each of their colors to red. 
2. Set 10 elements in your array to appear along one row starting in the  top left corner; each of the color channels should have a random red value. 
3. Set 10 elements in your array appearing diagonally going from a red value of 1 to a red value of 0.5. Set 25 elements in your array such that you make a 5x5 square of random  colors.
4.  Write a function that takes two arguments representing the starting position of square. 
5. Set 25 elements in your array such that you make a  5x5 square of random colors starting at that position. 
6. Set every element in your array such that the entire screen is filled with a random grey-scale value between 0 and 1. 
7. Set every element in your array such that the entire screen is filled with a random color.
8. Set every element in your array such that the entire screen is filled with random colors generated within a certain range (for example the red value may be randomized between 0.4 and 0.6). The function should take  arguments representing the min and max values of the randomized range.

Your program must randomly generate the values once per  mode switch, which means it should not generate values for the array  every frame.

Note that to generate a random number you must call the RandfRange function inside a function.

Your program will have a similar structure to this  example. Your functions should configure the contents of your array and  then you simply loop over your arrays and call SetTileColor passing in  elements from the array. Your mode functions should only get called once when you change the mode and they should do no drawing. 

```
// declare your arrays

int32 modeIndex = 0;

void Mode1() {
  // code that sets values in your array
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
```

