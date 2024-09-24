In this assignment you will use loops and conditionals to draw various shapes.

Your program will have N modes (one for each shape you want to draw). You'll use conditionals to choose which mode gets executed. Use the space bar to cycle between the modes. The basic structure looks like this.

```
if (mode == 0) {
// run code for mode 0
}

if (mode == 1) {
// run code for mode 1
}
```

Each shape that you draw should use variables representing the size of the shape. For example if you are drawing a box instead of hard-coding the width and height use variables representing the size.

Here are the shapes that each mode should draw:

1. A line of a solid color 
2. A checkered line going between one color and black. 
3. A checkered line going between two different colors. 
4. A line that's broken into 3 parts. The first part should be red, the second part yellow, and the third part green. 
5. A box of a solid color.
6. A box where each every even row is color A and every odd row is colorB 
7. A checkered box of two different colors (both colors must be different than the background color). 
8. A box where one of the color channels increases from left to right. 
9. A box where one of the color channels increases from top to bottom.
10. A box where one of the color channels increases until it reaches a value of 1 half way along the width, and then decreases from 1 to 0 on the other half.

Here is an example of the type of function I'm looking for. This one simply draws a line. 

```
void DrawLine(int32 length) {
   for (int i = 0; i < length; i++) {
   	  SetTileColor(i, 0, 1, 0, 0);
   }
}

// if you wanted to draw a line of length 5 you would call 
// this inside your MyMosaicUpdate funciton by typing:
// DrawLine(5); 

// This is a more elaborate version which lets you specify where the line starts
// and what color it is. 
void DrawLineBetter(int32 x, int32 y, int32 length, float32 r, float32 g, float32 b) {
   for (int i = 0; i < length; i++) {
   	  SetTileColor(x + i, y r, g, b);
   }
}
```

A useful operator is the "modulo" operator, written as %. This operator gives you the remainder when you divide two numbers. So a % b is equal to the remainder of a / b. For example 4 % 2 == 0 because the remainder of 4 / 2 is 0. However 3 % 2 == 1 because 3 / 2 has a remainder of 1. This is very useful for finding out if a number is even or odd. You can use conditionals inside your for loops.

For example this will draw a row of 10 tiles where every other one goes unset.

```
for (int32 x = 0; x < 10; x++) {     
	if (x % 2 == 0) {       
		SetTileColor(x, 0, 0.2f, 0.2f, 0.8f);     
	} 
}
```

Here is an example of what your program should look like if it was only using the DrawLine function:

```
int32 mode = 0;
int32 maxMode = 2;

void MyMosaicUpdate() {
   if (InputPressed(Keyboard, Input_Space)) {
      mode++;
      if (mode > maxMode) {
         mode = 0;
      }
   }
   if (mode == 0) {
      // draws a red line
      DrawLine(0, 0, 5, 1, 0, 0);
   }
   if (mode == 1) {
      // draws a green line
      DrawLine(0, 0, 8, 0, 1, 0);
   }
   if (mode == 1) {
      // draws a blue line
      DrawLine(0, 0, 8, 0, 0, 1);
   }
}
```

