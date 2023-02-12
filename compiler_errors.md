
When compliing your code you may encounter errors that prevent the executable from being generated. The compiler will report error messages to you, and usually you can use the line number to find the file and location of the error. Here are some common errors you may encounter:

* "undeclared identifier" means that you are using a variable name that hasn't been declared. May also be caused by using a variable type that doesn't exist. This is commonly caused by a typo.

```
int32 number = 5;
void MyMosaicUpdate() {
  numbre += 1; // wrong name
  x += 1; // undeclared variable
}
```

* "Identifier not found" means you are using a function name that doesn't exist. For example "Inputpressed" instead of InputPressed.

```
void MyMosaicUpdate() {
   if (InputPresssed(Keyboard, Etc_Space)) {

   }  
}
```

* syntax error: missing ';' means you missed a semicolon on the line above where the error is reported.

```
void MyMosaicUpdate() {
   int32 x = 5
   Print("hellow."); // the error message will be on this line saying that it expected a semicolon before Print.
}
```

* A missing bracket or paretheses can cause a "cascading error" where the complier reports a ton of errors (often in other files). The reason is because there's a mismatch between the braces or parathentheses, so as it tries to match them it misinterprets which parts of the code belong to which scopes.
* "redefinition; previous definition was" this means you're declaring a variable that has already been declared. For example if you said "int32 number = 5; int32 number = 7;" You've just told the compiler "make 2 things called number and give them different values", but how can it know what "number" means now!

