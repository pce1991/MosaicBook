In this assignment you'll get practice on multithreaded programming. You'll want to make sure that your threads start at a specified time, and that the main thread doesn't finish the frame's update until the threads are finished. 

To do this work use the my_game.cpp file by enabling it in game_code.cpp. 

Each of your threads should loop forever. It should have a flag that is only set from the main thread telling it to start working. It should have another flag that notifies the main thread when the work is completed. Each thread should have its own memory arena that it clears each iteration thru the loop. 

To show off the power of multithreading you'll implement some movement behaviors. How your objects move is up to you, but you should do the following:

1. Create the threads in the Init. 
2. Have one array of all your objects.
3. Have at least two threads that divide up the work for those objects. Each thread will iterate over some range of the objects.
4. Each from the objects will need to compute a velocity and update their position. 
5. Render all the objects on the main thread. 

Make at least 10,000 objects. 

You can read about different movement behaviors for "boids" in this paper to get some inspiration. https://www.red3d.com/cwr/papers/1999/gdc99steer.pdf You are not required to implement this exact behavior, just make sure you have objects that are moving around and updated in threads. 

Here's a sample program that uses the game's "rectBuffer" to render things more quickly. We'll talk more about what that is and why it makes things faster in future lectures. This way your performance isn't going to be bottlenecked by the rendering and you can focus on the multithreaded performance. 

```

MemoryArena arena = {};

struct Boid {
  vec2 position;
  vec2 velocity;
};

DynamicArray<Boid> boids;

void MyInit() {
  AllocateMemoryArena(&arena, Megabytes(8));

  boids = MakeDynamicArray<Boid>(&arena, 1000);

  for (int i = 0; i < 4000; i++) {
    Boid boid = {};
    boid.position.x = RandfRange(-8, 8);
    boid.position.y = RandfRange(-4, 4);

    PushBack(&boids, boid);
  }
}

void MyGameUpdate() {
  Print("%f", DeltaTime);
  
  vec2 size = V2(0.1f, 0.1f);
  vec4 color = V4(1, 1, 1, 1);
  for (int i = 0; i < boids.count; i++) {
    DrawRect(&Game->rectBuffer, boids[i].position, size, 0.0f, color);
  }
}

```

