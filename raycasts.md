```
struct Brick {
    vec2 position;
    vec2 dimensions;

    vec4 color;
    
    bool destroyed;
    real32 timeDestroyed;
};

const int32 BrickCapacity = 100;
int32 BrickCount = 0;
Brick bricks[BrickCapacity];

int32 Width = 116;
int32 Height = 64;

void SpawnBrick(vec2 position) {
    Brick brick = {};
    brick.position = position;
    brick.dimensions = V2(5, 2);
    brick.color = V4(0.8f, 0.4f, 0.3f, 1.0f);

    if (BrickCount < BrickCapacity) {
        bricks[BrickCount] = brick;
        BrickCount++;
    }
}

void MyMosaicInit() {
    SetMosaicGridSize(Width, Height);

    for (int i = 0; i < 20; i++) {
        vec2 pos = V2(RandiRange(0, 40),
                      RandiRange(0, 40));
        SpawnBrick(pos);
    }
}


void MyMosaicUpdate() {
    vec2 rayOrigin = V2(20 * ((1 + sinf(Time * 0.5f)) * 0.5f), 40);
    vec2 rayDir = V2(0, -1);

    {
        real32 closestDist = 99999999;
        int32 closestBrickIndex = -1;

        real32 maxDist = 20;
        
        for (int i = 0; i < BrickCount; i++) {
            vec2 brickMin = bricks[i].position;
            vec2 brickMax = brickMin + bricks[i].dimensions;

            real32 t = 0;
            // &t means "take the memory address of t", so we're turning it from a value
            // into the a memory address.
            // This is sometimes called "passing t by reference" whic is really just saying
            // that we are sharing access to one of our variables with RaycastAABB so that
            // it's able to write into it.
            // Since our functions can't return multiple values this is a way that we can
            // get our functions to mutate multiple pieces of data. Here RaycastAABB is
            // going to return true if it hit something, and write into the value of t to tell
            // us _where_ it hit.
            if (RaycastAABB(brickMin, brickMax, rayOrigin, rayDir, &t)) {
                //vec2 pointHit = rayOrigin + rayDir * t;

                if (t > maxDist) {
                    continue;
                }

                real32 dist = t;

                if (dist < closestDist) {
                    closestDist = dist;
                    closestBrickIndex = i;
                }
            }
        }

        if (closestBrickIndex >= 0) {
            if (!bricks[closestBrickIndex].destroyed) {
                bricks[closestBrickIndex].timeDestroyed = Time;
                bricks[closestBrickIndex].destroyed = true;
            }
        }
    }

    //Print("Brick Count %d, ", BrickCount);

    for (int i = 0; i < BrickCount; i++) {
        vec2 pos = bricks[i].position;

        if (bricks[i].destroyed) {
            //continue;
            bricks[i].color = V4(1, 0, 0, 1);
        }

        for (int y = 0; y < bricks[i].dimensions.y; y++) {
            for (int x = 0; x < bricks[i].dimensions.x; x++) {
                SetTileColor(pos.x + x, pos.y + y, bricks[i].color.r, bricks[i].color.g, bricks[i].color.b);
            } 
        }
    }

    SetTileColor(rayOrigin, V4(0, 1, 1, 1));
}
```
