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
	cmd_exit: .asciiz "exit"
	cmd_invalido: .asciiz "Comando Inválido"
	
	buffer: .space 50
	
	banner: .asciiz "pingas-shell>> "
	
	break_line_string: .asciiz "\n"
	

.macro break_line # macro para imprimir uma quebra de linha
	la $a0, break_line_string
	addi $v0, $0, 4
	syscall
.end_macro 

.macro fim_de_codigo # macro para finalizar a execução do código
	addi $v0, $0, 10
	syscall
.end_macro
	
.text

	main:
	
		la $a0, banner #imprime banner no terminal
		addi $v0, $0, 4
		syscall
	
		la $a0, buffer  #armazena a string escrita pelo usuário
		addi $a1, $0, 50
		addi $v0, $0, 8
		syscall

		move $s0, $a0 #String do usuário armazenada em $s0
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_1 #carrega o cmd_1 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_1_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_2 #carrega o cmd_2 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_2_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_3 #carrega o cmd_3 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_3_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_4 #carrega o cmd_4 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_4_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_5 #carrega o cmd_5 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_5_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_6 #carrega o cmd_6 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_6_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_7 #carrega o cmd_7 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_7_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_8 #carrega o cmd_8 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_8_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_9 #carrega o cmd_9 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_9_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_10 #carrega o cmd_10 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_10_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_11 #carrega o cmd_11 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_11_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_12 #carrega o cmd_12 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_12_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_13 #carrega o cmd_13 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_13_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_14 #carrega o cmd_14 para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_14_true #se comandos forem iguais, pular para operação determinada
		
		move $a1, $s0 #String do usuário movida para $a1
		la $a0, cmd_exit #carrega o cmd_exit para $a0
		jal strcmp #compara string do usuário com do comando salvo
		beq $v0, $0, cmd_exit_true #se comandos forem iguais, pular para operação determinada
		
		la $a0, cmd_invalido #caso comando não se encaixe em nenhum dos códigos acima, imrpime "Código Inválido"
		li $v0, 4
		syscall
		break_line
		j main
		
		cmd_exit_true:
		fim_de_codigo
		
		cmd_1_true: #Comando "cardapio_ad"
			li $a0, 1
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_2_true: #Comando "cardapio_rm"
			li $a0, 2
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_3_true: #Comando "cardapio_list"
			li $a0, 3
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_4_true: #Comando "cardapio_format"
			li $a0, 4
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_5_true: #Comando "mesa_iniciar"
			li $a0, 5
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_6_true: #Comando "mesa_ad_item"
			li $a0, 6
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_7_true: #Comando "mesa_rm_item"
			li $a0, 7
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_8_true: #Comando "mesa_format"
			li $a0, 8
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_9_true: #Comando "mesa_parcial"
			li $a0, 9
			li $v0, 1
			syscall
			break_line
			j main
		
		cmd_10_true: #Comando "mesa_pagar"
			li $a0, 10
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_11_true: #Comando "mesa_fechar"
			li $a0, 11
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_12_true: #Comando "salvar"
			li $a0, 12
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_13_true: #comando "recarregar"
			li $a0, 13
			li $v0, 1
			syscall
			break_line
			j main
			
		cmd_14_true: #comando "fechar"
			li $a0, 14
			li $v0, 1
			syscall
			break_line
			j main

		
		
		#comparador de strings
strcmp:
	move $t0, $a0       # Salva o endereço da String 1
	move $t1, $a1       # Salva o endereço da String 2
loop_strcmp:
	lb $t2, ($t0)      # Carrega um byte da String 1
	lb $t3, ($t1)      # Carrega um byte da String 2
	beq $t3, 45, end_strcmp
	beq $t2, $t3, check_next_char  # Se os bytes são iguais, verifica o próximo caractere
	sub $v0, $t2, $t3  # Calcula a diferença entre os caracteres
	jr $ra  # Retorna com o resultado
check_next_char:
	addi $t0, $t0, 1   # Move para o próximo caractere na String 1
	addi $t1, $t1, 1   # Move para o próximo caractere na String 2
	j loop_strcmp      # Repete o loop
end_strcmp:
	beqz $t2, true #verifica se a string da memória foi lida por inteiro, se não, a função retornará "1"
	li $v0, 1
	jr $ra
	true:
	li $v0, 0         # Define o resultado como 0 (strings são iguais)
	jr $ra             # Retorna
