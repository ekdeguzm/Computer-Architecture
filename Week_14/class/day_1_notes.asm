Exceptions

# all of these fall under the category of trap
# internal trigger
4/5 (MARS)
	page fault (bad virtual address exception) 
	MMU says you gave me an address but there is no virtual address 
	type of error that occurs when a program tries to access data that is not 
	currently in the main memory or random access memory (RAM
Out of Range, Out of Range
Type Error
Everytime you say syscall, that is an exception. Outcome is from doing something 

# Fall under category interrupt
# external trigger
Mouse click triggers exception
Key stroke triggers exception
Read from disk (read finishes) 

All above me OS (operating system), the OS takes over

Coprocessor 0 (extra cpu) it is an extra tool 
	has 4 registers 
	
	cause register (exception number)
		
	status register
		keeps track of to what extent interrupts have been disabled
		exists b/c, because from this time to this time, dont want to get interrupted
		
	exeption program counter (EPC)
		Holds copy of whatever the program counter was when the exception happens
		
	bad virtual address
		address you tried to access goes here 
		
		
Example:

lw	$t0, ($zero) 	you dont want to do this, address $zero not allowed. (this is a trap exception)
			cause register will have 4
			EPC will have the address in the text segment of which 
			the instruction lw .... came from, something in the 4 millions 
			bad virtual address will have all zeros
			
----	

Memory Hierarchy

Lw and sw are slow cause it deals with ram
Ram is a slower device, but can store billions of info
CPU can store small arount of info
Hard disk can store tons of info, but very very slow. 

Reading something from hard disk is slower than reading from ram. 

caches are miniture little rams that are way faster	
Putting info inside caches, can be accessed it sooner. 
Putting copies from registers into caches. 
Asking caches first, dont need to go to ram.

Everytime you do lw, asking the caches first, yes I have copy or no go to RAM. 
Time to ask caches is so so small	




Virtual Memory

Physical and Virtual Memory

Virtual memory, how programs think memory is stored, it is an idea


but break it up into pages
2 pages for stack
3 pages for .globl data
2 pages in . text segment

Physical memory is actually how programs happen within a computer 

Takes these pages and splits them up and puts them at random into physical memory




MMU - memory management unit
	listens to address that get issued by programs, 
	virtual address goes in
	physical address comes out
	
	268500992 goes in, translates it into the physical address 2 billion something
	those 32 bits get copied and pasted into the CPU
	The mmu keeps track of it
	
	How the ram can be used by multiple programs at the same time.
	
Now we have a second program


---
Lazy loading

OS intervenes, loads it, OS secretly finds a location in physical memory, copies into physical memory, go ahead and restart
MMU doesnt know that it happens, MMU suddenly has an entry





