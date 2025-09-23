We often want a way to refer to a piece of data. The most fundamental way we can do that is with a pointer to its memory address. Sometimes tho a pointer is too low-level for the way we want to reference data tho. For example, if the data moved locations in memory, the pointer would no longer be valid. But what's worse, we have no way from the pointer itself to know if it's been moved. So when we move the data we have to have some way to find all the pointers to it and set them to null.

This is where the _handle_ comes in. Handle in this context is just an informal term for an abstraction of a reference. In a simple example we could consider the indices into an array as the handle to the data.  

```
int32 numbers[100];
int32 handle = 5; // referring to the thing at element 5
int32 *pointer = &numbers[5]; 
```

Now this is probably not a very useful handle because it doesn't give us more information than a pointer. So what if we wanted a handle to record how many times an element had been set in an array, in addition to the address. We can combine this with the idea of a free list too also know whether an item in the list of numbers is empty or not.

This might not be necessary for a list of numbers, but let's imagine a more interesting example. We have a game with 3 entities: a player, a collectable, and an enemy. The player runs around and collects coins, and the enemy picks a coin and moves towards it. But what happens if that coin gets grabbed? We need to pick a new coin. But just using a pointer wouldn't help us there, because there's no coin at that memory address anymore. So we need refer to a coin that also tells us when our reference is "out of date." or "stale."

```
struct CoinEntry {
   bool freed;
   int32 generation; // how many times this has been set.
};

struct CoinHandle {
  int32 index;
  int32 generation; // we can compare this to the NumberEntry
};

struct Coin {
   CoinHandle handle; 
   // stores a handle to itself so you can always go from the
   // data to a reference. Same way we can always go from a piece of data
   // to a memory address with & operator.
   vec2 position;
};

int32 coinCount = 0;
CoinEntry coinEntries[100];
Coin coins[100];
int32 coinFreelistCount;
int32 coinFreelist[100];
```

The way we refer to an element in the `coins` array is with a handle which points us into the `coinEntries` array. From there we can determine if an element is free or not, and whether we're referring to the correct version. Imagine a case like this:

```
Add a coin A
Enemy X picks A as its target.
Remove A (meaning we add it to the freelist)
X's reference to A is now stale. 
```

We want the handle `A` to know that the thing it's referring to is no longer there. 

```
CoinHandle SpawnCoin(vec2 position) {
   // imagine passing in some arguments like the position of the coin
   int32 newCoinIndex = coinCount;
   if (coinFreelistCount > 0) {
      newCoinIndex = coinFreelist[coinFreelistCount - 1]; 
   }
   else {
      // we're adding a new entry so we want to bump our count.
      coinCount++;
   }
   
   Coin *coin = &coins[newCoinIndex];
   CoinEntry *entry = &coinEntries[newCoinIndex];

   if (entry->generation == 0) {
     entry->generation = 1;
   }
   // this tells us how many times this slot has been used. If it's the first
   // time the generation will be 1, that way we know anything with a generation
   // of 0 has never been used.
   
   CoinHandle handle = {};
   handle.index = newCoinIndex;
   handle.generation = entry->generation;
   
   coin->position = position;
   coin->handle = handle;
   
   return handle;
}

// this is the same concept as dereferencing a pointer where we take the
// reference and want to get the data. Here we're taking the handle and
// using it to get a pointer to the actual data of the coin so we can
// change it if we want.
Coin *GetCoin(CoinHandle handle) {
   CoinEntry *entry = coinEntries[handle.index];
   
   // we can compare the generations and if there's a mismatch we know
   // that our handle is stale.
   if (entry->generation != handle.generation) {
      return NULL;
   }
   
   return coins[handle.index];
}

void RemoveCoin(CoinHandle handle) {
   Coin *coin = GetCoin(handle);
   if (coin == NULL) {
       return;
   }
   // if the handle doesnt give us a valid coin then we dont want to
   // delete it because there's nothing there to delete.
   
   coinFreelist[coinFreelistCount++] = handle.index;
   CoinEntry *entry = coinEntries[handle.index];
   entry->generation++;
   // the generation goes up by 1 so any handle we have to the coin
   // will now mismatch.
}
```

Now when we update our enemy we just need them to dereference their handle. If they get a valid coin then we know it still exists and can follow it. If it doesn't, then that means it's been deleted and we need to pick a new coin. 

Keep in mind that if we wanted to have our coinArray be tightly packed instead of using a free list, then we'd want our `CoinInfo` to also keep track of our index in the `coins` array because as things are deleted our index might change. 

There's a more formal structure for this type of pattern where we treat all our entities this way, sometimes called an `EntityManager`. We'll look at that next. 
