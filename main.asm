.data 

	itens_memoria: .space 400
	mesas_memoria: .space 4635
	cmd_1: .asciiz "cardapio_ad"
	cmd_2: .asciiz "cardapio_rm"
	cmd_3: .asciiz "cardapio_list"
	cmd_4: .asciiz "cardapio_format"
	cmd_5: .asciiz "mesa_iniciar"
	cmd_6: .asciiz "mesa_ad_item"
	cmd_7: .asciiz "mesa_rm_item"
	cmd_8: .asciiz "mesa_format"
	cmd_9: .asciiz "mesa_parcial"
	cmd_10: .asciiz "mesa_pagar"
	cmd_11: .asciiz "mesa_fechar"
	cmd_12: .asciiz "salvar"
	cmd_13: .asciiz "recarregar"
	cmd_14: .asciiz "formatar"
	
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
	
		la $a0, buffer  #armazena a string escrita pelo usuário
		addi $a1, $0, 50
		addi $v0, $0, 8
		syscall
		
		
		la $a0, cmd_1
		la $a1, buffer
		
		jal strcmp
		
		move $a0, $v0
		li $v0, 1
		syscall 
		
		 li $v0, 10 #exit
        syscall
		
		
		#comparador de strings
strcmp:
	move $t0, $a0       # Salva o endereço da String 1
	move $t1, $a1       # Salva o endereço da String 2
loop_strcmp:
	lb $t2, ($t0)      # Carrega um byte da String 1
	lb $t3, ($t1)      # Carrega um byte da String 2
	beq $t3, 45, end_strcmp
	beq $t3, 10, end_strcmp
	beq $t2, $t3, check_next_char  # Se os bytes são iguais, verifica o próximo caractere
	sub $v0, $t2, $t3  # Calcula a diferença entre os caracteres
	jr $ra  # Retorna com o resultado
check_next_char:
	beqz $t2, end_strcmp   # Se alcançar o terminador nulo, as strings são iguais
	addi $t0, $t0, 1   # Move para o próximo caractere na String 1
	addi $t1, $t1, 1   # Move para o próximo caractere na String 2
	j loop_strcmp      # Repete o loop
end_strcmp:
	li $v0, 0         # Define o resultado como 0 (strings são iguais)
	jr $ra             # Retorna

		
		
	
	
	
	
	







	
	








	
	
	
	
	

