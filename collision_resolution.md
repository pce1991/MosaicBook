Let's say you have two positions and you want to prevent them from occupying the same space. We can use TilePositionsOverlap to detect a collision sure, but how do you fix it? One approach is to see what direction you moved when the collision happened. If you moved to the left when you collided then you know you must need to move to the right to fix the collision. 

Another option is to leverage some information. You know that you always end a frame with a valid position, so whenever a collision happens you can reset to the position of the previous frame (or put another way you can reset your position to it's value at the start of the frame).

