# Warm-Up

Word bank: symbol, linker, loader, high-level, assembler, relocation, compiler, low-level, executable 

Once upon a time, there was a c++ program. C++ is a __1__ language. The program needed to be turned into an __2__ file to be run. 

First, a __3__ turned it into assembly code (a __4__ language). Then, a ___5____ turned the assembly code into an object file. 

Each jump instruction to an absolute address needed an entry in the object files ___6___ records. 

Any variables/functions defined in an outside file needed an entry in the objects files ___7___ table.

Finally, the ___8___ combined the object file with other object files and created a ___9____ 

file that the ___10___ would be able to put in RAM and run.

THE END


1. high-level
2. executable 	(not an object file, they cannot be run by themselves)
3. compiler
4. low-level
5. assembler
6. relocation 	Jumping to an absolute address, need to know where that address is. 
7. symbol
8. linker
9. executable
10.loader