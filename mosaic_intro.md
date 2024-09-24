We'll be writing our programs in the Mosaic game engine. The defining feature of Mosaic is an N by M grid of "tiles", which are squares that can be set to any color. 

The first thing to do is make sure that you download the Mosaic engine and unzip it. You'll see a few folders, and the one you want to look for is titled "src." In it you'll see a file called "my_mosaic.cpp", so go ahead and open that in your text editor (such as Visual Studio). 

There are two functions which define a game or program in Mosaic: MyMosaicInit() and MyMosaicUpdate().

MyMosaicInit() runs one time when the program is launched. This is where you can initialize your data (for example what position does the player start at).

MyMosaicUpdate() is a function which runs once per frame. 

So think of MyMosaicUpdate as a set of instructions that the computer executes repeatedly. This is where we write the majority of our code: we tell it what to draw and how to update the state of our data.

To manipulate the color of the tiles in Mosaic we use the SetTileColor() function which takes an x and y coordinate, along with 3 color values between 0 and 1. In computer graphics we represent colors using 4 channels: red, green, blue, and alpha/transparency. Our screen hardware is built out of pixels, which are 3 lights bulbs (red, green, and blue). The way we create colors is by setting the intensity of each of those bulbs. If the intensity is 0 that means the bulb emits no light, and if it's 1 it emits at full intensity.

Let's look at some code. Navigate to the file in the "examples" directory called "mosaic_basic.cpp" You can delete everything in there and replace it with this.

```
void MyMosaicInit() { 
}

void MyMosaicUpdate() { 
  SetTileColor(4, 4, 1.0, 0.0, 0.0); 
}
```

One of the best ways to learn programming is to experiment and play around with whatever tool you're using. So I recommend you try calling SetTileColor with different parameters. Try setting the color of each corner. Try creating different colors and developing an intuition for how the channels combine (how do you make purple? how do you make orange?).

Here are some other functions we have access to. You can call these inside MyMosaicInit() to setup your grid how you like.

This sets the dimensions of the grid by supplying a width and a height. The max width is 255 and the max height is 255

SetMosaicGridSize(16, 16);

This specifies if you want to see the grid lines. Often grid lines can be helpful for visualizing where things are, and may be desired if doing something like a tactics or puzzle game. There is an analogous HideGrid() function.

`ShowGrid();`

This specifies the colors of the grid lines. Supply values for the 3 color channels.

`SetGridColor(0.5f, 0.5f, 0.5f);`

This specifies the background color of the screen. Supply values for the 3 color channels. 
`SetMosaicScreenColor(0.2f, 0.2f, 0.2f);`

Fundamentally all visual software is simply setting the colors for each pixel on the screen. The complexity lies in how you determine which pixels and how to color them. So for example it is simple to take an image and display it: you simply take each of the pixels of the image and set the corresponding color on the monitor. It is more complicated to render a 3D dimensional scene: imagine you have a triangle floating in space. As you move around the scene the perspective on that triangle will change, so you need to find a way to map a position on the triangle in 3D space onto a pixel on the screen. That is beyond our knowledge right now, but it is the same basic process of setting the colors of pixels.
