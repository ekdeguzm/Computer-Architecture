# Print the index of the first 'a'.
#
# char* string = "banana";
# int main() {
#	int index = 0;
#	char* current = string; 		this is an address!
# 	while(true) {
#		if (*current == 'a') break;
#		if (*current == '\0') break;
#		current++; index++;
#	}
#	syscall1(index);
# }

	.data
	
	.text 
	.globl
main: