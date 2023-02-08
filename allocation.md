# Allocation

Sometimes we refer to a chunk of memory that we've allocated as a buffer. It is essentially just like an array, except that sometimes we might store things of different types there. 

void *data = malloc(64);

This allocates 64 bytes. I could fill it with numbers if I wanted. Or maybe I'd put one struct that's 20 bytes, and another that's 44.

If I want to access a particular part of the memory I'll need to do pointer arithmetic. 

First I cast the pointer to an unsigned 8 bit integer so I can do arithmetic on it. 

~~~
void *offsetData = ((u8 *)data) + offset_in_bytes;
~~~



If I know the type of thing in data I could instead cast it to a pointer of that type and index it just like an array.

`((int32 *)data)[index]`

This is the same thing as: 
`((u8 *)data) + sizeof(int32) * index`

I can use memcpy to copy over a block of memory into my pointer

```
int32 number = 10;
memcpy(data, &number, sizeof(int32));
```

This will copy over 4 bytes, starting at the address of number, into the beginning of data.

I might not want to copy it into the beginning of data, in which case I could do this:

```
void *offset = ((u8 *)data) + offset_in_bytes;
memcpy(offset, &number, sizeof(int32));
```

Or using the casting ideas we've seen (assuming that this is a buffer of int32s)

```
memcpy(((int32 *)data)[index], &number, sizeof(int32));
```

This is the same thing as saying

```
((int32 *)data)[index] = number;
```

However we could do much bigger bulk transfers tho. If we had a buffer like

```
void *dataA = malloc(128);
void *dataB = malloc(128);
```

I could say:

```
memcpy(dataA, dataB, 128);
```

Which would copy 128 bytes from B into A. Or I could say

```
memcpy(dataA, (u8 *)dataB + 64, 64);
```

which would copy the last 64 bytes of B into the first 64 bytes of A.

If you're making a buffer and you know the type, simply cast the pointer returned from malloc;

```
int32 *numbers = (int32 *)malloc(sizeof(int32) * capacity);
```

Now that you know the type of the buffer you can use it just like an array (cause that's what it is essentially).