

## Warmup
Here is an exercise you can do to practice for the assignments and get some extra credit. The exercises I post are meant to be completed before the assignment, so this one is to complete before assignment 2. You can get 10 points extra credit for completing it, but the goal is really to give you some practice in isolation that will help you build the larger projects. 

1. Create a struct to store the position, color, and the time an object was hit.
2. Create an instance of this object by giving it a position and rendering it with the color you provide. When rendered the object should be 2x2.
3. Now create a player character that can move around using the arrow keys. The player should be 1x1
4. When the player collides with the object (look into axis aligned bounding boxes on the notes), then change the color of the object. Make sure that the two objects don't actually overlap when they're rendered. Make sure that when you calculate the min and max positions of the bounding boxes you factor in the size of the objects. Think about how you would detect a collision using the min and max positions of the two boxes. 
5. Once that's completed instead of just setting the color, record the time that the object was hit. Now every frame lerp from a "default color" to a "hit color", based on the time since it's been hit. You should go back from "hit color" to "default color" once enough time has passed. 

## Lists

1. Create a player that can move smoothly using the arrow keys. 
2. Create an object that follows the player by looking at the normalized direction between them and then move towards the player at some speed. Make sure the object doesn't ever stand on top of the player. 
3. Change the color of the object based on the distance to the player. 
4. Create an array of multiple objects that all have the same behavior where they follow the player.
5. Create a different list of objects where the first one follows the player, second one follows the first object, third one follows the 4 object, and so on. They should all stop when they get within two units of their target. 

## Incremental Movement
Create an object that is 2 units tall and 8 units wide. Create another object that's 1x1 unit, traveling up that should collide with that object by moving it at a given velocity. Instead of doing all of the movement of that object in the same frame, do it in several steps based on how fast it's moving. You should do 2 steps per one unit of movement, so if it's moving with a speed of 3.5 units, you'll perform that movement in 7 steps. 

See that when you don't break your movement into steps the object could potentially "tunnel" thru the wall when it's moving too fast. This is why we break down the movement.

Hint: use Normalize to find the direction an object is traveling, and Length to determine how fast it's moving. 

## Fixed-step Update
Use a fixed time step like described in this article: https://gafferongames.com/post/fix_your_timestep/

This means each frame you may perform multiple simulation steps at your fixed rate rather than the rate of rendering. This is a very common approach to make robust physics and collision in games. Your game could run at 60 hz but update the physics at 120 hz. When updating the position of objects in your program use the fixed delta time instead of DeltaTime. Notice that this is a very similar idea to Exercise 3. 

## Arrays
Create DynamicArrays for all these exercises. For each one write a function so that it's easy to call the function and print the results, like on a key press. Create a global array of 100 random integers between 0 and 1000.

1. Create a copy of the global array.
2. Search the global array for the largest integer and print out its index and value.
3. Search the array for the least value and print it along with the index in the array.
4. Search the array and print the sum of all the elements. 
5. Search the array and print the average value. 
6. Create an array that has only the values greater than 500.
7. Create a copy of the global array that's reversed.
8. Create a copy of the global array that contains those integers sorted from greatest to least (this is called an "insertion sort")

```

```
