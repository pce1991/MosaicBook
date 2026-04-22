At its core writing a file is just about copying some bytes in our program's memory into a file on disk so that it can be accessed by other programs (like exporting a model), or ourselves in a different session of our program (like loading a save game).

In mosaic we use this function to write a file: `bool OpenFileForWrite(char *path, FileHandle *file, MAllocator *alloc, uint32 size)`

```
FileHandle file = {};
if (OpenFileForWrite("data/test_file.txt", &file, &arena, Megabytes(4))) {

}
```



We have an allocator so that we have some where to put the data before we commit the memory to disk. 

It also provides a number of functions to let us write different types of data. If we want to write out binary data you can use the functions

```
void WriteByte(FileHandle *file, u8 byte);
uint64 WriteBytes(FileHandle *file, u8 *bytes, u64 count);
```

These are the backbones of file writing since at the end of the day all our data is binary, but we may use different encodings (for example whether we store an integer as it's 32 bit binary value, or we write out the ASCII encoding that's human readable).

There's a few other helper functions for writing out binary data:

```
void WriteInt32(FileHandle *file, int32 value);
void WriteFloat32(FileHandle *file, float32 value);
```

Writing binary data can be efficient, but its not very readable. For example it would be a pretty bad fit for a config file. You can write an ASCII string to disk using this function:

```
void WriteString(FileHandle *handle, char *str, uint32 len);
void WriteChar(FileHandle *file, char c);
```

All these functions can be found in `file_io.cpp`

Even in a binary file you may want to write a string, for example a binary save file might have the position of the character along with the name they entered. But how do you know how long the string is? You can first write out the length of the string followed by each character.

```
char *name = "Degran";
int32 nameLen = StringLength(name);

WriteInt32(&file, nameLen);
WriteString(&file, name, nameLen);
```

Of course if we're writing non-binary data what we want to do is convert that data into a string format and write that to disk. 

You can do this with the `sprintf` function provided by the C standard library. 

```int sprintf(char *str, const char *format, ...);```

The `str` argument is a pointer to the array of chars you're writing into. The `format` argument is like the format strings you've used when printing. It tells us what type of conversion we want to apply to the data. The `...` is a special symbol that is telling us this takes a "variadic" number of arguments (just like our `Print` function).

```
// write out an integer as a string
char numStr[8] = {};
// we clear out the array because strings are "null terminated", meaning
// that C expects a 0 value to denote where the string ends. 
// This can be quite a pain! This is why I have a custom string implementation
// in my engine. 

int32 number = 1001;
sprintf(numStr, "%d", number);

// this will write "1001" instead of the binary representation to the file. 
WriteString(&file, numStr, StringLength(numStr));
```

You have similar functions for reading binary data. 

```
// returns a single unsighed byte
u8 ReadByte(FileHandle *file);

// returns the number of bytes read and writes them out into ptr
uint64 ReadBytes(FileHandle *file, u64 count, void *ptr);

// reads 4 bytes and writes out into ptr
void ReadInt32(FileHandle *file, int32 *ptr);
void ReadReal32(FileHandle *file, real32 *ptr);
```

When you're reading a binary file and writing it into a struct, make sure that you read data in the correct order. 
