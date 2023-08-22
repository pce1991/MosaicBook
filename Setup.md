You will need to download Visual Studio Community Edition 2022. 

Install the C++ workload. You can find instructions on doing this [here](https://learn.microsoft.com/en-us/cpp/build/vscpp-step-0-installation?view=msvc-170)

When you download the Mosaic game engine you can unzip the directory wherever you like. Then navigate to that directory in the explorer and open the "command_prompt" file. There are a few versions of this file depending on the configuration of Visual Studio, so if one of them doesn't work try opening the others. If it works you should see a window pop up with text that starts with a bunch of asterisks and then something like:

```
Visual Studio Developer Command Prompt
vcvarsall.bat Environment initialized for: 'x64'
```

If intsead you just see "the system cannot find the path specified" try opening up one of the other command prompts.

This command prompt is going to one of our main interfaces with the game engine. 

We have a basic work flow to run the engine that we will be using through out the course. 
1) Write some code in C++
2) Compile that code to create an executable program the computer can run
3) Check for errors in creating the executable, jumping back to step 1 if needed.
4) Run the executable
5) Close the executable (if you try to compile while the exe is open you'll get an error and it can't compile successfully)

Well we don't know how to write C++ code yet, so let's skip that and jump to step 2. Luckily there is some code I have already written for you, and it shouldn't produce any errors. So to compile our program in the command prompt you'll type:

```
win_compile.bat
```

And then hit return. If all goes well a bunch of text will get spat out, and there will be a new directory in your Mosaic folder titled "build". Now you can run this command in the command prompt:

```
build\game.exe
```
A window should open showing a grey background, a black canvas, and a colored square in the top left. Congratulations, you just successfully compiled your first program! You're gonna be doing it a lot from now on! In the next section you'll learn how to write some code to get this to display something other than this one square. But remember, everytime you modify your code, make sure to compile it so that the executable is created from the current version of your code. 
