Enums are a conveinent way to create a new type of data that represents a set of possible values. For example you might have a player character that can be in some number of states like "idle, running, jumping, and falling". You could of course use an integer to represent that data, but that can be rather opaque. Instead you could create a type PlayerState which is known to only have the values that you "enumerate."

```
enum PlayerState {
 PlayerState_Idle,
 PlayerState_Running,
 PlayerState_Jumping,
 PlayerState_Falling,
};

PlayerState state = PlayerState_Idle;

// inside update ....
if (state == PlayerState_Idle) {
 // do this
}
else if (state == PlayerState_Running) {
 //do that
};
```

So rather than having an int which could be any number you have a variable of type PlayerState which you know can only be one of those 4 values, and the code is more clear because instead of writing "state == 0" to mean idle you can just use the value PlayerState_Idle. 


You can also assign values to an enum. By default each enum value will be 1 greater than the previous value, but let's say you wanted to assign values going up by powers of 2 (this can be very useful as I'll explain later).



```
enum Flag {
  Flag_CanSpeak = 1,
  Flag_CanFight = 2,
  Flag_CanShop = 4,
  Flag_CanHeal = 8,
};
```

So now we have 4 possible values, each one is a greater power of 2. If we look at those values in binary we get:
0001
0010
0100
1000

A common way you'll see flags written is using the "left-shift" operator <<, which shifts the bits to the left.

| <<        | Result |
| --------- | ------ |
| 0001 << 1 | 0010   |
| 0001 << 2 | 0100   |
| 0001 << 3 | 1000   |
| 0100 << 1 | 1000   |

```
enum Flag {
  Flag_CanSpeak = 1 << 0,
  Flag_CanFight = 1 << 1,
  Flag_CanShop = 1 << 2,
  Flag_CanHeal = 1 << 3
};
```

Notice that each of those numbers simply has the 1 at a higher place. This means you can use binary arithmetic to create a value that is a combination of these enum values.

```
Flag flag = Flag_CanSpeak | Flag_CanShop;
```

Note that this is using a single | instead of the || we use for boolean logic. This operator simply takes two values and does a bitwise-or on each element, producing a final output that has a one in every bit that was 1 in either of the inputs. 

| A    | B    | Result |
| ---- | ---- | ------ |
| 0001 | 0010 | 0011   |

By doing a bit-wise or our flag value tells us that we're representing something that can speak and shop, but isn't able to heal or fight.

If we want to check if something has a flag we can use the & operator. 

Just like with booleans we also have the & operator which behaves how you would expect

| A    | B    | Result |
| ---- | ---- | ------ |
| 1111 | 0010 | 0010   |
| 0010 | 0001 | 0000   |

We can see that the result will be the bits that A and B have in common. So if they don't have any bits in common the result will be 0, otherwise we know that they must share some bits. So if we wanted to check our flag to see if the character was able to speak we could write it like: 

```
if ((flag & Flag_CanSpeak) > 0) {

}
```

