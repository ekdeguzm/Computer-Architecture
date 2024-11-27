Compilation Process
1. compiler
	translates high level code into assembly
	assembly type depends on cpu
	
2. assembler
	output of an assembler is an object file
	containing the segments: 
		header (table of contents)
		global data
		text
		relocation info
			blanks to fill in with RAM addresses
				eg: lw $t0, x -> lw $t0, ___
				branch instructions dont deal with absolute addresses
				they deal with offsets
				eg: branch to 3 instructions later than you wouldve
				
		symbol table
			"symbol" -> var or function name
				
	
	
3. linker
	combines data/text
	resolve undefined symbols 
	creates big file to execute
	executable is the file that the linker creates. In c++ it is called a.out
	Can customize the name of the file. 
	
4. loader
	Puts the finished product in RAM
	Sets up text, data, stack segments, and heap
	Sets the stack pointer to appropriate value
	Sets register program counter ($pc) to the appropriate value
		This is the address of the first instruction
		Now the next CPU cycle will execute and begin working up the program
	
Overall, this is high light 

know sections of the object file
What is relocation info? What is a symbol table?



what did I have an affinity for as a kid?
