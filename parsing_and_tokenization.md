Â  When you have a file that you want to read into your program you need to parse the file. For example you may have a file with a simple mapping from a character to a type of entity in your game. So the file:
```
*****
*@..*
*****
```

You may interpret an asterisk as a wall, a period as empty space, and the at sign as the player.

Often tho we have more complicated files where a direct 1:1 mapping is not possible. For example you may need to store a list of positions of where an object is in a level. Your file may look like this:

```
#objects
(2 4)
(4 6)
(7 8)
```

So now you need somehow read the contents of the file and know that each pair of numbers in parentheses represents the position of an object.Â 

If we were operating on this file a character at a time things could quickly get out of hand, and would get even gnarlier the more complex the data we need to represent is.

To handle this complexity we introduce the idea of "tokenization", a process where instead of breaking our file into individual characters we break it into "tokens" such as "left-paren", "integer", "identifier". Once we have a list of tokens we can more easily parse the file by looking at the types of the tokens and determining what to do.


In this example we have 5 token types. We'll use an enum to represent our token types.

```
enum TokenType {
Â  TokenType_LeftParen,
Â  TokenType_RightParen,
Â  TokenType_Pound,
Â  TokenType_Integer,
Â  TokenType_Identifier
};
```

The token itself needs to store its type, along with a pointer to the string contents and the length of the token. We can store a pointer instead of needing to copy the string from the file for each token. Keep in mind this means a


```
struct Token {
Â  Â TokenType type;
Â  Â char *start;
Â  Â int32 length;
};
```

Instead of copying a string for the token we use the pair of the pointer and its length so that we simply index into the file. This saves us a lot of unecessary allocations, the only caveat is the token's pointer are only valid while the file is open since the data will go away when you close it. You can always copy the strings from the file if you need them outside the lifetime of the file (for example you won't need the string representing positions, but you might want to store the level's name). 

```
void ReadFile() {
Â  Â  DynamicArray<Token> tokens = MakeDynamicArray<Token>(&Core->frameMem, 100);
Â  Â  File file = {};

Â  Â  if (!OpenFileForRead("data/my_test_file.txt", &file)) {
Â  Â  Â  Â  return;
Â  Â  }
Â  Â Â 
Â  Â  while (file.offset < file.size) {
Â  Â  Â  Â  char c = ReadChar(&file);

Â  Â  Â  Â  Token t = {};
Â  Â  Â  Â  t.start = (char *)&file.data[file.offset];
Â Â 
Â  Â  Â  Â  if (c == '(') {
Â  Â  Â  Â  Â  Â  t.length = 1;
Â  Â  Â  Â  Â  Â  t.type = TokenType_LeftParen;
Â  Â  Â  Â  }

Â  Â  Â  Â  while (IsLetter(c)) {
Â  Â  Â  Â  Â  Â  t.type = TokenType_Identifier;
Â  Â  Â  Â  Â  Â  t.length++;
Â  Â  Â  Â  Â  Â  c = ReadChar(&file);
Â  Â  Â  Â  }

Â  Â  Â  Â  PushBack(&tokens, t);
Â  Â  }
Â  Â Â 
Â  Â  // parse the tokens
Â  Â  int32 tokenIndex = 0;
Â  Â  while (tokenIndex < tokens.count) {
Â  Â  Â  Â Token t = tokens[tokenIndex];
Â  Â  }

Â  Â  CloseFile(&file);
}
```
