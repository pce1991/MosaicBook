# Conditionals

So far our programs have have been processes that change over time, but we've been missing a key ability: for our program to make decisions. We call a making a decision about whether code runs or not a "conditional". All sorts of programs require the conditionals, but the reason they're crucial to interactive programs is because we want to respond to input: "if this key is pressed do this"

Let's look at another process that happens over time: cooking. There is a linear sequence of instructions to carry out when cooking but there are also decisions that have to be made. When a recipe says "heat the oven to 400 degrees" it means "don't put the cake in the oven until it's 400 degrees inside."

Conditionals produce discrete changes

The most basic type of conditionals is the "if statement." An if statement has two parts, a "condition" and a "body" which is a block of code that will only run if the condition "is satisfied" (meaning "if it is true"). 

```
if (<boolean expression>) {
     // code that only runs if the expression is true
}
```

So what is a boolean expression? Just like the arithmetic expressions we've seen, a boolean expression is a sequence of operations that reduce to a single value when fully evaluated. The value they reduce to is called a "boolean", which is a type that is either _true_ or _false_. 

```
if (true) {
     SetTileColor(4, 4, 1, 0, 0);
  }
```

This is not much of an expression because it is always going to be true. 

```
if (false) {
     SetTileColor(4, 4, 1, 0, 0);
     SetTileColor(4, 5, 1, 0, 0);
     SetTileColor(4, 6, 1, 0, 0);
  }
```

This code is never going to run because the expression is false. 

Just like we did for ints and reals we have a data type that can store a boolean value; it's name is fittingly "bool".

```
bool flag = false;
  if (flag) {
     SetTileColor(4, 4, 0, 1, 0);
     flag = false;
  }
  else {
     flag = true;
  }
  if (flag) {
     SetTileColor(5, 4, 0, 1, 0);
  }
```

Modify this code so that flag starts out as false. 

Now that isn't particularly interesting or powerful; all we're doing is manually saying what code we want to run. 

So let's introduce our "boolean operators" which we can use to create expressions that will evaluate to either true or false based on the parameters of the equation.

The first operator we'll look at is "greater than", written <, which evaluates to true if the left hand side is greater than the right hand side. We'll use our variable "Time" so that we can see how our equation evaluates differently as our program runs. 

```
if (Time > 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
```

Our program runs for 1 second before we run the code inside the if statement. 

Naturally we also have "greater than or equal", "less than", and "less than or equal".

```
// If we only used less than and greater than then we'd potentiall have one frame where
// neither condition is true and we don't set our tile. This gives us total coverage. 
  if (Time <= 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
  if (Time > 1.0f) {
     SetTileColor(4, 4, 0, 1, 0);
  }
```

Because time only increases this boils down to "if time is <= 1, set the color to red, otherwise set the color to green". We have another way to express this kind of condition in C++ using an "else" statement.

An else statement has a body like an if, but it doesn't have a boolean expression; it always runs if the condition in the if statement above evaluated to false. 

```
if (Time <= 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
  else {
     SetTileColor(4, 4, 0, 1, 0);
  }
```

An else statement must immediately precede an if statement. It cannot go on it's own because there is no condition above it to base its evaluation on. 

There is another type of conditional called the "else if" statement, which does take a boolean expression like the if, but it only checks that boolean expression if the conditional above it failed. 

```
if (Time <= 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
  else if (Time <= 2.0f){
     SetTileColor(4, 4, 0, 0, 1);
  }
  else {
     SetTileColor(4, 4, 0, 1, 0);
  }
```

The second conditional will only be evaluated if Time <= 1.0f evaluates to false. We see you can put an else after a else if; we sometimes call this the "default" or "fallback" case; meaning we want the code to run if none of our conditions were satisfied. 

Like else statements, an else if must be preceded by either an if, or an else if. Unlike else statements they can be stacked indefinitely. 

```
if (Time <= 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
  else if (Time <= 2.0f){
     SetTileColor(4, 4, 0, 0, 1);
  }
  else if (Time <= 3.0f){
     SetTileColor(4, 4, 1, 0, 1);
  }
  else if (Time <= 4.0f){
     SetTileColor(4, 4, 0, 1, 1);
  }
  else {
     SetTileColor(4, 4, 1, 0, 0);
  }
```

That's interesting, but note that eventually the program will reach an end state where you have satisfied the last condition and there is nothing left to do. But what if we wanted to create a looping where after we reach the end we start at the beginning?

Instead of relying on the global time we're going to use conditions to reset a timer when we have reached a certain limit. What we'll do is add the deltaTime to our timer every frame, and then when it becomes >= 4 we'll reset the timer.

```
real32 timer = 0;
void MyMosaicUpdate() {

   if (Time <= 1.0f) {
     SetTileColor(4, 4, 1, 0, 0);
  }
  else if (Time <= 2.0f){
     SetTileColor(4, 4, 0, 0, 1);
  }
  else if (Time <= 3.0f){
     SetTileColor(4, 4, 1, 0, 1);
  }
  else if (Time <= 4.0f){
     SetTileColor(4, 4, 0, 1, 1);
  }
  else {
     timer = 0;
  }
  timer += DeltaTime;
} 
```

