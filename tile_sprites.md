
An `MTile` has a few other properties than just color that you can set. Instead of drawing it as a single colored square, you can instead set the tile's `sprite`. When a tile has a sprite you can also adjust it's `scale` and `rotation`. Think of a sprite as a floating image on top of each tile at the center. A sprite uses a `tint` value instead of the color, that way you can still set the color of the square behind the sprite. We assume that the sprite is a grey-scale image, and then the tint simply multiplies itself by whatever the color value of the sprite is. For example of you have a tint of `(1, 0, 0)` and sprite that's all white, each pixel of that sprite will be red. However if the sprite had variation with lighter and darker spots then each pixel of the sprite would scale the tint. 

Now to use a sprite you'll need to load a `png` file off disk. We do this in the following way:

```
Sprite sprite = {};

void MyMosaicInit() {
    LoadSprite("data/textures/circle.png", &sprite);
}
```

The first argument is the relative path to where the `png` is stored on disk. The `&sprite` is passing in the memory address of our sprite variable to the function so that it can store the data there and upload it to the GPU. We'll talk more about the `&` symbol soon. 

You want to make sure you load your sprite before you use it, and the best way to do that is just load it up front in the Init function. 

Now that you have a sprite you can tell a tile to use it like this:

```
SetTileSprite(0, 0, &sprite);
SetTileTint(0, 0, V4(0.6f, 0.3f, 0.8f, 1.0f));
```

By default a tile will draw its sprite (if it has one), with a scale of 1 and a rotation of 0. The tint will be `{0, 0, 0, 0}` which means it'll be transparent by default. 

You can change the `scale` and `rotation` values like this:
```
SetTileScale(0, 0, sinf(Time) + 1));
// this will scale between 0 and 2.

SetTileRotation(0, 0, Time * 0.5);
// this rotates it 180 degrees every 2 seconds.
```

Because sprites can scale beyond the bounds of the tile we also have a `layer` parameter. Tiles will be drawn in order of their layer, so layer 0 is drawn first, 1 next, and so on. 

```
SetTileLayer(0, 0, 1);
```

You could define a helper function that takes all these arguments for you:

```
void DrawTileSprite(int32 x, int32 y, vec4 tint, Sprite *sprite, float32 scale, float32 rotation, int32 layer) {
  SetTileTint(x, y, tint);
  SetTileSprite(x, y, sprite);
  SetTileScale(x, y, scale);
  SetTileRotation(x, y, rotation);
  SetTileLayer(x, y, layer);
}
```


