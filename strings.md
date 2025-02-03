A string is a term used in computer science to refer to a sequence of characters. Strings are often thought of as one of our "core" datatypes, along with ints and floats and chars. However there are some things about strings in C++ that make them look very different. So let's start with "sequence of characters." That's what an array is: a sequence of elements of some data type. In C/C++ one of our built-in types is the char. It is 1 byte, and is used to represent an ASCII code. 

So we could say that a string is 

```
char name[16];
// now we have to assign each of the elements
name[0] = 'C'; // notice we use the single quote marks
name[1] = 'o';
name[2] = 'l';
// and so on

```

This is fine in a way, but it's clearly a painful experience to type this out. Especially if you're going to write a line of dialogue instead of a single name. 

The convention in C and C++ is that a string is "null terminated", meaning that the last byte of the string should be 0. This is done so that when iterating over a string we know when to stop, like when we want to print a string for example. 

```
void MyPrint(char* string) {
   int32 index = 0;
   while (true) {
      print("%c", string[index]);
      index++;
      if (string[index] == 0) {
         break;
      }
   }
}

int32 MyStringLength(char *string) {
   int32 count = 0;
   while (true) {
      if (string[index] == 0) {
         break;
      }
      count++;
   }
   
   return count;
}
```



In C++ there's a way to define strings using something called a pointer. A pointer is a very important data type, and we'll learn a lot more about them in the future, but at their core they're very simple. A The value of a pointer is just a memory address. The type tells us what type of data we expect to be stored at that memory address.

```
char* name; // the * after a typename tells us the datatype is a pointer
// and not that type itself.


```

Pointers and arrays are not that different from each other. Remember that the variable name for an array is storing the memory address of where all the elements of that array are stored. So if we have an array:

```
int32 myNums[10];
```

let's say that it starts storing that data at memory address 20012. We know that the 10 ints start at that address. The first one will be at 20012, the second one at 20016, and so on.

The idea of a pointer is similar. You'll learn how to manipulate pointers in future sections, but for now we can just say that char* can be assigned a string value.

```
const char *name = "Collin"; // notice the double quotes which are used for strings
// as opposed to the single ' used for chars
```

Then when you are writing your string the compiler will figure out how long that string is and give you enough space to store the characters. It'll then store the memory address where it puts those characters inside the variable that you declared. 

A common convention is to add the `const` modifier to a string pointer to note that the region of memory is _immutable_, meaning that the bytes there can never change. 

You can print a string using the %s format argument

```
Print("name is %s", name);
```

Let's say that you wanted to compare the contents of two strings (really this just means comparing the bytes in two regions of memory).

```
bool MyStringCompare(const char *a, const char *b) {
   int32 index = 0;
   while (true) {
      if (a[index] != b[index]) {
         return false;
      }
      
      // if we reached the end of both strings without encountering
      // a difference then we know they're equal.
      if (a[index] == 0 && b[index] == 0) {
          return true;
      }
      // but if we reached the end of only one of the strings we know
      // they're not equal.
      else if (a[index] == 0 || b[index] == 0) {
         return false;
      }
      index++;
   }
}
```

I think that dealing with null-terminated strings can be quite a pain, so I often prefer to define a custom string format like this:

```
struct MyString {
   char *string;
   int32 length;
};
```

Working with these is much easier, because it just means that strings are no different really from any other block of memory. Just like we don't want to have an array where we don't know the count or the capacity, we don't want a raw `char *` pointer where we have to search the whole thing to find where it ends. This reduces the number of potential bugs quite a bit.

The C standard library provides two useful functions for how to compare a string. `memcmp` and `strcmp`. 

`strcmp` works essentially the same as our MyStringEquals() where it compares each byte until it reaches the end of either one or both of the strings. It returns 0 if the strings are equal. 

`memcmp` does something similar, but it specifies the number of bytes we want to compare. This is very useful to avoid using null terminated strings. Just like `strcmp` it returns 0 if the regions are equal.

```
inline bool MyStringEquals(char *a, char *b, uint32 length) {
    if (a == NULL || b == NULL) {
        return a == b;
    }

    return memcmp(a, b, length) == 0;
}

```

