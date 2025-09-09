When parsing you're just converting a string into some data your program can actually use, like a list of command nodes:

```
enum NodeType {
   NodeType_Identifier,
   NodeType_Number,
   NodeType_Operator,
   NodeType_If,
   NodeType_Else,
   NodeType_ElseIf,
   // ... some other types
};

struct CommandNode {
    NodeType type;

    // used for if statements to know how many things to evaluated
    int32 startOfExpression;
    int32 lengthOfExpression;
    
    // used for if statements to know which commands should execute
    // if the expression is satisfied.
    int32 startOfBlock;
    int32 lengthOfBlock;
    
    String identifierName;
    int numberValue;
};
```

Then with a list of those command nodes you do things like evaluate conditional checks. If you're parsing a file like this:

```
if (x < 5) {
}
else if (x < 10) {
}
else {
}
```

then you're going to get a list of commands you can execute. 

But obviously parsing that is non trivial cause you don't know how long your expressions are for example, or when you see "else" is it the start of "else if"? So if you're reading it character by character and trying to make decisions about how to interpret the data things get really gnarly because you have to read, then see if there's a space, and if the next character is an "i"; if it isn't then don't look further, but if it it is check the the character after that is an "f"; if you only got an "i" it's an error; but what if you got a "(", that's an error, you should have a "{", and so on. Blah! 

So the idea of tokenization is to do a pre-pass on your text before parsing and turn it from an array of characters into an array of tokens. A token is just a string + a type. So like `101 and 1001` are both integer tokens, we don't care that they're different numbers. 

```
struct Token {
   TokenType type;
   char *start;
   int32 length;
};
```

So the tokenization pass is something like:

```
char *nextCharacter = file.data[file.offset];
Token t = {.start = nextCharacter, .length = 0};
if (ConsumeIntToken(file, &t.length)) {
    t.type = TokenType_Integer;
}
```

`ConsumeIntToken` is something that'll just keep reading characters until it hits a non-number and writes out the number of characters read. You can imagine `ConsumeFloatToken` does something similar but has to handle a period, or exponential notation. You could also have `ConsumeLiteralToken(file, "match_this_string_exactly", &t.length)`. 

Now when you're doing your parsing you aren't making parsing decisions as you're reading, you can just say

```
while (tokenIndex < tokenCount) {
   Token t = tokens[tokenIndex];
   if (t.type == TokenType_ElseIf) {
     // you know the next token is the start of the expression
   }
   else if (t.type == TokenType_Else) {
      // you know there is no expression to parse. 
   }
}

```

There's lot of approaches to parsers, but if you're working with tokens it's much easier to parse the data and report errors. 