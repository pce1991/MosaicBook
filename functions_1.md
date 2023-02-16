Thruout our programming we have been using functions (SetTileColor, SetMosaicGridSize, sinf, InputPressed…) and we have even been defining our own: MyMosaicInit() and MyMosaicUpdate().
A function is a block of code grouped together under a name. This gives us a couple things: 1) it makes it easy to group code by concept and 2) it allows us to reuse blocks of code without actually repeating it, but by simply typing the function name.
When we type the name of a function we "call it." When we call a function what happens is that our program enters the scope of the function and runs the code; when it reaches the end of the function it "returns", meaning that our code picks up on where it left off when the function was called.
There is a world outside our MyMosaicUpdate(): some code some where is calling the function that we have been writing.
The definition of a function looks like this:

```
<type> <name> (<arguments>) {

}
```

The simplest definition of a function is one that has no return value and takes no arguments. A function that doesn't return any value is given a return type "void."

```
void MyFunction() {
  SetTileColor(4, 4, 1, 0, 0);
  SetTileColor(5, 4, 0, 1, 0);
  SetTileColor(6, 4, 0, 0, 1);
}
```

Note that this just the definition of a function, the code inside will not actually run until we call the function. It may seem like this is different behavior than what we've experienced using MyMosaicUpdate, but that's because our engine is calling that function (from mosaic.cpp if you're curious).
Also be aware that like with variables the name has no semantic meaning. We colud call this function anything we wanted: Foo, DoNotColor3Tiles, CreateFullVideoGame.
Just like variables we must declare functions before we are able to use them. Once we have defined this function before our MyMosaicUpdate(), we can call it.

```
void MyMosaicUpdate() {
 MyFunction();
}
```

Often times we want to get some data to our functions for it to use. We call this data an argument to the function, and we say that we "pass an argument to the function." We are already familiar with how to use functions that takes arguments: SetTileColor, InputPressed, to name a few.
Our arguments are specified by declaring variables, so they look like

```
<type> <name> (<type> <name>) {
}
```

Let's look at an example of passing an argument into a function:

```
void DrawThree(int32 x) {
  SetTileColor(x, 4, 1, 0, 0);
  SetTileColor(x + 1, 4, 0, 1, 0);
  SetTileColor(x + 2, 4, 0, 0, 1);
}

void MyMosaicUpdate() {
 DrawThree(4);
}
```



When we call this function our program will look at the arguments, and it'll create a variable within the scope of the function, and copy the value 4 into the variable x. Now we can use that value to compute which 3 tiles we want to color.
Note that the variable only exists within the scope of our function. Therefore if we had another variable called x, that our function DrawThree is talking about a different variable; we are not copying the value 4 into the x declared within MyMosaicUpdate().

```
void MyMosaicUpdate() {
 int32 x = 100;
 DrawThree(4);
}
```

We can define functions as taking multiple variables.

```
void DrawThree(int32 x, int y) {
  SetTileColor(x, y, 1, 0, 0);
  SetTileColor(x + 1, y, 0, 1, 0);
  SetTileColor(x + 2, y, 0, 0, 1);
}

void MyMosaicUpdate() {
 DrawThree(4, 4);
 DrawThree(4, 5);
 DrawThree(6, 6);
}
```

