# Arquitetura e Organizacaoo de Computadores: 1VA
# Grupo: Anthony Guerra, Geraldo Goncalves, Paulo Veloso e Rodrigo Souza
# Questao 1: O objetivo desta questao eh implementar em assembly MIPS algumas funcoes da biblioteca “string.h” para linguagem C.

.data
src_str:    .asciiz "alan turing"
dst_str:    .space 50
concat_str: .space 100
str1:   .asciiz "Palavra"
str2:   .asciiz "Palavrinha"
num:          .word 13
newline:    .asciiz "\n"
prompt_a:   .asciiz "Teste a)"
prompt_b:   .asciiz "Teste b)"
prompt_c:   .asciiz "Teste c)"
prompt_d:   .asciiz "Teste d)"
prompt_e:   .asciiz "Teste e)"

.text
main:
    
 # Testando as funcoes
    
    li $v0, 4
    la $a0, prompt_a # Imprime "Teste a)"
    syscall
    jal break_line    # quebra linha
    # Teste da função strcpy
    la $a1, src_str   # Endereco da string de origem
    la $a0, dst_str   # Endereco da string de destino
    jal strcpy
    li $v0, 4         # Syscall para imprimir string
    la $a0, dst_str   # Carrega a string de destino para imprimir
    syscall
    jal break_line    # quebra linha

    jal break_line    # quebra linha
    li $v0, 4
    la $a0, prompt_b # Imprime "Teste b)"
    syscall
    jal break_line    # quebra linha

    # Teste da função memcpy
    la $a1, src_str   # Endereco da string de origem
    la $a0, dst_str   # Endereco da string de destino
    li $a2, 13        # Comprimento a ser copiado
    jal memcpy
    li $v0, 4         # Syscall para imprimir string
    la $a0, dst_str   # Carrega a string de destino para imprimir
    syscall
    jal break_line    # quebra linha

    jal break_line    # quebra linha
    li $v0, 4
    la $a0, prompt_c # Imprime "Teste c)"
    syscall
    jal break_line    # quebra linha

    # Teste da função strcmp
    la $a0, str1  # String 1
    la $a1, str2  # String 2
    jal strcmp
    move $a0, $v0     # Move o resultado para $a0 para imprimir
    li $v0, 1         # Syscall para imprimir inteiro
    syscall
    jal break_line    # quebra linha
    
    jal break_line    # quebra linha
    la $a0, prompt_d # Imprime "Teste d)"
    syscall
    jal break_line    # quebra linha

    # Teste da função strncmp
    la $a0, str1  # String 1
    la $a1, str2  # String 2
    lw $a3, num       # Numero de caracteres a serem comparados
    jal strncmp
    move $a0, $v0     # Move o resultado para $a0 para imprimir
    li $v0, 1         # Syscall para imprimir inteiro
    syscall
    jal break_line    # quebra linha
    
    jal break_line
    la $a0, prompt_e # Imprime "Teste e)"
    syscall
    jal break_line    # quebra linha

    # Teste da função strcat
    la $a1, src_str   # String de origem
    la $a0, concat_str # String de destino para concatenacao
    jal strcpy        # Copia a string de origem para a string de destino
    la $a0, concat_str # Atualiza o endereco da string de destino concatenada
    la $a1, src_str   # String de origem
    jal strcat
    li $v0, 4         # Syscall para imprimir string
    la $a0, concat_str # Carrega a string concatenada para imprimir
    syscall
    jal break_line    # quebra linha

    # Sair
    li $v0, 10
    syscall
    
 #=============================================================================================
 
 #Criando as funcoes

# Funcao strcpy
# Copia o conteudo da string de origem para a string de destino
# $a1: Endereco da string de origem
# $a0: Endereco da string de destino
strcpy:
    move $t0, $a1       # Salva o endereco da origem
loop_strcpy:
    lb $t1, ($t0)      # Carrega um byte da origem
    beqz $t1, end_strcpy   # Se for nulo, encerra o loop
    sb $t1, ($a0)      # Armazena o byte no destino
    addi $t0, $t0, 1   # Move para o proximo byte na origem
    addi $a0, $a0, 1   # Move para o proximo byte no destino
    j loop_strcpy      # Repete o loop
end_strcpy:
    move $v0, $a0      # $v0 vai retornar o parametro destination
    sb $zero, ($a0)    # Adiciona um byte nulo ao final da string de destino
    jr $ra             # Retorna

# Funcao memcpy
# Copia o numero especificado de bytes da origem para o destino
# $a1: Endereço da origem
# $a0: Endereço do destino
# $a2: Numero de bytes a serem copiados
memcpy:
    move $t0, $a1       # Salva o endereco da origem
    move $t1, $a0       # Salva o endereco do destino
    move $t2, $a2       # Salva o numero de bytes a serem copiados
loop_memcpy:
    lb $t3, ($t0)      # Carrega um byte da origem
    sb $t3, ($t1)      # Armazena o byte no destino
    addi $t0, $t0, 1   # Move para o proximo byte na origem
    addi $t1, $t1, 1   # Move para o proximo byte no destino
    addi $t2, $t2, -1  # Decrementa o contador de bytes
    bnez $t2, loop_memcpy # Repete o loop ate que todos os bytes sejam copiados
    move $v0, $a0      # $v0 vai retornar o parametro destination
    jr $ra             # Retorna

# Funcao strcmp
# Compara duas strings lexicograficamente (ordem ASCII)
# $a0: Endereco da String 1
# $a1: Endereco da String 2
# Retorna:
#   0 se as strings sao iguais
#   <0 se a String 1 eh menor que a String 2
#   >0 se a String 1 eh maior que a String 2
strcmp:
    move $t0, $a0       # Salva o endereco da String 1
    move $t1, $a1       # Salva o endereco da String 2
loop_strcmp:
    lb $t2, ($t0)      # Carrega um byte da String 1
    lb $t3, ($t1)      # Carrega um byte da String 2
    beq $t2, $t3, check_next_char  # Se os bytes sao iguais, verifica o proximo caractere
    sub $v0, $t2, $t3  # Calcula a diferenca entre os caracteres
    jr $ra             # Retorna com o resultado
check_next_char:
    beqz $t2, end_strcmp   # Se alcancar o terminador nulo, as strings sao iguais
    addi $t0, $t0, 1   # Move para o proximo caractere na String 1
    addi $t1, $t1, 1   # Move para o proximo caractere na String 2
    j loop_strcmp      # Repete o loop
end_strcmp:
    li $v0, 0         # Define o resultado como 0 (strings sao iguais)
    jr $ra             # Retorna

# Funcao strncmp
# Compara duas strings lexicograficamente (ordem ASCII) ate n caracteres
# $a0: Endereco da String 1
# $a1: Endereco da String 2
# $a3: Numero de caracteres a serem comparados
# Retorna:
#   0 se as strings sao iguais ate n caracteres
#   <0 se a String 1 eh menor que a String 2
#   >0 se a String 1 eh maior que a String 2
strncmp:
    move $t0, $a0       # Salva o endereco da String 1
    move $t1, $a1       # Salva o endereco da String 2
    move $t2, $a3       # Salva o numero de caracteres a serem comparados
loop_strncmp:
    beqz $t2, end_strncmp   # Se n caracteres forem comparados, as strings sao iguais
    lb $t3, ($t0)      # Carrega um byte da String 1
    lb $t4, ($t1)      # Carrega um byte da String 2
    beq $t3, $t4, check_next_char_sn  # Se os bytes sao iguais, verifica o proximo caractere
    sub $v0, $t3, $t4  # Calcula a diferenca entre os caracteres
    jr $ra             # Retorna com o resultado
check_next_char_sn:
    beqz $t3, end_strncmp   # Se alcancar o terminador nulo, as strings sao iguais ate n caracteres
    addi $t0, $t0, 1   # Move para o proximo caractere na String 1
    addi $t1, $t1, 1   # Move para o proximo caractere na String 2
    addi $t2, $t2, -1  # Decrementa o contador de caracteres
    j loop_strncmp     # Repete o loop
end_strncmp:
    li $v0, 0         # Define o resultado como 0 (strings sao iguais ate n caracteres)
    jr $ra             # Retorna

# Funcao strcat
# Concatena a String de origem ao final da String de destino
# $a0: Endereco da String de destino
# $a1: Endereco da String de origem
strcat:
    move $t0, $a0       # Salva o endereco do destino
    move $t1, $a1       # Salva o endereco da origem
find_null:
    lb $t2, ($t0)      # Carrega um byte do destino
    beqz $t2, copy_strcat   # Se encontrar o terminador nulo, comeca a copiar a origem
    addi $t0, $t0, 1   # Move para o proximo caractere no destino
    j find_null        # Repete ate encontrar o terminador nulo
copy_strcat:
    lb $t3, ($t1)      # Carrega um byte da origem
    beqz $t3, end_strcat   # Se encontrar o terminador nulo, encerra o loop
    sb $t3, ($t0)      # Armazena o byte no destino
    addi $t0, $t0, 1   # Move para o proximo caractere no destino
    addi $t1, $t1, 1   # Move para o proximo caractere na origem
    j copy_strcat      # Repete o loop
end_strcat:
    sb $zero, ($t0)    # Adiciona um byte nulo ao final da string concatenada
    move $v0, $a0      # $v0 vai retornar o parametro destination
    jr $ra             # Retorna
    
# Funcao para quebra de linha
break_line:
    li $v0, 4
    la $a0, newline # Quebra de linha
    syscall
    jr $ra
