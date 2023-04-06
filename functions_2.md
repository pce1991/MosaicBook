We've seen already how functions can be used to group code together. Remember that when a function is called our program "steps into" it and begins executing the instructions in the body of that function. And remember that a function can take arguments. 

```
//   <name> <arguments>
void MyFunc(int32 n) {
   // body
   for (int i = 0; i < n; i++) {
     Print("Hellow");
   }
}
```

In all the functions we've been writing the "return type" has been void. However we can write functions with different return types:

```
int32 Square(int32 n) {
  return n * n;
}
```

When this function is done evaluating it's going to return as a value of type int32. That means we can do anything with the result that we would normally do with a value, such as store it in a variable, print it, or use it an expression. 

```
int32 x = Square(5);
int32 y = Square(4) + 1;
Print("The value of 9 squared is %d", Square(9));
```

Returning values allows us to group calculations together which is an incredibly useful tool.

For example let's say you had a bunch of NPCs in a game and you wanted to see how many of them are alive. 

```
struct NPC {
  vec2 position;
  int32 health; 
};

NPC npcs[100];

// ... some code that sets up the NPCs

int32 HowManyAlive() {
   int32 aliveCount = 0;
   for (int i = 0; i < 100; i++) {
      if (npcs[i].health > 0) {
         aliveCount++;
      }
   }
   // the return keyword will exit the function and return us the value
   return aliveCount;
}
```



You can return any value type from a function:

```
float32 BiggestX() {
   real32 biggestX = -INFINITY;
   for (int i = 0; i < 100; i++) {
      if (npcs[i].position.x > biggestX) {
         biggestX = npcs[i].position.x;
      }
   }
   
   return biggestGap;
}

bool PlayerToLeftOfPosition(vec2 position) {
   for (int i = 0; i < 100; i++) {
     if (npcs[i].position.x < position.x) {
       return true;
       // notice that we're using the return keyword early, because once we find
   	   // a position to the left we don't need to keep searching. 
     }
   }

   return false; 
}
```



Since you can return any type, that means we can return the value of one of our own struct definitions. Here we write a function that returns us the value of an NPC:

```
NPC MakeNPC() {
    NPC guy = {};
    guy.position = V2(RandfRange(0, 10), RandfRange(0, 10));
    guy.health = 100;
}

// Now if you ever want to make an NPC you can just say
npcs[myIndexToSet] = MakeNPC();
```

This will evaluate the function and return us the value for our NPC which we then copy into our array. 

Exercises:

1. write a function that loops over an array of ints and returns the largest value.
2. Write a function that loops over an array of ints and returns the number of even numbers in the array.
3. Write a function that returns a point that has the smallest x and y values of all your NPCs.