I said in the beginning that there are 3 basic elements of computing: data manipulation (variables, expressions), conditional execution, and loops. We have already learned two, and now comes the third.

Loops are fundamental to any interactive program. To make them interacitve we need some way to repeatedly update what is displayed to the user.

Every video game you have ever played has a loop structure something like this:

1. start game
2. get input 
3. update game state
4. render images
5. render audio
6. goto step 2. 

A loop is a way for us to repeatedly execute a block of code. The simplest type of loop is called a "while loop"; it's called "while" because it means "keep running this block while this is true."

```
while (<boolean expression>) {
  // body of the loop
}
```

When our program is running it will encounter the while, and evaluate the boolean expression. If the expression is false it will simply skip over it; if it's true it will enter the body of the loop and begin executing all the statements inside. When it finishes the last statement it will jump back to the top and evaluate the boolean expression again. If the expression is true it will begin executing the body again, otherwise it will exit.
Remember when I said that someone was calling MyMosaicUpdate(). Well they are calling it from within a loop that looks something like this:

```
while (true) {
  GetInput();
  MyMosaicUpdate();
  Render();
}
```

The ability to loop infinitely might be valuable in this case, but we don't want to create a loop that never ends within a frame of our game, because then we'd never end; we would essentially have halted our program forever.

But since we can put a boolean expression inside the while loop we're able to create a block of code that will run a certain number of times.

```
void MyMosaicUpdate() {
  int x = 0;
  while (x < 3) {
    SetTileColor(x, 4, 1, 0, 0);
    x++;
  }
}
```



Let's "unroll" this loop to see exactly what's happening.

iteration | 

| Iteration | Instructions |
| --------- | ------------ |
| 0         | 0 < 3 ?      |
|           | SetTileColor |
|           | x = x + 1    |
| 1         | 1 < 3 ?      |
|           | SetTileColor |
|           | x = x + 1    |
| 2         | 2 < 3        |
|           | SetTileColor |
|           | x = x + 1    |
| 3         | 3 < 3        |
|           | Finish       |



When reading or writing a loop it can be helpful to unroll it like this in your head (or write it out if you want!). With some experience you'll no longer need to do that.

The key insight is: we are running the same block of code, but each time we run it the value of x has changed. This is usually why we want to create loops: repeatedly run some code where at least one parameter of it is changing.

This may seem like a minor victory, "big woop, we can color 4 tiles using 4 lines of code, who cares?" But we can see the payoffs when the number of times we want to iterate increases.

```
void MyMosaicUpdate() {
  int x = 0;
  while (x < 8) {
    SetTileColor(x, 4, 1, 0, 0);
    x++;
  }
}
```

It also becomes easier to change the number of times we want to iterate without having to move or delete our code.

This pattern of creating a variable, looping while some condition is true, and changing the value of that variable every iteration is so common that C++ provides a way to express it more succintly using a for loop.

A for loop is written like this:

```
for (<assignment>; <boolean expression>; <expression>) {
  <statements>
}
```

When our program encounters a for lop it'll execute it like this:

1) Assignment
2) Evaluate bool expression
3) if boolean expression is true goto 4, else goto 7
4) body
5) expression
6) goto 3
7) End

Let's look at how we would rewrite our previous while loop as a for loop

```
void MyMosaicUpdate() {
  for (int x = 0; x < 8; x++) {
    SetTileColor(x, 4, 1, 0, 0);
  }
}
```

While loops are useful when you have some code where the terminating condition is indefinite. A game is a good example of this: we know at some point our game will end, but it's impossible to say ahead of time when that will happen. A for loop is useful when we know how many times we want something loop.
Let's now use our changing value of x to calculate the color.

```
void MyMosaicUpdate() {
  for (int x = 0; x < 8; x++) {
    real32 red = x / 8.0f;
    SetTileColor(x, 4, red, 0, 0);
  }
}
```

Just like with any block of code we can put any other block of code inside it.

```
void MyMosaicUpdate() {
  for (int x = 0; x < 8; x++) {
    if (x < 4) {
       SetTileColor(x, 4, 1, 0, 0);
    }
    else {
       SetTileColor(x, 4, 1, 1, 0);
    }
  }
}
```

Any interactive program is an iterative process over time. Within that iteration we have other iterations which are over spaces (physical space, samples of an sound wave, number of entities…)
That sentence suggests we can put loops inside of loops, which we can!

```
void MyMosaicUpdate() {
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 8; x++) {
       SetTileColor(x, y, 1, 0, 0);
    }
  }
}
```

We'll refer to these as the inner and the outter for loops. For each iteration of the outter for loop, we will do all iterations of the inner for loop. The total number of iterations will be equal to the number of iterations of the outter for loop times the inner for loop (in this case that's 8 * 8 = 64). We then increase the value of y, and repeat the process again. Unrolled it looks looks like this:
iteration:

| Iteration | Instruction   |
| --------- | ------------- |
| 0         | 0 < 8         |
|           | do inner loop |
|           | y++           |
| 1         | 1 < 8         |
|           | do inner loop |
|           | y++           |
| 2         | 2 < 8         |
|           | do inner loop |
|           | y++           |
| ...       | ...           |
| 7         | 7 < 8         |
|           | do inner loop |
|           | y++           |
| 8         | 8 < 8         |
|           | Finish        |


By running this code we can see that the x and y values will have been set to every tile position on the board. In fact, this is exactly how our ClearTiles() function works. There are more interesting things that we can do tho:

```
void MyMosaicUpdate() {
  for (int y = 0; y < 8; y++) {
    for (int x = 0; x < 8; x++) {
       real32 red = x / 8.0f;
       real32 green = y / 8.0f;
       SetTileColor(x, y, red, green, 0);
    }
  }
}
```

It's not necessary that the variable assigned in our for loop start at 0.

```
void MyMosaicUpdate() {
  for (int y = 4; y < 8; y++) {
    for (int x = 4; x < 8; x++) {
       real32 red = x / 8.0f;
       real32 green = y / 8.0f;
       SetTileColor(x, y, red, green, 0);
    }
  }
}
```

```
void MyMosaicUpdate() {
  for (int y = 2; y < 6; y++) {
    for (int x = 2; x < 6; x++) {
       SetTileColor(x, y, 1, 0, 1);
    }
  }
}
```

Nor is it necessary that they always increment by 1.

```
void MyMosaicUpdate() {
  for (int y = 0; y < 8; y += 2) {
    for (int x = 0; x < 8; x += 2) {
       real32 red = x / 8.0f;
       real32 green = y / 8.0f;
       SetTileColor(x, y, red, green, 0);
    }
  }
}
```

Exercises: 

For these exercises I recommend drawing out a grid and labeling the x/y coordinates of each tile; this will give you a better idea of what you want to do at certain values as you iterate. Visualization is a powerful technique. Our programs describe a process which happens over a number of iterations, and sometimes its hard when looking at the code to visualize what that does because a) it happens so quickly and b) it is represented in a very dense way.

Shape printing:

- Write a function that colors N tiles in row R, starting at column C.
- Write a function that colors N tiles diagonally, starting at row R and column C, and going in 1 of 4 directions.
- Draw a box where you only set the colors on the outer tiles

