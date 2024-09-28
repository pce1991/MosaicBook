A very powerful tool you have to inspect the behavior of your program is displaying values in real time. There are two ways we can do this: we can print them into the output buffer on Visual Studio, or we can display text on the screen.

To print to the console we'll use the Print command. This function takes a string argument and ouputs it in VS. For example:

Print("Hello, my name is");

We'll learn more about what a string is in the future, but for now you can just think of it as "a list of symbols I want to display."

If we want to print a variable we'll give this string a "format argument", which tells it how we want to display the data. We'll place the format in the string, and after the string we'll give it the data we want to format into the string.

```
int32 n = 5;

Print("The value of n is %d", n);
```


To display it as a floating point value:

```
real32 x = 3.14f;

Print("The value of x is %f", x);

Print("This displays it with less decimal places %.2f", x);
```


We can format multiple times within one string.

```
Print("The value of x is %f and n is %d", x, n);
```


We can use DrawTextTile to start drawing a line of text starting at the position of one of our tiles. You give it a position, a size, a color, and the text to print. 

The position will always clamp to the bottom left corner of whatever tile
the position is inside.

```
  DrawTextTile(V2(0, 0), 0.3f, RGB(1, 1, 1), "Tile text");
  DrawTextTile(V2(0, 1), 0.3f, RGB(1, 1, 1), "Tile text");
  DrawTextTile(V2(1, 2), 0.3f, RGB(1, 1, 1), "Tile text");
```

We can draw text at a tile position "off" the screen,
  

DrawTextTile(V2(16, 4), 0.3f, RGB(1, 1, 1), "Tile text");
DrawTextTile(V2(17, 5), 0.3f, RGB(1, 1, 1), "Tile text");

If you want to print the value of a variable you can use some of the formatting operators. You can look up all of these by searching for string formatting in C.

Some examples:

```
int32 x = 5;

float32 n = 3.1459f;

DrawTextTile(V2(16, 4), 0.3f, RGB(1, 1, 1), "A number %d", x);

DrawTextTile(V2(16, 4), 0.3f, RGB(1, 1, 1), "A real number %f", n);
```

We can also draw text at an arbitrary place on the screen in in normalized space where screen coordinates go from 0 to 1

```
DrawTextScreen(V2(0.5f, 0.5f), 0.02f, RGB(1, 0, 0), "Screen text");
```
