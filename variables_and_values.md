I said in the beginning that a program is something that transforms data. In the previous section we learned some ways to transform data, namely the data of tiles. This transformation evolved a couple of pieces of data: the x and y coordinates of the tile we wanted to change, and the red, green, and blue color values we wanted to use for that tile. In those examples we supplied the data itself. 

Very often we want to store a piece of data and give it a name; then we can use that name to refer to that piece of data. We call that name a "variable". 

To create a variable we declare it. Declaring a variable means we tell the compiler "give me some memory to store this data, and anytime I use this name, I'm talking about the data stored there."

The syntax of a variable declaration looks like this: 

```
<type> <name>;
```

A variable declaration is a statement, just like our function calls from last time, so it needs to end with a semicolon. It's important to realize that this is a command, it is telling the computer to do some physical work. A variable can have any name that you want, as long as it does not begin with number, and has only alpha numeric characters, except for the underscore.

x, Foo, bigDog, anything_you_want, are all valid variable names. You do want to make sure your variable names are sensible, and tell the user (in this case, you) what data they are storing. But be aware there is no semantic meaning to the variable names. If you call a variable "health" your program doesn't know if you're actually using that as health, a color, or the character's name. 

Let's make our first variable then:

```
void MyMosaicUpdate() {
  int32 x;
}
```

That compiles, but it doesn't do anything interesting because we aren't ever using that variable; we aren't even telling it what data to store!

So what is this "int32" business? Well looking at our syntax example we can see it is the type?, but what is a type? A type determines two important things: how much data there is, and how to interpret and use that data. Unlike the name the type cannot be anything you want; it has a strict definition. For now we're using only "built-in" types, but we will learn how to define our own in the chapter on Structs. 

So what is data then? Data is a sequence of bits, which represent two possible values: 0 or 1. A bit is smallest possible amount of information we could represent. So to rephrase our definition: data is a sequence of 0s and 1s. 

The type of the data then determines how many 0s and 1s there are in the sequence, and how to interpret them.

As you may be able to guess from the name, the type int is short for "integer" (a positive or negative number), and the number tells us how many bits something of this type is (32). 

Let's look at how to assign data to a variable:

```
void MyMosaicUpdate() {
  int32 x;
  x = 4;
  SetTileColor(x, 4, 1, 1, 1);
}
```

This is another statement which says "goto the place in memory where x is and copy the value 4 into that location in memory." When we type the name of the variable as an argument to SetTileColor we're saying "goto the memory address and give me the value stored there."

We call this operation *assignment*.

You can combine declaration and assignment into a single line:

```
void MyMosaicUpdate() {
  int32 x = 4;
  SetTileColor(x, 4, 1, 1, 1);
}
```

This is pretty common because we usually know what value we want our data to start at. 

Let's now talk about computer *memory*. Memory is a piece of hardware that can store bits by hodling onto an electric charge. The simplest piece of memory would maintain charge if you told it "remember this bit is 1", and would hold no charge if that bit was 0. 

Instead of addressing individual bits in memory, we address them in 8-bit chunks; an 8-bit sequence of bits is called a *byte*. That means that our int32 is 4 bytes. So when we create an int32 variable we are telling the computer that we want 4 bytes. When we copy the value 4 into that spot we are telling it to copy over some binary data into 4 bytes. 

When making games we're rarely concerned with the binary representation of our data, but it is important to have a conceputal understanding of appreciation for what we are actually telling the computer to do when we create variables. If games are transforming data, then how that data is represented and transformed is important to understand. 

Now that we have a variable we can begin to manipulate that data using *expressions*. 

An expression is a series of *operations* (such as addition, multiplication) performed on data that produces a single value when it is *evaluated*. When we assign a variable to an expression, we are really assigning the variable that value of that expression when evaluated. That means when we type:

```
int32 x = 2 + 2;
```

First we are getting space in memory for our variable; then we are evaluating 2 + 2; then we are copying the value 4 into our location in memory.

The whole point of having a variable is so we store some data some where that we can transform.

```
void MyMosaicUpdate() {
  int32 x = 4;
  SetTileColor(x, 4, 1, 1, 1);
  x = x + 1;
  SetTileColor(x, 4, 1, 1, 1);
}
```

This may seem strange, and even non-sensical "we're defining x using x", but remember that when we use a variable what we're really using is the value that variable refers to; so when we say:

```
x = x + 1;
```

what we're doing is: take the value of x and add 1 to it; take the result of that expression and copy in into the place where x is stored. This changes the value that was stored at x to 1 greater than it was. 

This is such a common operation we have a shorter way to write it:

```
x += 2; // this is shorthand for x = x + 2;
x++; // x++ ---> x += 1 ---> x = x + 1;
```

You may be wondering "what is modulo?" Modulos gives you the remainder of one number divided by another. So 4 % 2 is 0, 9 % 2 is 1. We'll appreciate it's utility soon.

Here's an example using multiple operators:

```
void MyMosaicUpdate() {
  int32 x = 0;
  SetTileColor(x, 4, 1, 1, 1);
  x += 1; // x is 1
  SetTileColor(x, 4, 1, 1, 1);
  x *= 2; // x is 2
  SetTileColor(x, 4, 1, 1, 1);
  x = x * x; // x is 4
  SetTileColor(x, 4, 1, 1, 1);
  x--; // x is 3
  SetTileColor(x, 4, 1, 1, 1);
}
```

Of course you can have more than one variable in a program, and you can any variable in an expression. 

```
void MyMosaicUpdate() {
  int32 x = 0;
  int32 y = 4;
  SetTileColor(x, y, 1, 1, 1);
  // This isn't saying that x and y refer to the same thing,
  // it's just copying the value of y into x. If y changes
  // that will not change the value of x. 
  x = y;
  SetTileColor(x, y, 1, 1, 1);
  y--;
  SetTileColor(x, y, 1, 1, 1);
  y = y + x;
  x = 0;
  SetTileColor(x, y, 1, 1, 1);
}
```

Note that before you can use a variable you must first declare it. For example if you had moved line 3 below line 4 you would get an error. 

Here is a list of data types in C++, and I define differently sized variants for them (this is useful because we don't always want to use 32 bits for example if we know our number is never larger than 255).

integer: int64, int32, int16, int8
unsigned integer: uint64, uint32, uint16, uint8
floating point real number: float32/real32, float64/real64

There are more types that that which we'll learn about soon, and we'll be making our own types too, but that should get us started.