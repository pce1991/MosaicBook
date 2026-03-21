In this assignment you will write a program that can read a file off of
disk and convert that into data that the game can use. The file will use
a simple "legend" format where an ASCII character will represent a type
of object. Each of your levels will be NxM.

Here is an example of what a level file could look like. The legend I'm
using is that

- `#` is a `Wall`
- `.` is `Empty`
- `@` is `Player`
- O is `Obstacle`

```
#####
#...#
#.@.#
#..O#
#####
```

You will need to write a function that takes a string of the level path
and a pointer to a `Level` struct and writes into that struct. For this
simple example I'd have a level struct that looks like this:

```
struct Level {
   Player player;
   DynamicArray<Wall> walls;
   DynamicArray<Obstacles> obstacles;
};
```

Once you have your level loaded you should be able to move the character
around in the level by pressing the arrow keys. The character can move
in fixed increments, no need for physics.

Now you need to create a save file for your game and write that to disk.
We call this `serialization`. Your save file just needs to know where
your player is, and what level they are on.
