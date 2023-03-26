Playing sounds:

```
SoundClip sound;

void MyMosaicInit() {
    // you can add your own wav files to the data/sfx directory
    LoadSoundClip("data/sfx/flute_breathy_c4.wav", &sound);
}

void MyMosaicUpdate() {
   if (InputPressed(Keyboard, Input_Space)) {
       // <audio player>, <sound clip>, <volume>, <loop>
        PlaySound(&Game->audioPlayer, sound, 1.0f, false);
   }
}
```

