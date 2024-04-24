  When you have a file that you want to read into your program you need to parse the file. For example you may have a file with a simple mapping from a character to a type of entity in your game. So the file:
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

So now you need somehow read the contents of the file and know that each pair of numbers in parentheses represents the position of an object. 

If we were operating on this file a character at a time things could quickly get out of hand, and would get even gnarlier the more complex the data we need to represent is.

To handle this complexity we introduce the idea of "tokenization", a process where instead of breaking our file into individual characters we break it into "tokens" such as "left-paren", "integer", "identifier". Once we have a list of tokens we can more easily parse the file by looking at the types of the tokens and determining what to do.


In this example we have 5 token types. We'll use an enum to represent our token types.

```
enum TokenType {
  TokenType_LeftParen,
  TokenType_RightParen,
  TokenType_Pound,
  TokenType_Integer,
  TokenType_Identifier
};
```

The token itself needs to store its type, along with a pointer to the string contents and the length of the token.

@TODO: write functions showcasing consuming tokens matching a certain string or of a certain type

```
struct Token {
   TokenType type;
   char *start;
   int32 length;
};
```

Instead of copying a string for the token we use the pair of the pointer and its length so that we simply index into the file. This saves us a lot of unecessary allocations, the only caveat is the tokens are only valid while the file is open. 

```
void ReadFile() {
    DynamicArray<Token> tokens = MakeDynamicArray<Token>(&Game->frameMem, 100);
    File file = {};

    if (!OpenFileForRead("data/my_test_file.txt", &file)) {
        return;
    }
    
    while (file.offset < file.size) {
        char c = ReadChar(&file);

        Token t = {};
        t.start = (char *)&file.data[file.offset];
  
        if (c == '(') {
            t.length = 1;
            t.type = TokenType_LeftParen;
        }

        while (IsLetter(c)) {
            t.type = TokenType_Identifier;
            t.length++;
            c = ReadChar(&file);
        }

        PushBack(&tokens, t);
    }
    
    // parse the tokens
    int32 tokenIndex = 0;
    while (tokenIndex < tokens.count) {
       Token t = tokens[tokenIndex];
    }

    CloseFile(&file);
}
```
