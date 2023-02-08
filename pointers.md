We know that when we make a variable we are telling the CPU that we need some memory of a certain size to store our data, and that our variable name can be used to give us the contents at that memory address, or we can copy new data into that address by using the assignment operator =. 

When we assign one variable to another we're simply copying over the data, we are not actually saying that the two things will remain equal.

~~~ 
int32 x = 5;
int32 y = x;
y = 100;
~~~

x has not changed it's value.

Whenever we pass a variable to a function we know that we're creating a new variable, and copying the data in, so in this case:

~~~
void Square(int32 n) {
   n = n * n;
}

int32 x = 5;
Square(x);
~~~
Square does not actually change the value of the variable x. All we've done is create a copy. But since our program is about transforming data, it is very useful if we're able to pass in the memory address of data instead of a copy. This is where pointers come in.

A pointer is a type, just like int32 or char, the difference is that a pointer stores a numerical value representing a memory address in RAM. 

A pointer is specified by giving a type, and the * symbol. 

int32* ptr;

The type is saying that this is a memory address that is pointing to an int32. All pointers are the same size, after all, we're just storing a memory address and what's stored there doesn't affect what the address is. 

The * can go on either side of the variable. These are both equivalent declarations.

~~~
int32* ptr;
int32 *ptr;
~~~
So how do we get the memory address of a variable? For that we use the & operator which operates on a variable and evaluates to its memory address.

~~~
int32 x = 5;
int32* ptr = &x;
~~~

Now ptr has been assigned the memory address of x. So we have the memory address, but how can we take a pointer and change the content of what's stored there? To do that we "dereference" the pointer by using the * operator.

The type-name of a pointer tells us what type of data is being stored there. There is another pointer type, "void*" which says it's simply a memory address and we can't assume anything about the data that it's pointing to. We'll see how this is useful in the next section.

~~~
*ptr = 100;
~~~
Now the value of x is 100, because ptr "refers" to x. The dereference operator is the inverse of the address operator. Instead of saying "give me the memory address" we say "give me the data at the memory address."

For example:

~~~
Print("address is %d, value is %d", ptr, *ptr);
~~~

So let's rewrite our Square function so that it actually changes the contents.

~~~
void Square(int32* n) {
   *n = *n * *n;
}
~~~
That's a lot of asterisks, I know. All we're doing tho is saying "set the value at this memory address to the value at this memory address times the value at this memory address." We could make it more readable:

~~~
void Square(int32* n) {
   int32 value = *n;
   *n = value * value;
}
~~~

This is the true value of pointers: it allows us to take one piece of data and pass it thru a series of functions that transform it. Remember, you can take a pointer of any variable, so you can use this with our basic data types, but also with structs. 

Whenever you pass in the contents of an array to a function what you'll be passing in is a pointer. Since a pointer is just a memory address, it doesn't say anything about how much data is stored after it, just what the type is. 

~~~
int32 numbers[100];

int32 ReturnLargest(int32* array, int32 count) {
   int32 largest = array[0];
   for (int i = 0; i < count; i++) {
	if (array[i] > largest) {
	  largest = array[i];
	}
   }
   return largest;
}
~~~

The default way that C/C++ handles strings are as pointers.

char* myName = "Collin";

