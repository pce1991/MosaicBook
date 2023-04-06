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
char *name = "Collin"; // notice the double quotes which are used for strings
// as opposed to the single ' used for chars
```

Then when you are writing your string the compiler will figure out how long that string is and give you enough space to store the characters. It'll then store the memory address where it puts those characters inside the variable that you declared. 

You can print a string using the %s format argument

```
Print("name is %s", name);
```