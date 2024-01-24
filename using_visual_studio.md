To run your game thru Visual Studio for debugging you'll need to do the following:
1. Compile your program
2. Open Visual Studio
3. Select "open project/solution"
4. Select your game.exe
5. Select "save all" from the File dropdown. Save as "game.sln" outside the build directory (because build gets deleted each time you recompile)

From now on you can open your "game.sln" file in VS to run your program thru there. Keep in mind you'll still need to compile with the command prompt, but running thru VS will let you set breakpoints, catch asserts, and identify the line number when your program crashes, as well as see output from the Print command. 

You can use Ctrl-o to open your my_mosaic.cpp file in VS, then the cpp file will be opened each time you open your sln file. 
