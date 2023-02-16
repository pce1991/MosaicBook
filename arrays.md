In games the problems we are trying to solve usually involve multiple instances of the same type of data. If you think of the games you've played there are almost always multiple characters, objects, animations, sounds, and so on.

Even in our example from Physics we had two objects you were trying to dodge. Adding a third would be doable, but would involve a bit of code duplication. Adding 10 would be a pain.

An array is a way we can store multiple pieces of data in a named collection, and access them by requesting the "nth" element ("give me the first element, give me the fifth element" and so on).

An array declaration looks like this:

```
// <type> <name>[<expression>];
int32 numbers[10];
```

When we declare an array variable we're telling the computer "I want enough memory to store this many elements of this type." In this example that type is int32, so we're asking for 40 bytes of memory.

An array is just like any variable, it has a type and we're storing a value of that type. The type we're storing is a memory address, so the value is where the array was stored in memory.



| Memory Address | Data                                       |
| -------------- | ------------------------------------------ |
| 0...999        |                                            |
| 1000-1004      | First int and the start of "numbers" array |
| 1004-1008      | Second int                                 |
| 1008-1012      | Third int                                  |
| 1012-1040      | Fourth thru tenth int                      |

When we have an array we say it has "n elements"; we can talk about the "nth element" or "the element at index n". To interact with elements of the array we use the bracket operator [].

```
int32 numbers[10];
numbers[0] = 2; // first element
numbers[1] = 1001; // second element
```

It may seem strange that we use [1](#fn.1) for the first element, but we can consult our diagram to see why. If the array starts at address 1000, and we know each element in our array is 4 bytes, then we know the first element is at address 1000, the second is 1004, third at 1008, and so on. That gives us an expression: startaddress + (size * n) = addressofelementn.

One of the most useful traits of arrays is that we can iterate over them using loops.

```
vec2 positions[10];

void MyMosaicInit() {
  for (int i = 0; i < 10; i++) {
    positions[i] = V2(RandiRange(0, 8), RandiRange(0, 8));
  }
}
void MyMosaicUpdate() {
  for (int i = 0; i < 10; i++) {
    SetTileColor(positions[i], 0, 1, 1);
  }
}
```

You can declare a variable and use that for the size of your array, but the value of this variable must be "constant." There are two ways that we do this in C++, one you can think of as the "old style", and the other the "new style."

We'll start with the new style first.

```
// Another way we can define our capacity is by using a variable we modify
// to be "const", which tells the compiler that the value never
// changes, meaning that the compiler can safely know what the size of our array
// is when the program is compiled. 
int32 const positionCapacity = 10;

vec2 positions[positionCapacity];

// positionCapacity = 100;
// This line of code won't compile because we're changing the value of a const variable.

void MyMosaicInit() {
  for (int i = 0; i < positionCapacity; i++) {
    positions[i] = V2(RandiRange(0, 8), RandiRange(0, 8));
  }
}
void MyMosaicUpdate() {
  for (int i = 0; i < positionCapacity; i++) {
    SetTileColor(positions[i], 0, 1, 1);
  }
}
```

The old style uses the "preprocessor." This is a pass the compiler runs over our code before compiling it. One thing you can use the preprocssor for is "macros", which are simple textual substitutions.

```
//#define positionCapacity 10
// This doesnt create a variable positionCapacity, instead it says when we compile our code
// everywhere it sees the term positionCapacity it will replace with the characters 10,
// then it will compile that code. 
// That means a line like this doesn't even make sense:
// positionCapacity = 100
// because that's the same as saynig "10 = 100;"


vec2 positions[positionCapacity];

void MyMosaicInit() {
  for (int i = 0; i < positionCapacity; i++) {
    positions[i] = V2(RandiRange(0, 8), RandiRange(0, 8));
  }
}
void MyMosaicUpdate() {
  for (int i = 0; i < positionCapacity; i++) {
    SetTileColor(positions[i], 0, 1, 1);
  }
}
```

I do use some macros in the codebase, and we'll learn more about good uses for them.