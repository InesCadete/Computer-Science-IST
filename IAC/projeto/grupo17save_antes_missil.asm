; ******************************************************************************
; * IST-UL
; * Modulo:    grupo17.asm
; * Grupo:	Número: 17, turno L08
;			Números: 98789 - António Barros e Cunha
;				    102787 - Ricardo Santos
;				    102935 - Inês Cadete
;
; *	Descrição: 
;	Este programa ilustra um jogo que representa um rover num
;	cenário espacial onde se movimenta horizontalmente ao premir uma das duas
;	teclas definidas para movimento do mesmo (0 para esquerda, 2 para direita).
;
;	É gerado, numa coluna aleatória, um meteoro que desce linha a linha quando
;	pressionada a tecla B, seguida de um efeito sonoro.
;
; 	Apresentamos também um ecrã que apresenta um contador em hexadecimal que
;	pode ser incrementado ou decrementado utilizando uma teclado teclado
;	(4 para incrementar e 6 para decrementar).
;
; ******************************************************************************


; ******************************************************************************
; *						* Constantes *					    		    	   *
; ******************************************************************************
; ******************************************************************************
;  Constantes Periférico
; ******************************************************************************
LINHA_TECLADO			EQU 16			; valor inicial para levar SHR para se
										; testar a 4ª linha

MASCARA					EQU 0FH			; para isolar os 4 bits de menor peso,
										; ao ler as colunas do teclado

TECLA_ESQUERDA			EQU	0			; tecla 0 no teclado
TECLA_DIREITA			EQU	2			; tecla 2 no teclado


; ******************************************************************************
;  Constantes endereços
; ******************************************************************************

TEC_LIN					EQU 0C000H		; endereço das linhas do teclado
										; (periférico POUT-2)

TEC_COL					EQU 0E000H		; endereço das colunas do teclado
										; (periférico PIN)

DEFINE_LINHA			EQU	600AH		; endereço do comando para definir a
										; linha

DEFINE_COLUNA			EQU	600CH		; endereço do comando para definir a
										; coluna

DEFINE_PIXEL			EQU	6012H		; endereço do comando para escrever um
										; pixel

DEFINE_DISPLAY			EQU	0A000H		; endereço dos displays de 7 segmentos
										; (periférico POUT-1)

APAGA_AVISO				EQU	6040H		; endereço do comando para apagar o
										; aviso de nenhum cenário selecionado

APAGA_ECRÃ				EQU	6002H		; endereço do comando para apagar todos
										; os pixels já desenhados

SELECIONA_CENARIO_FUNDO	EQU	6042H		; endereço do comando para selecionar
										; uma imagem de fundo

SELECIONA_ECRÃ 			EQU 6004H

TOCA_SOM				EQU	605AH		; endereço do comando para tocar um som

; ******************************************************************************
;  Constantes ecrã (limites, cor, posição e dimensão)	
; ******************************************************************************

LINHA_ROVER				EQU	28			; linha do rover (a meio do ecrã)
COLUNA_ROVER			EQU	30			; coluna do rover (a meio do ecrã)

LINHA_METEORO			EQU	0 			; linha do meteoro
COLUNA_METEORO			EQU	8			; coluna onde o meteoro aparece
										; (antes de se encontrar o múltiplo)

MIN_COLUNA				EQU	0			; número da coluna mais à esquerda que
										; o objeto pode ocupar
MAX_COLUNA				EQU	63			; número da coluna mais à direita que o
										; objeto pode ocupar
ATRASO_VEL				EQU	500H		; atraso para limitar a velocidade de
										; movimento do rover

LARGURA					EQU	5			; largura dos objetos
ALTURA_ROVER			EQU	4			; altura do rover
ALTURA_METEORO			EQU	5			; altura do meteoro

N_METEOROS				EQU 4

COR_AMARELO				EQU	0FFF0H		; cor do rover: amarelo em ARGB
COR_VERMELHO			EQU	0FF00H		; cor do meteoro: vermelho em ARGB
COR_VERDE 				EQU 0F1F6H
COR_AZUL				EQU 0F8AFH
COR_CINZENTO_ESCURO		EQU 0F344H
COR_CINZENTO_CLARO		EQU 0FDDDH
COR_BRANCO 				EQU 0FFFFH
COR_MISSIL				EQU 0FF0FH		; cor do missil

; ******************************************************************************
;  Dados 													    
; ******************************************************************************

	PLACE		1000H


	STACK 100H 							; espaço reservado para a pilha 
SP_inicial_main:						; endereço do SP do programa principal

	STACK 100H
SP_teclado:

	STACK 100H
SP_meteoro_0:

	STACK 100H
SP_meteoro_1:

	STACK 100H
SP_meteoro_2:

	STACK 100H
SP_meteoro_3:

	STACK 100H
SP_display:


tabela_SP_meteoro:
	
	WORD SP_meteoro_0
	WORD SP_meteoro_1
	WORD SP_meteoro_2
	WORD SP_meteoro_3


BTE_START:								; interrupções
	WORD		rel_meteoros
	WORD		rel_missil
	WORD		rel_energia

METEOROS_FLAG:
	LOCK		0

MISSIL_FLAG:
	LOCK		0

ENERGIA_FLAG:
	LOCK 		0


NUMERO_ALEATORIO:
	WORD		0
	

ALT_ROVER:								; endereço que define a altura do rover
	WORD		ALTURA_ROVER

ALT_METEORO:							; endereço que define a altura do meteoro
	WORD 		ALTURA_METEORO

LOC_ROVER: 								; endereço que define a coluna do rover
	WORD		COLUNA_ROVER

LIN_METEORO: 							; endereço que define a linha do meteoro
	WORD		0
	WORD 		0
	WORD 		0
	WORD		0

COL_METEORO:
	WORD		0
	WORD		0
	WORD		0
	WORD 		0

TIPO_METEORO:
	WORD 		-1
	WORD 		-1
	WORD		-1
	WORD		-1


DEF_ROVER:								; tabela que define o rover
	WORD		0, 0, COR_CINZENTO_ESCURO, 0, 0

	WORD		0, COR_VERMELHO, COR_AZUL, COR_VERMELHO, 0

	WORD		0, COR_CINZENTO_CLARO, COR_AZUL, COR_CINZENTO_CLARO, 0

	WORD		COR_CINZENTO_CLARO, 0, COR_CINZENTO_CLARO, 0, COR_CINZENTO_CLARO

DEF_METEORO_MAU:							; tabela que define o meteoro
	WORD		COR_CINZENTO_ESCURO, 0, 0, 0, COR_CINZENTO_ESCURO

	WORD		COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO

	WORD		COR_CINZENTO_ESCURO, COR_VERMELHO, COR_CINZENTO_ESCURO, COR_VERMELHO, COR_CINZENTO_ESCURO

	WORD		COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO, COR_CINZENTO_ESCURO

	WORD		0, COR_CINZENTO_CLARO, 0, COR_CINZENTO_CLARO, 0

DEF_METEORO_BOM:
	WORD		0, COR_BRANCO, COR_BRANCO, COR_BRANCO, 0

	WORD		COR_BRANCO, COR_BRANCO, COR_VERDE, COR_BRANCO, COR_BRANCO

	WORD		COR_BRANCO, COR_VERDE, COR_VERDE, COR_VERDE, COR_BRANCO

	WORD		COR_BRANCO, COR_BRANCO, COR_VERDE, COR_BRANCO, COR_BRANCO

	WORD		0, COR_BRANCO, COR_BRANCO, COR_BRANCO, 0

DISPLAY_ENERGIA:
	WORD		100H


; ******************************************************************************
; 	Código																	    
; ******************************************************************************

PLACE   0

inicio:
	MOV		SP, SP_inicial_main			; inicializar SP

	MOV 	BTE, BTE_START				; inicializar BTE
	EI0
	EI1
	EI2
	EI

	MOV		[APAGA_AVISO], R1			; apaga o aviso de nenhum cenário
										; selecionado
	MOV		[APAGA_ECRÃ], R1			; apaga todos os pixels já desenhados
	MOV		R1, 0						; cenário de fundo número 0
	MOV		[SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo
	MOV		R3, DEFINE_DISPLAY			; endereço do display
	MOV		R11, [DISPLAY_ENERGIA]		; valor inicial de energia
	MOV		[R3], R11 					; mostra no display o valor inicial de
     									; energia definido
	MOV		R7, 1						; valor a somar à coluna do rover, para 
										; o movimentar

	MOV 	R11, N_METEOROS

posição_rover:							; Rotina que define posição inicial do
										; rover.
	MOV  	R1, LINHA_ROVER				; linha do rover
	MOV  	R2, [LOC_ROVER]				; coluna do rover
	MOV		R4, DEF_ROVER				; endereço da tabela que define o rover

mostra_rover:
	CALL	desenha_rover_altura		; desenha o rover a partir da tabela

	CALL 	teclado
    CALL 	diminui_display_energia

loop_meteoros:
	SUB		R11, 1
    CALL	meteoros

    CMP		R11, 0
    JNZ 	loop_meteoros


; ******************************************************************************
; Processo dos controlos do rover
; ******************************************************************************

PROCESS SP_teclado

teclado:
	MOV  	R1, LINHA_ROVER				; linha do rover
	MOV 	R2, [LOC_ROVER]				; coluna do rover
	MOV		R4, DEF_ROVER				; endereço da tabela que define o rover
	MOV		R8, TEC_LIN					; endereço do periférico das linhas
	MOV		R3, TEC_COL					; endereço do periférico das colunas
	MOV		R5, MASCARA					; para isolar os 4 bits de menor peso,
										; ao ler as colunas do teclado
scan_teclado:
	MOV  	R6, LINHA_TECLADO 			; valor da linha do teclado para ser
										; testada
varrimento:
	
	WAIT								; como é potencialmente infinito, dá a vez
										; a outro processo

	SHR  	R6, 1 						; avança uma linha para cima
	CMP  	R6, 0 						; se chegar ao final do teclado volta à
										; linha de baixo
	JZ  	scan_teclado

espera_tecla:							; neste ciclo espera-se até uma tecla
										; ser premida
	MOVB	[R8], R6					; escrever no periférico de saída
										; (linhas)
	MOVB	R0, [R3]					; ler do periférico de entrada (colunas)
	AND		R0, R5		 				; elimina bits para além dos bits 0-3

	CMP		R0, 0 						; verifica se foi clicada alguma tecla
										; na linha 
	JZ		varrimento					; continua o scan se nenhuma tiver sido
										; clicada
	CALL 	converter					; converte a tecla num valor entre 0 e F
	CMP		R0, TECLA_ESQUERDA			; verifica se foi clicada a tecla de
										; mover o rover para a esquerda
	JNZ		testa_direita				; se não tiver sido, verifica se foi
										; clicada a tecla de mover para a
										; direita
	MOV		R7, -1						; vai deslocar para a esquerda
	JMP		ve_limites					; verifica se foram ultrapassados
										; limites do ecrã

testa_direita:
	CMP		R0, TECLA_DIREITA			; verifica se foi clicada a tecla de
										; mover o rover para a direita
	JNZ		varrimento					; não é a tecla que se quer
	MOV		R7, +1						; vai deslocar para a direita
	JMP		ve_limites 					; verifica se foram ultrapassados
										; limites do ecrã
	
ve_limites:
	MOV		R6, LARGURA					; obtém a largura do rover
	CALL	testa_limites				; vê se chegou aos limites do ecrã e se
										; sim força R7 a 0
	CMP		R7, 0
	JZ		scan_teclado				; se não é para movimentar o objeto,
										; vai ler o teclado de novo

coluna_seguinte:
	CALL	apaga_rover_altura			; apaga o rover na sua posição corrente
	ADD		R2, R7						; para desenhar objeto na coluna
										; seguinte (direita ou esquerda)
	CALL	desenha_rover_altura		; vai desenhar o rover de novo
	CALL	atraso_vel
	JMP		scan_teclado


espera_nao_tecla:						; neste ciclo espera-se até NÃO haver
										; nenhuma tecla premida
	YIELD

	PUSH	R6

inicia_scan:
	MOV		R6, LINHA_TECLADO			; início do scan do teclado

loop_espera:
	SHR		R6, 1						; linha a testar no teclado;
										; (começa na 4ª até à 1ª)
	CMP		R6, 0 						; se chegar ao fim do teclado, para o
										; scan
	JZ		fim_teclado

scan_linha:						
	CALL	teclado						; leitura às teclas
	CMP		R0, 0 						; há uma tecla a ser carregada?
	JNZ		scan_linha					; espera, enquanto houver tecla uma
										; tecla carregada
	JZ		loop_espera					; não, então continua o scan

fim_teclado:	
	POP		R6
	JMP		scan_teclado				; não há teclas a serem carregadas,
										; volta a esperar uma tecla clicada para
										; o próximo comando


; ******************************************************************************
; Processo dos meteoros
; ******************************************************************************

PROCESS	SP_meteoro_0

meteoros:
	
	MOV 	R0, R11					; copia o nº da instância
	SHL 	R0, 1 						; duplica para viajar entre as WORDS
	MOV 	R9, tabela_SP_meteoro 		; tabela com os SPs das várias instâncias

	MOV 	SP, [R9+R0] 				; inicializa cada processo para cada instância

	CALL 	dados_meteoro				; consegue valor da coluna onde o
										; meteoro aparece e desenha-o

	MOV 	R7, COL_METEORO
	MOV 	[R7+R0], R9

	MOV 	R8, LIN_METEORO
	MOV 	R5, 0
	MOV 	[R8+R0], R5

	MOV 	R9, TIPO_METEORO
	CALL 	consegue_numero_aleatorio
	MOV 	R5, [NUMERO_ALEATORIO]
	MOV 	[R9+R0], R5


posição_meteoro:						; Rotina que define posição inicial do
										; meteoro
	MOV  	R5, [R8+R0]				; linha do meteoro
	MOV  	R9, [R7+R0]				; valor de base para conseguir a coluna
										; onde o meteoro aparece

	MOV 	R1, TIPO_METEORO
	MOV 	R10, [R1+R0]
	CMP		R10, 1
	JLE 	meteoro_bom
	MOV  	R10, DEF_METEORO_MAU		; endereço da tabela que define o
										; meteoro
	JMP 	mostra_meteoro

meteoro_bom:
	MOV 	R10, DEF_METEORO_BOM

mostra_meteoro:
	CALL	desenha_meteoro

linha_seguinte:
	MOV 	R2, [METEOROS_FLAG]
	CALL	apaga_meteoro_altura		; apaga o rover na sua posição corrente
	INC		R5							; próxima linha
	CALL	desenha_meteoro				; desenha na próxima linha
	MOV		R1, 0 						; seleciona o som 0
	MOV		[TOCA_SOM], R1 				; toca o som 0
	MOV 	[R8+R0], R5
	JMP 	mostra_meteoro


; ******************************************************************************
; Processo do valor da energia do display
; ******************************************************************************

PROCESS SP_display

diminui_display_energia:

	MOV 	R11, [DISPLAY_ENERGIA]		; valor atual da energia
	MOV 	R1, [ENERGIA_FLAG]			; sinal de ativação do processo
	SUB		R11, 5 				 		; diminui a enrgia
	MOV		[R3], R11					; mostra o novo valor no display
	MOV 	[DISPLAY_ENERGIA], R11
	JMP 	diminui_display_energia



; ******************************************************************************
; DESENHA_ROVER_ALTURA - Atribui o valor da altura do rover a R6
;				e desenha o rover
;
; ******************************************************************************

desenha_rover_altura:
	PUSH	R6
	MOV		R6, ALTURA_ROVER			; atribui o valor de altura do rover a R6
	CALL	desenha_objeto 				; usa o valor de R6 para desenhar o rover
	POP		R6
	RET	


; ******************************************************************************
; APAGA_ROVER_ALTURA -  Atribui o valor da altura do rover a R6
;				e apaga o rover
;
; ******************************************************************************

apaga_rover_altura:
	PUSH R6
	MOV R6, ALTURA_ROVER				; atribui o valor de altura do rover a R6
	CALL apaga_objeto 					; usa o valor de R6 para apagar o rover
	POP  R6
	RET


; ******************************************************************************
; ATRIBUI_VALORES_METEORO - Atribui os valores do meteoro aos registos que são
;				usados para apagá-lo e/ou desenhar um novo
;
; Argumentos: R5 - linha do meteoro
;		    R9 - coluna do meteoro
; 		    R10 - tabela com os dados dos píxeis do meteoro
; 
; Retorna:    R1 - linha do meteoro
;		    R2 - coluna do meteoro
; 		    R4 - tabela com os dados dos píxeis do meteoro
;		    R6 - altura do meteoro
; 	
; ******************************************************************************

atribui_valores_meteoro:
	MOV 	R1, R5						; atribui o valor da linha do meteoro			
	MOV  	R2, R9						; atribui o valor da coluna do meteoro
	MOV 	R4, R10						; atribui a tabela com os dados do
										; meteoro
	MOV 	R6, ALTURA_METEORO			; atribui o valor de altura do meteoro
										; a R6
	RET


; ******************************************************************************
; DADOS_METEORO - Consegue o valor para a coluna inicial e
;			desenha o meteoro
;
; Argumentos - R5 - linha do meteoro
; 		  R9 - valor base para a coluna do meteoro
;		  R10 - tabela com dados do meteoro
;
; Retorna - R9 - novo valor da coluna do meteoro
;
; ******************************************************************************

dados_meteoro:
	PUSH	R1

	CALL	consegue_numero_aleatorio

	MOV 	R1, [NUMERO_ALEATORIO]
	MOV		R9, COLUNA_METEORO			; valor base para conseguir a coluna
										; inicial (8)
	MUL		R9, R1						; usa os valores para conseguir a
										; coluna inicial
	POP		R1

	RET

desenha_meteoro:
	PUSH	R1
	PUSH	R2
	PUSH	R4
	PUSH	R6
	CALL	atribui_valores_meteoro 	; atribui os dados do meteoro para os
										; registos certos
	CALL	desenha_objeto 				; usa os valores atribuídos para
										; desenhar o meteoro
	MOV		R9, R2						; transfere o novo valor de coluna do
										; meteoro para R9
	POP		R6
	POP		R4
	POP		R2
	POP		R1
	RET

consegue_numero_aleatorio:
	PUSH 	R0
	PUSH 	R1

	MOV		R1, TEC_COL					; endereço das colunas do teclado (PIN)
	MOVB	R0, [R1]					; atribui o conteúdo a R8
	SHR		R0, 5 						; consegue um valor aleatório entre 0 e
										; 7
	MOV 	[NUMERO_ALEATORIO], R0

	POP		R1
	POP		R0
	RET


; ******************************************************************************
; APAGA_METEORO_ALTURA - Atribui o valor da altura do meteoro a R6
;				 	e apaga o meteoro
;
; ******************************************************************************

apaga_meteoro_altura:
	PUSH	R1
	PUSH	R2
	PUSH	R4
	PUSH	R6
	CALL	atribui_valores_meteoro 	; atribui os dados do meteoro para os
										; registos certos
	CALL	apaga_objeto 				; usa os valores atribuídos para apagar
										; o meteoro
	POP		R6
	POP		R4
	POP		R2
	POP		R1
	RET


; ******************************************************************************
; DESENHA_OBJETO - Desenha os pixels do objeto a partir da tabela
;
; ******************************************************************************

desenha_objeto:
	PUSH	R1
	PUSH	R3
	PUSH	R4
	PUSH	R5
	PUSH	R2
	MOV		R5, LARGURA					; obtém a largura do objeto

desenha_pixels:       					; desenha os pixels do objeto a partir
										; da tabela
	MOV		R3, [R4]					; obtém a cor do próximo pixel do objeto
	CALL	escreve_pixel				; escreve cada pixel do objeto
	ADD		R4, 2						; endereço da cor do próximo pixel
										; (2 porque cada cor de pixel é uma
										; word)
	ADD		R2, 1               		; próxima coluna
	SUB		R5, 1						; menos uma coluna para tratar
	JNZ		desenha_pixels      		; continua até percorrer toda a largura
     									; do objeto
	MOV		R5, LARGURA					; reinicia o contador da largura
	POP		R2
	PUSH	R2
	ADD		R1, 1 						; próxima linha
	SUB		R6, 1 						; menos uma linha para tratar
	JNZ		desenha_pixels
	POP		R2
	POP		R5
	POP		R4
	POP		R3
	POP		R1
	RET


; ******************************************************************************
; APAGA_OBJETO - Apaga um objeto na linha e coluna indicadas
;			  com a forma definida na tabela indicada.
;
; Argumentos:   R1 - linha do objeto
;               R2 - coluna do objeto
;               R4 - tabela que define objeto
;
; ******************************************************************************

apaga_objeto:
	PUSH	R1
	PUSH	R3
	PUSH	R4
	PUSH	R5
	PUSH	R2
	MOV		R5, LARGURA					; obtém a largura do objeto

apaga_pixels:       					; desenha os pixels do objeto a partir
										; da tabela
	MOV		R3, 0						; cor para apagar o próximo pixel do
										; objeto
	CALL	escreve_pixel				; escreve cada pixel do objeto
	ADD		R4, 2 						; endereço da cor do próximo pixel
										; (2 porque cada cor de pixel é uma
										; word)
	ADD		R2, 1          				; próxima coluna
	SUB		R5, 1						; menos uma coluna para tratar
	JNZ		apaga_pixels      			; continua até percorrer toda a largura
     									; do objeto
	MOV 	R5, LARGURA 				; atribui a largura a R5
	POP 	R2							; reinicia a coluna
	PUSH	R2
	ADD 	R1, 1 						; avança de linha
	SUB 	R6, 1 						; menos uma linha para apagar
	JNZ		apaga_pixels 				; enquanto não chega ao fim do objeto
										; continua a apagar
	POP		R2
	POP		R5
	POP		R4
	POP		R3
	POP		R1
	RET


; ******************************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
;
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; ******************************************************************************
escreve_pixel:
	MOV		[DEFINE_LINHA], R1			; seleciona a linha
	MOV		[DEFINE_COLUNA], R2			; seleciona a coluna
	MOV		[DEFINE_PIXEL], R3			; altera a cor do pixel na linha e
										; coluna já selecionadas
	RET


; ******************************************************************************
; ATRASO_VEL - Executa um ciclo para implementar um atraso no movimento do rover.
;
; Argumentos:   R11 - valor que define o atraso
;
; ******************************************************************************
atraso_vel:
	PUSH	R11
	MOV		R11, ATRASO_VEL 			; atribui o atraso a R11

ciclo_atraso:
	SUB		R11, 1 						; subtrai enquanto o valor não chega a 0
	JNZ		ciclo_atraso
	POP		R11
	RET

; ******************************************************************************
; TESTA_LIMITES - Testa se o rover chegou aos limites do ecrã e nesse caso
;			   impede o movimento (força R7 a 0)
;
; Argumentos:	R2 - coluna em que o objeto está
;			R6 - largura do rover
;			R7 - sentido de movimento do rover (valor a somar à coluna
;				em cada movimento: +1 para a direita, -1 para a esquerda)
;
; Retorna: 	R7 - 0 se já tiver chegado ao limite, inalterado caso contrário	
;
; ******************************************************************************
testa_limites:
	PUSH	R5
	PUSH	R6

testa_limite_esquerdo:					; vê se o rover chegou ao limite esquerdo
	MOV		R5, MIN_COLUNA
	CMP		R2, R5
	JGT		testa_limite_direito
	CMP		R7, 0						; passa a deslocar-se para a direita
	JGE		sai_testa_limites
	JMP		impede_movimento			; entre limites. Mantém o valor do R7

testa_limite_direito:					; vê se o rover chegou ao limite direito
	ADD		R6, R2						; posição a seguir ao extremo direito do
										; rover
	MOV		R5, MAX_COLUNA
	CMP		R6, R5
	JLE		sai_testa_limites			; entre limites. Mantém o valor do R7
	CMP		R7, 0						; passa a deslocar-se para a direita
	JGT		impede_movimento
	JMP		sai_testa_limites
impede_movimento:
	MOV		R7, 0						; impede o movimento, forçando R7 a 0
sai_testa_limites:	
	POP		R6
	POP		R5
	RET


; ******************************************************************************
; CONVERTER - Converte os valores binários da linha e coluna num valor
;		entre 0 e F
;
; Argumentos: R6 - linha da tecla
;		    R0 - coluna da tecla
;
; Retorna: R0 - valor entre 0 e F correspondente à tecla clicada
;
; ******************************************************************************

converter:
	PUSH	R2
	PUSH	R3
	MOV		R2, 0						; contador de linha
	MOV		R3, 4						; valor a multiplicar pela linha
get_linha:
	SHR		R6, 1
	INC		R2							; conta quantas vezes se consegue dar
										; SHR da linha
	CMP		R6, 0
	JNZ		get_linha
	MUL		R2, R3						; multiplica a linha obtida por 4
converte_tecla:
	SHR		R0, 1 				
	DEC		R3 							; conta quantas vezes se consegue dar
										; SHR da coluna
	CMP		R0, 0
	JNZ		converte_tecla
	INC		R3 							; aumenta 1 ao contador
	SUB		R2, R3 						; subtrai o contador da coluna a R2
	MOV		R0, R2						; atribui o valor da tecla obtido a R0
	POP		R3
	POP		R2
	RET



; ******************************************************************************
; AUMENTA_DISPLAY_ENERGIA - aumenta o valor da energia do display em
;					   uma unidade
;
; Argumentos: R11 - valor de energia
;
; Retorna: R11 - valor de energia aumentado
;
; ******************************************************************************

aumenta_display_energia:
	PUSH	R11

	MOV 	R11, [DISPLAY_ENERGIA]
	INC		R11							; aumenta a energia
	MOV		[R3], R11 					; mostra o novo valor no display
	MOV 	[DISPLAY_ENERGIA], R11

	POP 	R11
	RET

verifica_flag_energia:
	PUSH 	R0

	MOV 	R0, [ENERGIA_FLAG]
	CMP 	R0, 0
	JZ 		retornar_energia
	MOV 	R0, 0
	CALL	diminui_display_energia
retornar_energia:
	POP R0
	RET


rel_meteoros:
	PUSH	R0

	MOV 	R0, 1
	MOV 	[METEOROS_FLAG], R0

	POP		R0
	RFE 

rel_missil:
	PUSH	R0

	MOV 	R0, 1
	MOV 	[MISSIL_FLAG], R0

	POP		R0
	RFE 

rel_energia:
	PUSH	R0

	MOV 	R0, 1
	MOV 	[ENERGIA_FLAG], R0

	POP		R0
	RFE 
