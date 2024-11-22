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
4. loader









what did I have an affinity for as a kid?