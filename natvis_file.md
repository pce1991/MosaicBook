It's possible to create custom inspectors for data structures like our DynamicArray in Visual Studio. There is a file in the `natvis` directory called DynamicArray.natvis.

This will give us a nice view of the DynamicArray in the watch window when debugging. 

To enable it when you have your sln open in Visual Studio, select the solution in the Solution Explorer. Then go to Project->Add Existing Item and select `natvis/DynamicArray.natvis` from the file explorer. You'll need to restart visual studio, but the next time you're debugging you can look at the DynamicArray in the watch window and see a list of all the elements. 