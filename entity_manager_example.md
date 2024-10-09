```
// Manual can be found here:
// https://github.com/pce1991/MosaicBook#readme

// https://github.com/pce1991/Mosaic/blob/master/src/entity.h
#include "entity.h"

// You can add add define your own entities here.
// All your definitions must appear here before entity.cpp as we need to know
// the size of each struct when we allocate the EntityManager.
// Just make sure that you add a type in entity.h and add the size to the EntitySizeTable
struct Player : Entity {
};

// https://github.com/pce1991/Mosaic/blob/master/src/entity.cpp
#include "entity.cpp"

struct MyData {
    Sprite sprite;

    MemoryArena arena;
    EntityManager em;

    EntityHandle firstEntitySpawned;
};

MyData Data = {};

void MyInit() {
    // All sprites must be png files
    // You provide the path to the png like "directory/to/my/file/file_name.png"
    // In this case I have put the pngs inside the "data" directory.
    LoadSprite(&Data.sprite, "data/galaga_ship.png");

    AllocateMemoryArena(&Data.arena, Megabytes(64));

    int32 *entityTypeCounts = PushArray(&Game->frameMem, int32, EntityType_Count);
    entityTypeCounts[EntityType_Entity] = 100;

    AllocateEntityManager(&Data.em, &Data.arena, 1024, entityTypeCounts);

    for (int i = 0; i < 10; i++) {
        Entity entity = {};
        entity.position = V2(i * 0.5f, 0);
        EntityHandle h = AddEntity(&Data.em, Entity, &entity);

        if (i == 0) {
            Data.firstEntitySpawned = h;
        }
    }
}


vec2 position = V2(4, 0);

vec2 scale = V2(1, 1);

void MyGameUpdate() {
    // This sets the background color. 
    ClearColor(RGB(0.0f, 0.0f, 0.0f));

    if (InputPressed(Keyboard, Input_Space)) {
        EntityTypeStorage *storage = &Data.em.entities[EntityType_Entity];

        if (storage->array.count > 0) {
            int32 index = RandiRange(0, storage->array.count);
            Entity *entity = AccessEntity(storage, Entity, index);
            DeleteEntity(&Data.em, entity->handle);
        }
    }

    // Hacky way to do this but just demonstrating that GetEntity works
    if (InputPressed(Keyboard, Input_Tab)) {
        Entity *entity = GetEntity(&Data.em, Entity, Data.firstEntitySpawned);
        entity->position = V2(RandfRange(-4, 4),
                              RandfRange(-3, 3));
    }

    {
        EntityTypeStorage *storage = &Data.em.entities[EntityType_Entity];

        for (int i = 0; i < storage->array.count; i++) {
            Entity *entity = AccessEntity(storage, Entity, i);

            DrawSprite(entity->position, V2(0.5f, 0.5f), &Data.sprite);
        }
    }

    // Delete all the entities at the end of the frame.
    // This way any stack-allocated pointers we have to an entity are still valid for the
    // duration of the frame.
    DeleteEntities(&Data.em);
}

```
