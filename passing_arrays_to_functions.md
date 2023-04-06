Because our games have been very simple we've been able to declare all our arrays as global variables, meaning that every block of code has access to them. However there may be times we want to declare an array locally or write a function that can operate more generically. 

Let's look at an example:

```
int32 numbers[100];

int32 FindSmallestValue() {
   int32 smallest = INFINITY;
   for (int i = 0; i < 100; i++) {
      if (numbers[i] < smallest) {
         smallest = numbers[i];
      }
   }
   return smallest;
}
```

What this function is computing is pretty generic, but there's a lot of specifics baked in. We assume that our array has 100 things in it. We also assume that the array we're looping over is always numbers. But we might have multiple arrays full of ints which we could want to use this function on. For example in an RPG you might have an array of health values, and an array of experience values, and it may be useful to find the smallest value in either of these arrays. 

So what if instead of writing the function assuming we know the array we had the function take an array as one of our arguments. 

```
int32 FindSmallestValue(int32* array) {
   int32 smallest = INFINITY;
   for (int i = 0; i < 100; i++) {
      if (array[i] < smallest) {
         smallest = array[i];
      }
   }
   return smallest;
}
```

Okay, so what's with the * after int32. Well this is a new type, specifically a "pointer type." A pointer is a type whose value represents a memory address. We can think of the type as two parts: the first part tells us what type of thing we're storing at the memory address, and the second part (the *) simply tells us that we're a pointer. Note that a pointer can be written two ways

```
int32* array
int32 *array
int32 * array
```

Notice that the asterisk can go next to the type, or next to the variable name. It can even go in between, but I've never seen anyone write it this way. 

So let's return to our function: what's going on here. Well instead of taking an argument that stores an int32 value, we're taking an argument that stores the memory address of an int32 value. Remember that the value of an array is the memory address of where the contiguous block of memory starts. So if we called our function like this:

```
FindSmallestValue(numbers);
```

The first thing that happens is we copy the value of "numbers" (which is a memory address) into a new variable local to FindSmallestValue which is called "array." Now numbers and array are both "pointing" at the same memory address. And remember that when we access elements of an array using the [] operator what we're doing is saying "move this many multiples of our type size past the start of the memory buffer."

There's one assumption that we're still making: the array always has 100 elements. Whenever you pass in arrays to functions it's a good idea to also pass along how many elements are in the array:

```
int32 FindSmallestValue(int32* array, int32 count) {
   int32 smallest = INFINITY;
   for (int i = 0; i < count; i++) {
      if (array[i] < smallest) {
         smallest = array[i];
      }
   }
   return smallest;
}
```

Now we can use our FindSmallestValue on any array. 

@TODO: explain that we can change the contents of the pointer





One very important thing to note is that unlike the other arguments we've looked at we aren't exactly creating a copy of the data. When we do something like:

```
int32 IncreaseByOne(int32 n) {
  n = n + 1;
  return n;
}

int32 x = 5;
IncreaseByOne(x);
```

we haven't actually changed the contents of x, because we've created a new variable n and simply copied the value of x into n. But because the value of a pointer is the memory address, that means we have two variables (numbers and array) which are both "referring" to the same spot in memory. This means you could write a function like this:

```
void IncreaseByOne(int32* array, int32 count) {
  for (int32 i = 0; i < count; i++) {
      array[i] = array[i] + 1;
  }
}
```

