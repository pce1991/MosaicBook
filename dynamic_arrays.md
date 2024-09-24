One of the most useful data structures in programming is the array, but there are some shortcomings. An array is a fixed size, so it can't expand as we add more data into it. Many times we'd like to use an array like a list where we can add or remove things at arbitrary points. An array is more like a box with a bunch of slots than it is like a list. 

This motivates us to introduce a new data structure: the dynamic array (sometimes called a list, a vector, or bucket array). In Mosaic a DynamicArray needs to be allocated using a MemoryArena. Essentially a DynamicArray works by keeping a list of multiple arrays of some size. So it might start off with one chunk of 10 elements. When we try to add an 11th thing it'll see if it has enough room, and then if not it'll allocate a new array from the arena and put our new element there. 

A DynamicArray is the first data structure we've seen which uses a "template type" which is a C++ feature that allows us to use one data structure on multiple types. Essentially what the compiler does is look at each data type we're using our data structure on, then creates a version of that data structure for that type according to the template. 

Let's look at some code:

```
DynamicArray<int32> myArray = MakeDynamicArray<int32>(&arena, 10);
```

The template type is given between the angle brackets. Notice we need the template type both on the function and on the type. 

What this does is create a DynamicArray that stores int32s, and starts off with a default size of 10. 

One way that a DynamicArray is different from an array is that semantically there's nothing "in" the array by default. Even tho we have enough room for 10 ints, if we tried saying

```
myArray[0] = 1001;
```

we would technically be accessing outside the bounds of the used portion of array. So how do we get things into the array? With the PushBack function

```
// PushBack(<pointer to array>, <element to insert>);
PushBack(&myArray, 1001);
Print("Count %d", myArray.count);
```

Our count is now 1 and so we can access the first element using the array operator. PushBack will guarantee that the array expands in size if we're trying to add an element beyond our current capacity. This is why you don't want to manipulate the count of the array directly. 

```
myArray[0] = 2;
Print("element is %d", myArray[0]);
```

We can also remove elements from the array which will move the elements around in memory as you'd expect. 

```
// RemoveAtIndex(<pointer to array>, <index of element to remove>);
RemoveAtIndex(&myArray, 0);
```

Our array now has a count of 0. 

You can use the .count member to iterate over the array

```
for (int32 i = 0; i < myArray.count; i++) {
   Print("element[%d]: %d", i, myArray[i]);
}
```

