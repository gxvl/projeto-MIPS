.data
# receiver_data: 0xffff0004
# receiver_control: 0xffff0000
# transmitter_data: 0xffff000c
# transmitter_control: 0xffff0008

.text

main:
	lui $t0, 0xFFFF				# armazena 0xffff nos primeiros 16-bits de $t0 ($t0 = 0xFFFF0000)
	jal loop					# chama o loop de leitura do keyboard e escrita no display

loop:							# abordagem sem interrupcao, polling
	lw $t1, 0($t0)				# carrega o valor presente no receiver control em $t1
	andi $t1, $t1, 0x0001		# verifica se $t1 vale 1 (significa que recebeu entrada do keyboard)
	beq $t1, $zero, loop 		# se nao recebeu entrada, continua verificando
	lw $v0, 4($t0)    			# armazena o valor de entrada do keyboard (endereco 0xFFFF0004) em $v0
	
	lw $t1, 8($t0)				# carrega o valor do transmitter control em $t1 (0xFFFF0008)
	andi $t1, $t1, 0x0001		# verifica se $t1 vale 1 (significa que tem entrada do teclado disponível para uso, "ready")
	beq $t1, $zero, loop		# se nao tiver entrada, voltar ao inicio do loop
	sw $v0, 12($t0)				# carrega o valor presente em $v0 no transmitter data (0xFFFF000C)
	jr $ra						# retorna para o fluxo principal
    