# Arquitetura e Organizacao de Computadores: 1VA
# Grupo: Anthony Guerra, Geraldo Goncalves, Paulo Veloso e Rodrigo Souza
# Projeto: Implementar um sistema de gerenciamento para um restaurante, operado atraves de um terminal que interpreta comandos de texto.

.data 

	itens_memoria: .space 400
	mesas_memoria: .space 4635
	tamanho_codigo_item: .byte 2
	tamanho_preco_item: .byte 5
	tamanho_descricao_item: .byte 13
	tamanho_item: .byte 20
	maximo_itens_cardapio: .byte 20
	contador_itens_cardapio: .byte 0
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
	
	codigo_invalido: .asciiz "Falha: código de item inválido"
	item_ja_cadastrado: .asciiz  "Falha: nome de item já cadastrado"
	item_adicionado_string: .asciiz "Item adicionado com sucesso"
	remocao_sucesso_string: .asciiz "Item removido com sucesso"
	cod_nao_cadastrado_string: .asciiz "Código informado não possui item cadastrado no cardápio"
	cardapio_apagado_string: .asciiz "Cardápio reiniciado com sucesso"
	
	erro_mais_que_12_string: .asciiz "O item deve ter no máximo 12 caracteres"
	
	buffer: .space 50
	
	banner: .asciiz "pingas-shell>> "
	
	break_line_string: .asciiz "\n"
	dash_string: .asciiz "-"
	passou_teste_string: .asciiz "Passou!"
	
	msg_lista_vazia_string: .asciiz "\nLista vazia!\n"
	
.macro break_line # macro para imprimir uma quebra de linha
	la $a0, break_line_string
	addi $v0, $0, 4
	syscall
.end_macro 

.macro print_dash # macro para imprimir uma quebra de linha
	la $a0, dash_string
	addi $v0, $0, 4
	syscall
.end_macro 

.macro passou_teste # macro para imprimir uma quebra de linha
	la $a0, passou_teste_string
	addi $v0, $0, 4
	syscall
	break_line
.end_macro 

.macro fim_de_codigo # macro para finalizar a execução do código
	addi $v0, $0, 10
	syscall
.end_macro

.macro print_int(%int)
	addi $v0, $0, 1
	add $a0, $0, %int
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
		
		comando_invalido:
		la $a0, cmd_invalido #caso comando não se encaixe em nenhum dos códigos acima, imrpime "Comando inválido"
		li $v0, 4
		syscall
		break_line
		j main
		
		erro_mais_que_12:
		la $a0, erro_mais_que_12_string #caso comando não se encaixe em nenhum dos códigos acima, imrpime "Comando inválido"
		li $v0, 4
		syscall
		break_line
		j main
		
		
		cmd_exit_true:
		fim_de_codigo
		
		cmd_1_true: #Comando "cardapio_ad"
		
			la $s1, itens_memoria #adiciona espaço reservado para itens em $s1
		
			addi $s0, $s0, 12 #vai para o <option 1> na string no usuário
			move $t5, $s0 #salva $s0 atual (sem o "cardapio_ad-") em $s2
			lb $t0, 0($s0) #carrega o primeiro byte da string(código do item)
			subi $t0, $t0, 48 #subtrai 48 do primeiro byte (transforma em decimal)
			lb $t4, 1($s0) #carrega o segundo byte da string(código do item)
			subi $t4, $t4, 48 #subtrai 48 do segundo byte (transforma em decimal)
			
			mul $t0, $t0, 10 #multiplica byte mais significativo por 10(ele será a dezena)
			
			add $t0, $t0, $t4 #adiciona primeiro com segundo byte

			addi $t1, $0, 1 #$t1 = 1
			slt $t2, $t0, $t1 #$t2 será 1 se $t0 < $t1
			bne $t2, $0, erro_codigo_invalido #se $t2 != 0, erro de código inválido
			addi $t1, $0, 21 #$t1 = 21
			slt $t2, $t0, $t1 #$t2 será 1 se $t0 < $t1
			beq $t2, $0, erro_codigo_invalido #se $t2 != 0, erro de código inválido
			
			addi $s0, $s0, 2 #vai para o "-" antes do <option 2> na string no usuário
			
			lb $t0, 0($s0) #carrega o próximo byte em $t0
			
			bne $t0, 45, comando_invalido #se próximo byte não for "-", comando é invalido
			
			addi $s0, $s0, 1 #vai para o <option 2> na string do usuário
			
			add $t0, $0, $0 #acumulador $t0
			
			loop_valida_preco:
				
				addi $t1, $0, 48 #determina $t1 como 48 ("0" em ascii")
				lb $t2, 0($s0) #carrega próximo byte de $s0
				slt $t3, $t2, $t1 #$t3 será 1 se $t2 for menor que 48 (não desejável)
				bne $t3, $0, comando_invalido #se $t3 for 1, comando é inválido
				addi $t1, $0, 58 #determina $t1 como 58 ("9 + 1" em ascii")
				slt $t3, $t2, $t1 #$t3 será 1 se $t2 for menor que 58 (desejável)
				beq $t3, $0, comando_invalido #se $t3 for 0, comando é inválido
			
				addi $t0, $t0, 1 #adiciona 1 no acumulador
				addi $s0, $s0, 1 #avança a string do usuário 
				bne $t0, 5, loop_valida_preco #se acumulador não for 5, volta para o loop
			
			lb $t0, 0($s0) #carrega o próximo byte em $t0 (deve ser "-")
			
			bne $t0, 45, comando_invalido #se próximo byte não for "-", comando é invalido
			
			addi $s0, $s0, 1 #avança 1 byte na string do usuário

			add $t0, $0, $0 #acumulador $t0
			
			lb $t1, 0($s0) #carrega o primeiro caractere da string do usuário
			beq $t1, 10, comando_invalido #se comando for vazio, comando é inváido
			
			loop_valida_descricao: #loop para validar se nome será menor que 12 caracteres(para melhor armazenamento na memória
				lb $t1, 0($s0) #carrega próximo byte da string
				beq $t1, 10, retorna_loop_valida_descricao #verifica se string terminou
				beq $t1, 45, comando_invalido
				addi $s0, $s0, 1 #percorre um caractere na string
				addi $t0, $t0, 1 #adiciona 1 ao acumulador
				bne $t0, 13, loop_valida_descricao #se acumulador != 13, loop continua
				j erro_mais_que_12 #jump para erro de descrição maior que 12
			retorna_loop_valida_descricao: 
			
			move $s0, $t5 #retorna $s0 para antes do comando do item
			
			add $t0, $0, $0 #acumulador $t0,
			
			lb $t1, 0($s0) #carrega primeiro byte da string do usuário	
			lb $t2, 1($s0) #carrega segundo byte da string do usuário	
			
			move $t3, $s1 #carrega todos os itens da memória em $t3
			
			loop_checar_codigo_repetido:
				lb $t4, 0($t3) #carrega primeiro byte do código do número da memória
				lb $t5, 1($t3) #carrega segundo byte do código do número da memória
				bne $t4, $t1, fim_loop_checar_codigo_repetido #checa se primeiro byte do código do usuário e da memória são iguais
				bne $t5, $t2, fim_loop_checar_codigo_repetido #checa se segundo byte do código do usuário e da memória são iguais
				j erro_codigo_invalido
				fim_loop_checar_codigo_repetido:
				addi $t0, $t0, 1 #adiciona 1 no acumulador
				addi $t3, $t3, 20 #passa para próximo item na memória
				bne $t0, 20, loop_checar_codigo_repetido
			
			move $t7, $s0 #armazena $s0 em $t5 para operar string sem perdê-la
			addi $t7, $t7, 9 #move string para seu nome
			
			move $t6, $s1 #carrega todos os itens da memória em $t3
			addi $t6, $t6, 7 #move para o nome das strings da memória
			
			add $t0, $0, $0 #acumulador $t0,
			
			addi $t4, $0, 0 #acumulador $t4

			
			loop_checar_nome_repetido:
				lb $t1, 0($t6) #carrega primeiro caractere da string da memória
				lb $t2, 0($t7) #carrega primeiro caractere da string do usuário
				beq $t1, $t2, checar_proximo_char #se caracteres forem iguais, programa checará o proximo caractere
				addi $t4, $t4, 1 #acumulador $t4 + 1
				beq $t4, 20, nome_nao_repetido #se acumulador $t4 for 20, o nome é original
				sub $t6, $t6, $t0 #$t6 subtraído de $t0 (volta ao começo da string)
				sub $t7, $t7, $t0 #$t7 subtraído de $t0 (volta ao começo da string)
				sub $t0, $t0, $t0 #$t0 reiniciado
				addi $t6, $t6, 20 #$t6 irá para a próxima string
				j loop_checar_nome_repetido #repete loop
				checar_proximo_char:
				addi $t0, $t0, 1 #adiciona 1 no acumulador
				addi $t6, $t6, 1 #avança um caractere
				addi $t7, $t7, 1 #avança um caractere
				bne $t0, 13, loop_checar_nome_repetido #se $t0 for igual a 13, significa que o nome ja existe
			
				j erro_item_ja_cadastrado 
			
			nome_nao_repetido:
				
				move $t7, $s0 #armazena $s0 em $t7 (string do usuário)
				move $t6, $s1 #armazena $s1 em $t6 (string da memória)
				
				lb $t0, 0($t7) #carrega o primeiro byte da string(código do item)
				subi $t0, $t0, 48 #subtrai 48 do primeiro byte (transforma em decimal)
				lb $t4, 1($t7) #carrega o segundo byte da string(código do item)
				subi $t4, $t4, 48 #subtrai 48 do segundo byte (transforma em decimal)
			
				mul $t0, $t0, 10 #multiplica byte mais significativo por 10(ele será a dezena)
			
				add $t0, $t0, $t4 #adiciona primeiro com segundo byte ($t0 será o código)
				
				mul $t0, $t0, 20 #multiplica código por 4 para determinar a base do endereçamento
				subi $t0, $t0, 20 #ajuste de base (pois é de 1 a 20, e não de 0 a 20)
				
				add $t6, $t6, $t0 #adiciona $t0 na em $t6 (associado a memória)
				
				addi $t4, $0, 1 #acumulador $t4
				
				loop_store_item:
					lb $t2, 0($t7) #carrega próximo byte do usuário
					beq $t2, 45, cancela_hifen_cmd1 #se for hífen, ignora
					sb $t2, 0($t6) #salva $t2 na memória
					addi $t7, $t7, 1 #adiciona 1 em $t7
					addi $t6, $t6, 1  #adiciona 1 em $t6
					addi $t4, $t4, 1  #adiciona no acumulador
					bne $t4, 20, loop_store_item
					
				j item_adicionado

			#FIM DO CMD_1
			
		erro_codigo_invalido:
			la $a0, codigo_invalido
			li $v0, 4
			syscall
			break_line
			j main
			
		erro_item_ja_cadastrado:
			la $a0, item_ja_cadastrado
			li $v0, 4
			syscall
			break_line
			j main
			
		item_adicionado:
			la $s0, contador_itens_cardapio
			lb $t0, 0($s0)
			addi $t0, $t0, 1
			sb $t0, 0($s0)
			la $a0, item_adicionado_string
			li $v0, 4
			syscall
			break_line
			j main
			
		cancela_hifen_cmd1:
				addi $t7, $t7, 1
			j loop_store_item
			
			
			
		cmd_2_true: #Comando "cardapio_rm"
		
			la $s1, itens_memoria #adiciona espaço reservado para itens em $s1
			#ler <option 1>
			addi $s0, $s0, 12 #vai para o <option 1> na string no usuário
			move $t5, $s0 #salva $s0 atual (sem o "cardapio_rm-") em $t5
			lb $t0, 0($s0) #carrega o código do item
			subi $t0, $t0, 48 #subtrai 48 do primeiro byte (transforma em decimal)
			lb $t4, 1($s0) #carrega o segundo byte da string(código do item)
			subi $t4, $t4, 48 #subtrai 48 do segundo byte (transforma em decimal)
			
			mul $t0, $t0, 10 #multiplica byte mais significativo por 10(ele será a dezena)
			
			add $t0, $t0, $t4 #adiciona primeiro com segundo byte
			
			#Teste de numero valido
			addi $t1, $0, 1 #$t1 = 1
			slt $t2, $t0, $t1 #$t2 será 1 se $t0 < $t1
			bne $t2, $0, erro_codigo_invalido #se $t2 != 0, erro de código inválido
			addi $t1, $0, 21 #$t1 = 21
			slt $t2, $t0, $t1 #$t2 será 1 se $t0 < $t1
			beq $t2, $0, erro_codigo_invalido #se $t2 != 0, erro de código inválido
			
			move $s0, $t5 #retorna $s0 para antes do comando
			add $t0, $0, $0 #acumulador $t0
			lb $t1, 0($s0) #carrega primeiro byte da string do usuário	
			lb $t2, 1($s0) #carrega segundo byte da string do usuário
			move $t3, $s1 #carrega todos os itens da memória em $t3
			
			loop_cod_remocao:
				lb $t4, 0($t3) #carrega primeiro byte do código do número da memória
				lb $t5, 1($t3) #carrega segundo byte do código do número da memória
				bne $t4, $t1, fim_loop_cod_remocao  #checa se primeiro byte do código do usuário e da memória são iguais
				bne $t5, $t2, fim_loop_cod_remocao #checa se segundo byte do código do usuário e da memória são iguais
				j remocao_externo
				fim_loop_cod_remocao:
				addi $t0, $t0, 1 #adiciona 1 no acumulador
				addi $t3, $t3, 20 #passa para próximo item na memória
				bne $t0, 20, loop_cod_remocao
				j cod_nao_cadastrado
				
				remocao_externo:
				add $t4, $0, $0 #determina acumulador como $t4
				add $t5, $0, $0 #determina $t5 como 0
			remocao:
				sb $t5, 0($t3) #salva $t5 na memória
				addi $t3, $t3, 1#adiciona 1 em $t3
				addi $t4, $t4, 1 #adiciona 1 em $t4
				bne $t4, 20, remocao
					
			
			remocao_sucesso
			
			j main
			
		cmd_3_true: #comando "cardapio_list
			la $s0, itens_memoria # carrega endereco base dos itens da memoria em $s0
			move $t4, $s0 # carrega o endereco base no registrador temporario $t4
			lbu $t0, contador_itens_cardapio # carrega contador_itens_cardapio em $t0
			lbu $t1, maximo_itens_cardapio # carrega maximo_itens_cardapio em $t1
			beq $t0, $0, msg_lista_vazia # se o contador for 0, imprime lista vazia
			add $t2, $0, $0 # inicia contador para monitorar quantidade de itens impressos até o momento
	
			loop_cardapio_list: # loop para imprimir todos os itens do cardapio
				addi $t2, $t2, 1 # incrementa o contador
				blt $t1, $t2, finalizar # finaliza se extrapolar o maximo
				blt $t0, $t2, finalizar # finaliza se ja tiver imprimido todos os itens registrados
				lbu $t3, tamanho_codigo_item # salva o tamanho do codigo do item em $t3
				add $t5, $0, $0 # inicia contador de bytes
				
				loop_imprime_codigo:
					lbu $t6, 0($t4) # carrega o valor no endereco base de itens em $t6
					sub $t6, $t6, 48 # transforma em decimal
		 			move $a0, $t6 # transfere $t6 para $a0 para syscall
		 			li $v0, 1 # seta 1 em $v0 para imprimir int
		 			syscall
		 			addi $t5, $t5, 1 # incrementa contador de bytes
		 			addi $t4, $t4, 1 # incrementa posicao do endereco
		 			blt $t5, $t3, loop_imprime_codigo # reinicia o loop se nao tiver passado pelos 2 bytes de codigo
		 			print_dash # imprime hifen
		 		
		 		lbu $t7, tamanho_preco_item # carrega tamanho_preco_item $t7
		 		add $t3, $t3, $t7 # soma o limite de codigo com o limite de preco para saber onde parar
		 		loop_imprime_preco:
		 			lbu $t6, 0($t4) # carrega o valor do endereco base incrementado das posicoes de codigo em $t6
					sub $t6, $t6, 48 # transforma em decimal
		 			move $a0, $t6 # transfere $t6 para $a0 para syscall
		 			li $v0, 1 # seta 1 em $v0 para imprimir int
		 			syscall
		 			addi $t5, $t5, 1 # incrementa contador de bytes
		 			addi $t4, $t4, 1 # incrementa posicao do endereco
		 			blt $t5, $t3, loop_imprime_preco # reinicia o loop se nao tiver passado pelos 5 bytes de codigo
		 			print_dash # imprime hifen
		 		
		 		lbu $t7, tamanho_descricao_item # carrega tamanho_descricao_item em $t7
		 		add $t3, $t3, $t7 # soma o limite de codigo com o limite de descricao para saber onde parar
		 		loop_imprime_descricao:
		 			lbu $t6, 0($t4) # carrega o valor do endereco base incrementado da qtde de bytes de codigo e valor
		 			beq $t6, 10, next # pula para o proximo byte se for line_feed
		 			move $a0, $t6 # transfere $t6 para $a0 para chamada do syscall
		 			li $v0, 11 # seta 11 em $v0 para imprimir caractere
		 			syscall
		 			next:
		 			addi $t5, $t5, 1 # incrementa contador de bytes
		 			addi $t4, $t4, 1 # incrementa posicao do endereco
		 			blt $t5, $t3, loop_imprime_descricao # reinicia o loop se tiver acabado a descricao
		 		
		 		break_line # quebra
				j loop_cardapio_list 
	 	
			finalizar:
				j main
				
			msg_lista_vazia:
				la $a0, msg_lista_vazia_string
				li $v0, 4
				syscall
				break_line
				j main
			
		cmd_4_true: #Comando "cardapio_format"
			
			la $s1, itens_memoria #carrega o endereço de memória dos itens
			
			move $t7, $s1 #copia $s1 em $t7
			
			addi $t0, $0, 0 #determina acumulador como $t0
			
			addi $t1, $0, 0 #determina $t1 como 0
			
			loop_format:
			sb $t1, 0($t7) #Limpa próximo byte 
			addi $t7, $t7, 1 #Move um byte na memória
			addi $t0, $t0, 1 #adiciona um ao acumulador
			bne $t0, 400, loop_format #loop será realizado 400 vezes (tamanho da memória)
			
			la $a0, cardapio_apagado_string #caso comando não se encaixe em nenhum dos códigos acima, imrpime "Comando inválido"
			li $v0, 4
			syscall
			break_line
			
			j main
			
			#FIM DO CMD_4
			
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
	
	








