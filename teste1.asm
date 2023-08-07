.data 

	itens_memoria: .space 400
	mesas_memoria: .space 4635
	
	buffer: .space 50
	
	banner: .asciiz "pingas-shell>> "
	
	break_line_string: .asciiz "\n"
	

.macro break_line
	la $a0, break_line_string
	addi $v0, $0, 4
	syscall
.end_macro 
	
.text

	main:
	
		la $a0, banner
		addi $v0, $0, 4
		syscall
	 
	loop:
	
		la $a0, buffer
		addi $a1, $0, 50
		addi $v0, $0, 8
		
	j loop
	
	
	
	







	
	








	
	
	
	
	

