A very powerful approach to designing good systems is to let the data drive the behavior. 

Particle emitters are a good example. One approach would be to write code for each type of particle behavior you want, which means you'll need to be writing functions that control the rate they spawn, and how they update after they're spawned. The other approach is to let your data define the behavior of your system. 

```
void UpdateFireEmitter() {
   float32 timeSinceSpawn = Time - emitter.lastTimeSpawned;
   if (timeSinceSpawn > 0.1f) {
   	  // add a particle and set its color to an orangish red
   }
   // loop over the particles and set their velocities to move up and to the sides
}
```

Versus

```
void UpdateParticleEmitter() {
       float32 timeSinceSpawn = Time - emitter.lastTimeSpawned;
       if (timeSinceSpawn >= emitter.spawnRate) {
          // add particles by using data in the emitter to determine their
          // starting color and velocity
       }
       
       // just iterate over your particles and update their position/color/etc
       // according to data on the emitter
}
```

