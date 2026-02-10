A hash table (sometimes called a map or dictionary) is a data structure for associating two pieces of data, a `key` and a `value`. You can think of an array as a hash table where the key is simply the index of the value. Often tho we have more sophisticated types of associations. For example let's say you want a list of abilities which you can access simply by looking up the name of the ability. If each ability has a name and you store them all in an array, to find an ability `A` with name `X` you'd have to search over the entire array, comparing the name of each ability to the one you're searching for. This can be expensive. In computer science we'd call this an `O(n)` search, or `linear search` because the time-complexity grows linearly. If you have `10` things you have to search `10` times potentially, if you have `100` things you have to search `100` times, and so on. Compare this to an array which is `constant time` or `O(1)` where you can instantly look up a piece of data when you have the index. 

A hash table is a data structure that can give us `constant time` for an arbitrary type of `key`. 

There are many many ways to do this, but the gist of it is this: you have two arrays, one of your `keys`, and one of your `values`. To create an association between them we say that a `key` "maps" to a `value` by using a hashing function on it. A hashing function is simply a function that takes an arbitrary piece of data and converts it into a number. That number can then be used to index into our array of `values`. So essentially what's happening is we take a key like a string "AbilityName" and turn it into an index that'll look up into our list of values. 

Of course we have to solve the problem that two strings might hash to the same value. A good hashing function can reduce the probability of this happening, but it's still potentially an issue. For example let's look at a bad hashing function:

```
int32 BadHash(char *string, int32 length) {
   int hash = 0;
   for (int i = 0; i < length; i++) {
      hash += string[i];
   }
   
   return hash;
}
```

This has an obvious issue: `Hash("dog", 3) == Hash("god", 3)` because all we're doing is taking the value of each character and summing them. A good hashing function will do something more sophisticated. There is a tradeoff between quality of the hash and performance. 

One simple change we could make is to use the current value of the hash.

```
int32 BadHash(char *string, int32 length) {
   int hash = 0;
   for (int i = 0; i < length; i++) {
      hash += hash string[i];
   }
   
   return hash;
}
```

Not great, but it is an improvement. 

Again, there are many ways to implement a hash table, but the version in Mosaic uses what's known as a `probe` to handle the case of collisions. First, we need to keep an array of bools to note if a slot is occupied or not. Then when we hash a key, before we place it in that slot we need to look to see if that slot is already occupied because of a hash collision. If it isn't, then we simply put the value in the slot. But if it is we simply "probe" forward one index at a time. You can read `hashtable.h` for more details. 

Now for the API. We create a hash table by specifying the type of our keys and the type of our values. 

```
HashTable<char *, int32> map = {};
AllocatehashTable(&map, 1000);
// There is also a version that takes an allocator if you don't want to allocate with malloc. 
```

To add an item you can simply say:

```
HashTableInsert(&map, "alice", 1001);
HashTableInsert(&map, "bob", 101);
```

Now to access an element in our hash table we will look up using our key and the function will return true if it found something for that key, and write out the value into the pointer we provide. 

```
int32 value;
if (HashTableGet(&map, "alice", &value)) {
   Print("Found the value!");
}
else {
   Print("Oops, couldn't find the value");
}
```

So for example if we wanted to build a database of abilities that a designer could simply access using the names, we can store our abilities in an array, and then we'll have a hash table that maps the ability name to the index in the array. Then to look up an ability we simply go `name -> index -> array`. 

```
struct Ability {
   char *name;
   int32 damage;
   float32 duration;
   bool applyStun;
};

DynamicArray<Ability> abilities;
HashTable<char *, int32> abilityMap;
//...

AllocateHashTable(&abiblityMap, 64);

void AddAbilityToMap(Ability ability) {
   int32 index = PushBack(&abilities, ability);
   HashTableInsert(&abilityMap, abilityName, index);
}

Ability *GetAbility(char *name) { 
   int32 index;
   if (HashTableGet(&abilityMap, name, &index)) {
     return &abilities[index];
   }
   else {
     return NULL;
   }
}
```

