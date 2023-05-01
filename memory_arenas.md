
We discussed how heap allocation can be expensive. So we want to reduce the number of heap allocations. One way we do this is with custom allocators.
  A memory arena is one of the simplest types of allocators. It works by making one allocation, and then doling out memory from that buffer when requested. A memory arena works like a stack: you can push allocations onto the stack, the arena will then increase the stack pointer for the next allocation you make. This means that allocations on a memory arena are very cheap since all that happens is it returns us a pointer from a previously heap allocated region and then increases the offset from that pointer. 
  Deallocation is as simple as setting the offset of the memory arena to an earlier point. We don't actually deallocate any memory, but now any new allocations we'll overwrite whatever data was stored there.
  Because the arena is a stack we are not able to arbitrarily deallocate a piece of memory. We can roll-back the offset to an earlier point in the stack. So for example if you need to temporarily allocate 100 ints, use them in some calculation, and then forget about them you can accomplish this by recording the offset before you allocate them, then return the offset to that value when you're done. But you can't allocate 100 ints, then 1000 vec2s, and then deallocate the ints without also deallocating the vec2s. 
  One of the things that makes memory arenas so powerful is they allow us to organize our data by lifetimes. In games we have very clear lifetimes for most pieces of data. 
  For example let's say you want to know the distance between every enemy and the player; that's clearly data that you only need for the current frame. Likewise you may want to make a string and perform some operation to create a file path and open a file; again, you only need that for one frame.
  
  Other data may last the entire length of your game, such as all the sound effects you could play, or the maximum number of particles you can display. Then there are allocations that may only exist for the duration of a level, or while an animation is playing, and so on.
  Per frame memory is very easy to handle with an arena: you just clear the arena at the end of every frame, but it means you can allocate things very cheaply if you know they're impermanent; think of it as a scratchpad allocator. 
Here is an example of creating and using a memory arena.
MemoryArena arena = {};
int32 colorsCount = 100;
vec4 *colors = NULL;
void MyMosaicInit() {
    SetMosaicGridSize(10, 10);
    
    AllocateMemoryArena(&arena, Megabytes(8));
    colors = PushArray(&arena, vec4, colorsCount);
    for (int i = 0; i < 100; i++) {
        colors[i].r = RandfRange(0.0f, 1.0f);
        colors[i].b = RandfRange(0.0f, 1.0f);
        colors[i].b = RandfRange(0.0f, 1.0f);
        colors[i].a = 1;
    }
}
void MyMosaicUpdate() {
    int32 index = 0;
    if (InputPressed(Input, Input_Space)) {
        for (int i = 0; i < 100; i++) {
            colors[i].r = RandfRange(0.0f, 1.0f);
            colors[i].b = RandfRange(0.0f, 1.0f);
            colors[i].b = RandfRange(0.0f, 1.0f);
            colors[i].a = 1;
        }
    }
    int32 sizeWhenAllocated = arena.size;
    int32 *numbers = PushArray(&arena, int32, 100);
    for (int i = 0; i < 100; i++) {
      numbers[i] = RandiRange(0, 100);
    }
    // move the size back to where it was before we pushed
    // the numbers.
    arena.size = sizeWhenAllocated;
    
    for (int y = 0; y < 10; y++) {
        for (int x = 0; x < 10; x++) {
            SetTileColor(x, y, colors[index]);
            index++;
        }
    }
}
