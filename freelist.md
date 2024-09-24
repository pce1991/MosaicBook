A free list is a data structure that can help us manage a collection of things by keeping track of which things in that collection are available for reuse.

Let's say you have an array of objects in a game. We know that you might not be using all the objects in that array every frame, so we can keep track of how many we're using and simply increment the count when we want a new one like this:

```
const int32 capacity = 100;
int32 count;
Object objects[capacity];

void SpawnObject() {
   objects[count++] = ...;
}
```

But how do we remove things remove things? Well it's not as simple as decrementing the count, because we don't necessarily want to remove the thing at the end of the list. One option might be to give our object a field that says if it's deleted.

```
struct Object {
   bool deleted;
};

void DeleteObject(int32 index) {
    objects[index].deleted = true;
}
```
Now when you're rendering the objects or updating them you'll want to check if it's been deleted. But now the annoying thing happens when you think about adding them again, because we can't just add on to the end of our array anymore, because maybe there's a deleted object between the start and the end. So we have to go searching for that deleted object. This is where free lists come in. We can keep track of which indices in our array are available for reuse, then when we add we don't have to iterate from the start of our list, we can just grab the index at the end of our free list and use that. 

```
int32 freelistCount = 0;
int32 freelist[capacity];

void DeleteObject(int32 index) {
    freelist[freelistCount++] = index;
    objects[index].deleted = true;
}

void SpawnObject() {
   int32 newIndex = 0;
   // check free list
   if (freelistCount > 0) {
       newIndex = freelist[freelistCount - 1];
       freelistCount--;
   }
   else {
     newIndex = count;
   }

   objects[newIndex] = ...;
}
```
