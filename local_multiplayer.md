In this assignment you'll make a simple local multi-player game and get familiar with the approach that you'd want to take for a networked game. 

In a networked game it's very helpful to use a transaction system to update your game data. For example if a player spawns a projectile, instead of sending over all the data for that projectile over the network, you could just send a transaction that says "spawn a projectile at this position."

So in this game you'll want to create a basic multiplayer game and use transactions. Think of it like this: you'll look at your input and then issue "move transactions" based on the input, and those transactions are what will actually be processed to update the state. A template of a transaction:

```
enum TransactionType {
  TransactionType_Move,
};

struct Transaction {
  TransactionType type;
  vec2 direction;
  // some other data
};
```

You can use a union in your struct to save space as your transactions start to get unique data. 

This approach is useful for a couple reasons:

1) It turns a "loose" structure into a "formal" structure where you simulate the game entirely from a list of transactions. 
2) It's easy to reproduce game state because a list of transactions should always perform the same operation (think of it like a recording).
3) The difference between a player and any other entity dissolves. An AI simply generates its move transactions differently than the player does, but once you start simulating, they're the same. 

