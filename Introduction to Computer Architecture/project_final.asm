; *********************************************************************
; *
; * IST-UL
; *
; *********************************************************************
; **********************************************************************
; * Constantes
; **********************************************************************
DISPLAYS   	   EQU 0A000H    ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN    	   EQU 0C000H    ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL    	   EQU 0E000H    ; endereço das colunas do teclado (periférico PIN)
LINHA      	   EQU 8         ; linha a testar (4ª linha, 1000b)
ECRA       	   EQU 806CH     ; endereço do ecrã (pixelscreen)
COMECA_MISSIL  EQU 8064H
ECRA_VOLANTE   EQU 8074H
ECRA_FIM       EQU 8020H
INICIO     	   EQU 8010H     ; endereço do ecrã (pixelscreen)
ECRA_INICIO    EQU 8000H     ; endereço do ecrã (pixelscreen)
N_LINHAS       EQU 32        ; número de linhas do écrã
LIM_LINHA      EQU 0FH
LINHA_19       EQU 19H
LIM14 		   EQU 000EH
LIM27 		   EQU 001BH
LIM22 		   EQU 0016H
LIM32 		   EQU 0020H
LIM9 		   EQU 0009H
TECLAC         EQU 0CH

;*************************************************************************
PLACE      	    	1000H
pilha:      		TABLE 100H        
                             
SP_INICIAL:

asteroide_objeto:	STRING 0DH , 00H
					STRING 0FFH, 01H
					WORD asteroide0_mau
                   
MISSIL_OBJETO:		STRING 0EH, 19H
					STRING 0FFH, 0FFH
					WORD MISSIL0
      
MASCARA:			STRING 80H
					STRING 40H
					STRING 20H
					STRING 10H
					STRING 08H	
					STRING 04H	
					STRING 02H
					STRING 01H	

asteroide0_mau:		STRING 0, 0, 1, 1
					STRING 1, 0

asteroide1_mau:		STRING 0, 0, 2, 2	
					STRING 1, 1
					STRING 1, 1

asteroide2_mau:		STRING 0, 0, 3, 3	
					STRING 0, 1, 0
					STRING 1, 1, 1
					STRING 0, 1, 0, 0		

asteroide3_mau: 	STRING 0, 0, 4, 4	
					STRING 0, 1, 1, 0
					STRING 1, 1, 1, 1
					STRING 1, 1, 1, 1
					STRING 0, 1, 1, 0	

asteroide4_mau: 	STRING 0, 0, 5, 5	
					STRING 0, 1, 1, 1, 0
					STRING 1, 1, 1, 1, 1
					STRING 1, 1, 1, 1, 1
					STRING 1, 1, 1, 1, 1
					STRING 0, 1, 1, 1, 0, 0		 

MISSIL0:			STRING 0, 0, 1, 1
					STRING 1, 0
				
NAVE_ESTRUTURA:		STRING 0, 27, 32, 5
					STRING 0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0
					STRING 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0    
					STRING 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0  								
					STRING 0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0
					STRING 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
				
NAVE_NORMAL:    	STRING 14, 29, 4, 3
					STRING 0,0,0,0
					STRING 1,1,1,1	
					STRING 0,0,0,0
	
NAVE_ESQUERDA:  	STRING 14, 29, 4, 3
					STRING 0,0,0,1
					STRING 0,1,1,0
					STRING 1,0,0,0	
		 
NAVE_DIREITA:   	STRING 14, 29, 4, 3
					STRING 1,0,0,0
					STRING 0,1,1,0
					STRING 0,0,0,1
		  		
DESENHO:  			STRING 0FH, 76H, 0DEH, 0F0H  
					STRING 08H, 55H, 52H, 90H     
					STRING 08H, 74H, 5EH, 90H     
					STRING 08H, 54H, 50H, 90H     
					STRING 0FH, 54H, 50H, 0F0H	   
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 06H, 70H, 00H
					STRING 00H, 05H, 40H, 00H
					STRING 00H, 05H, 70H, 00H
					STRING 00H, 05H, 40H, 00H
					STRING 00H, 06H, 70H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 76H, 0EDH, 0DDH, 66H
					STRING 54H, 49H, 55H, 54H
					STRING 76H, 4DH, 0D5H, 56H
					STRING 52H, 49H, 95H, 54H
					STRING 56H, 4DH, 5DH, 66H				

COLUNAD: 			STRING 00H, 00H, 00H, 00H	
		
FIM:				STRING 00H, 80H, 01H, 00H
					STRING 00H, 40H, 02H, 00H
					STRING 00H, 20H, 04H, 00H
					STRING 00H, 10H, 08H, 00H
					STRING 00H, 08H, 10H, 00H
					STRING 00H, 04H, 20H, 00H
					STRING 00H, 02H, 40H, 00H
					STRING 00H, 01H, 80H, 00H
					STRING 00H, 01H, 80H, 00H
					STRING 00H, 02H, 40H, 00H
					STRING 00H, 04H, 20H, 00H
					STRING 00H, 08H, 10H, 00H
					STRING 00H, 10H, 08H, 00H
					STRING 00H, 20H, 04H, 00H
					STRING 00H, 40H, 02H, 00H
					STRING 00H, 80H, 01H, 00H

		
COLUNAF:			STRING 00H, 00H, 00H, 00H

LIMPA:	 			STRING 00H, 00H, 00H, 00H  
					STRING 00H, 00H, 00H, 00H     
					STRING 00H, 00H, 00H, 00H     
					STRING 00H, 00H, 00H, 00H     
					STRING 00H, 00H, 00H, 00H	   
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
					STRING 00H, 00H, 00H, 00H
		 
COLUNAL:			STRING 00H, 00H, 00H, 00H
;***********************************************************************		 		 
	
PLACE 		2000H

MEMORIA_TECLA:			WORD 0 

MEMORIA_ULTIMA_TECLA:	WORD 0

UPDATE_TECLA:			WORD 0
		
MISSIL_ATIVADO: 		WORD 0	

;CONTADOR_ACUMULA:		WORD 0
;***************************************************************************		
			
PLACE 1000H	

tab:    	    WORD rot_int_0      ; rotina de atendimento da interrupção 0
				WORD rot_int_1
      
evento_int_0:	WORD 0              ; se 1, indica que a interrupção 0 ocorreu
evento_int_1:	WORD 0
;*****************************************************************************************
PLACE 0

	MOV BTE, tab
	MOV SP, SP_INICIAL
	
	EI0
	EI1
	EI
	
	MOV  R5, DISPLAYS           ; endereço do periférico dos displays
    MOV  R6, 0

display_zero:	
	MOV  R1, 0 
    MOVB [R5], R1               ; escreve os displaysB a zero
	CALL desenho_inicial        ;desenha a nave

	
jogo:                           ;começa o jogo
	CALL teclado                ;verifica que teclas são ativadas
	CALL meteorito				;desenha os asteroides
	CALL missil					;desenha o missil
	JMP jogo
	

;*********************************************************************************************	
;*********************************************************************************************
;*   Teclado 
;*		O teclado é constituido por três funções que guarda e lê a tecla premida 
;*********************************************************************************************
;****************************************************************************************	
teclado:
	CALL guarda_tecla
	CALL ultima_tecla
	CALL ve_tecla_premida
	RET
	
;**********************************************************************************************
guarda_tecla:					    ;esta rotina lê o teclado e guarda o valor da tecla premida
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3

    MOV  R1, LINHA     				; testar a linha 4 
	MOV  R2, TEC_LIN   				; endereço do periférico das linhas
    MOV  R3, TEC_COL   				; endereço do periférico das colunas

espera_tecla:          				; neste ciclo espera-se até uma tecla ser premida
    MOVB [R2], R1      				; escrever no periférico de saída (linhas)
    MOVB R0, [R3]     				; ler do periférico de entrada (colunas)
    CMP  R0, 0         				; há tecla premida?
    JNZ  inicializacao 				; se  tecla premida
    SHR  R1, 1         				; vai para a linha antes
    JNZ  espera_tecla  				; se nenhuma tecla premida, volta a ver se outra tecla foi premida
	
e_impossivel:						;nenhuma tecla foi premida
    MOV  R2, -1		                ;mandar valor impossivel para a memória
	MOV R3, MEMORIA_TECLA
	MOV [R3], R2
	JMP guarda_tecla_fim
	
inicializacao:
    MOV  R2, -1
    MOV  R3, -1
	
conversao_linha:          			;calcula em que linha está a tecla premida
    SHR  R1, 1            
    ADD  R2, 1            
    CMP  R1, 0            			;conta o número de bits a 1 
    JNZ  conversao_linha

conversao_coluna:         			;calcula em que coluna está a tecla premida
    SHR  R0, 1            
    ADD  R3, 1            
    CMP  R0, 0            			;conta o número de bits a 1 
    JNZ  conversao_coluna
    SHL  R2, 2           			;4* linha
    ADD  R2, R3           			;4*linha + coluna (conversão de 0,2,4,8 -> 0,1,2,3)
	MOV  R3, MEMORIA_TECLA
	MOV [R3], R2					;por o valor de R6 na   msm memória

guarda_tecla_fim:
	POP R3
	POP R2
	POP R1
	POP R0
	RET	
;****************************************************************************************
ultima_tecla:						;verifica se a ultima tecla clicada foi a mesma, caso não tenha sido atualiza a tecla
	PUSH R0
	PUSH R1
	PUSH R2

	MOV R0, MEMORIA_TECLA			;tecla que foi premida
	MOV R1, [R0]
	MOV R0, MEMORIA_ULTIMA_TECLA	;última tecla que foi premida
	MOV R2, [R0]
	CMP R1, R2						;a tecla premida foi igual à última? 
	JZ ultima_tecla_fim				;se sim, vai ler as teclas
	MOV R0, UPDATE_TECLA			;se não, atualiza 
	MOV R2, 1
	MOV [R0], R2

ultima_tecla_fim:
	POP R2
	POP R1
	POP R0
	RET
;**************************************************************************************
ve_tecla_premida:							;indica que função realizar tendo em conta a tecla premida
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV  R0, UPDATE_TECLA
	MOV  R1, [R0]
	CMP  R1, 0
	JZ   fim_tecla_premida
	MOV  R1, MEMORIA_TECLA 
	MOV  R0, [R1]
	
teclaC:										;se tecla C premida então limpa o ecrã e inicia o jogo
	MOV R2, TECLAC
	CMP R0, R2
	JNZ tecla0
	CALL limpar_ecra
	CALL nave
	CALL volante_normal
	JMP fim_tecla_premida

tecla2:									    ;se tecla 2 premida então dispara o missil
	CMP R0, 2
	JZ ativa_missil
	JNZ tecla0             
	
ativa_missil:								 
	MOV R4, MISSIL_ATIVADO
	MOV R3, 1
	MOV [R4], R3
	JMP  fim_tecla_premida
	
tecla0:										;se tecla 0 premida então vira o volante à esquerda
	CMP R0, 0
	JNZ  tecla3            
	CALL volante_esquerda  
	JMP  fim_tecla_premida
	
tecla3:										;se tecla 3 premida então vira o volante à direita
	CMP R0, 3
    JNZ  teclaE            
	CALL volante_direita   
	JMP  fim_tecla_premida

teclaE:										;se tecla E premida então termina o jogo
	MOV R2, 0EH
	CMP R0, R2
	JNZ nao_tecla
	CALL limpar_ecra
	CALL final
	JMP fim_tecla_premida
	
nao_tecla:                                   ;quando nenhuma tecla é premida
	MOV R1, -1
	CMP R0, R1
	JNZ fim_tecla_premida
		
fim_tecla_premida:
	CALL volante_normal
	MOV R0, MEMORIA_TECLA
	MOV R1, [R0]
	MOV R0, MEMORIA_ULTIMA_TECLA
	MOV [R0], R1
	MOV R0, UPDATE_TECLA
	MOV R1, 0
	MOV [R0], R1
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
;***********************************************************************************	
;**********************************************************************************
;*  Desenhos dos ecrãs
;**********************************************************************************
;************************************************************************************
desenho_inicial:                     ;desenha o ecrã inicial
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
    MOV R2, INICIO                   ;começa na linha 10
	MOV R1, DESENHO                  ;
	MOV R0, COLUNAD                  ;limite da largura do ecrã (32x32)
	CALL pinta 
	
	POP R3
	POP R2
	POP R1
	POP R0
	RET	
;**********************************************************************************
final:								;desenha o ecrã final
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
    MOV R2, ECRA_FIM                ;começa na linha 20
	MOV R1, FIM                  
	MOV R0, COLUNAF                 ;limite da largura do ecrã 
	CALL pinta 
	
	POP R3
	POP R2
	POP R1
	POP R0
	RET	
;*****************************************************************************************
limpar_ecra:						;limpa o ecrã
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
    MOV R2, INICIO                   
	MOV R1, LIMPA                  
	MOV R0, COLUNAL                 
	CALL pinta
	
	POP R3
	POP R2
	POP R1
	POP R0
	RET	
;*******************************************************************************************
;* Pinta BYTE a BYTE	
;******************************************************************************************
pinta:
	MOVB R3, [R1]                   ;regista o desenho da nave
	MOVB [R2], R3                   ;pinta o pixel correspondente
	ADD R1, 1                       ;passa para a coluna seguinte
	ADD R2, 1                      
	CMP R1, R0                      ;já está na última coluna?
	JNZ pinta             			;se não, volta a pintar para o próximo Byte
	RET
;**********************************************************************************************
;* Desenhos da nave e os volantes	
;***********************************************************************************************
nave:								; Desenha a nave sem volante
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	MOV R0, NAVE_ESTRUTURA
	MOVB R1, [R0]        			 ; x coluna       
	ADD R0, 1    
	MOVB R2,[R0]		 			 ; y linha
	ADD R0, 1	 
	MOVB R3, [R0]		 			 ; largura
	ADD R0, 1
	MOVB R4, [R0]        			 ; altura
	ADD R0, 1
	MOV R7, R1
	CALL update_linha_coluna		 ;vai dar a informação à rotina que pinta
	
	POP  R7
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
	RET
;************************************************************************************************
volante_normal:							; Desenha o volante direito
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	MOV R0, NAVE_NORMAL
	MOVB R1, [R0]         				; x coluna       
	ADD R0, 1    
	MOVB R2,[R0]		  				; y linha
	ADD R0, 1	 
	MOVB R3, [R0]		  				; largura
	ADD R0, 1
	MOVB R4, [R0]         				; altura
	ADD R0, 1
	MOV R7, R1
	CALL update_linha_coluna			; vai dar a informação à rotina que pinta
	
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET	
;*******************************************************************************************
volante_esquerda:						; Desenha o volante virado para a esquerda
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7	
	MOV R0, NAVE_ESQUERDA
	MOVB R1, [R0]         				; x coluna       
	ADD R0, 1    
	MOVB R2,[R0]		  				; y linha
	ADD R0, 1	 
	MOVB R3, [R0]		  				; largura
	ADD R0, 1
	MOVB R4, [R0]       				; altura
	ADD R0, 1
	MOV R7, R1
	CALL update_linha_coluna			;vai dar a informação à rotina que pinta
	
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
;*********************************************************************************
volante_direita:						; Desenha o volante virado para a direita
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	MOV R0, NAVE_DIREITA
	MOVB R1, [R0]         				; x coluna       
	ADD R0, 1    
	MOVB R2,[R0]		  				; y linha
	ADD R0, 1	 
	MOVB R3, [R0]		  				; largura
	ADD R0, 1
	MOVB R4, [R0]         				; altura
	ADD R0, 1
	MOV R7, R1
	CALL update_linha_coluna			;vai dar a informação à rotina que pinta
	
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
;*******************************************************************************
update_linha_coluna:						; Diz à rotina pinta o que pintar
	MOVB R8, [R0]
	CALL pinta_bit 
	ADD R0, 1
	ADD R1, 1
	ADD R5, 1
	ADD R9, 1
	CMP R9, R3								;chegou à última coluna que deve desenhar?
	JNZ update_linha_coluna					;se sim, passa para a próxima linha
	MOV R9, 0
	MOV R5, R7
	MOV R1, R5
	ADD R2, 1
	ADD R6, 1
	CMP R6, R4								;chegou à última linha que deve desenhar?
	JNZ update_linha_coluna					;se não, continua a pintar
	RET
;*********************************************************************************
;* Pinta Bit a Bit
;**********************************************************************************
pinta_bit:							; desenha o objeto bit a bit tendo em conta os dados fornecidos
	PUSH R0
	PUSH R1
    PUSH R2
	PUSH R3
	PUSH R4
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R10
    MOV  R3, 8
    MOV  R0, ECRA_INICIO           ; endereço do primeiro byte do ecrã
    SHL  R2, 2					   ; multiplica a linha por 4 (porque há 4 bytes por linha)
	MOV  R6, R1 				
    DIV  R1, R3					   ; DIISAO 8
    ADD  R2, R1
    ADD  R0, R2
	MOD  R6, R3
	MOV  R4, MASCARA			   ; endereço onde escrever o byte
    ADD  R4, R6
	MOVB R4, [R4]
	MOVB R7, [R0]
	CMP  R8, 1					   ;o bit é para pintar?    (0->não pinta/apaga) (1->pinta)
	JNZ pinta0

pinta1:								;pinta os bits a 1
	MOV R10, 1
	CMP R10, 1
	JZ pinta_1_escreve
	XOR R4, R7
	JMP pinta_1_fim

pinta_1_escreve:
	OR R4, R7

pinta_1_fim:
	MOVB [R0], R4
	JMP fim_pinta_bit

pinta0:								;pinta os bits a 0
	NOT R4
	AND R4, R7
	MOVB [R0], R4
	
fim_pinta_bit:
	POP R10
	POP  R8
    POP  R7
	POP  R6
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
    RET
;****************************************************************************************
;*		MISSIL  
;*			O míssil é ativado quando a tecla 2 é premida
;****************************************************************************************
missil:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R6
	MOV R2, MISSIL_ATIVADO				
	MOV R3, [R2]
	CMP R3, 1								;a tecla 2 foi ativada?
	JNZ fim_missil							; se sim, o missil é lançado
	MOV  R6, evento_int_0
	MOV  R1, [R6]
	CMP  R1, 0
	JZ   fim_missil
	MOV  R4, 0								;apaga o missil
	CALL ciclo_desenho_missil
	CALL mexe_missil						;muda a direção do míssil
	MOV R4, 1
	CALL ciclo_desenho_missil				;desenha o missil
	MOV  R5, MISSIL_OBJETO
   	CALL limite_missil						; se chegou à linha 12 o missil desaparece
	MOV  R1, 0
	MOV  [R6], R1
	
fim_missil:
	POP R6
	POP R4
	POP R3
	POP R2
	POP R1
	RET
;***********************************************************************************
reset_missil: 				;quando o limite implementado na rotina limite_missil, esta rotina manda o missíl à possição inicial
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R2, 0EH
	MOVB [R5], R2
	ADD R5, 1
	MOV R2, LINHA			;volta à linha inicial
	MOVB [R5], R2
	ADD R5, 1
	MOV R2, 0
	MOVB [R5], R2
	ADD R5, 1
	MOVB [R5], R2
	ADD R5, 1
	MOVB [R5],R2
	ADD R5, 1
	MOV R2, MISSIL0
	MOV [R5], R2
	POP R5
	POP R4                                       			
	POP R3													
	POP R2
	POP R1
	RET
	
limite_missil:									;verifica se já chegou à linha final                             
	PUSH R1
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R10
	ADD R5, 1
	MOVB R7, [R5]
	MOV R10, LIM_LINHA
	CMP R7, R10
	JZ limite_reset_missil
	JMP limite_return_missil	
	
limite_reset_missil:
	SUB R5, 1
	MOV R4, 0
	CALL ciclo_desenho_missil
	CALL reset_missil
	MOV R1, MISSIL_ATIVADO
	MOV R3, 0
	MOV [R1], R3
	
limite_return_missil:
	POP R10
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R1
	RET
;***********************************************************************************
mexe_missil:      					; esta rotina atualiza a localização do míssil, fazendo com que ele suba uma linha
	PUSH R0
	PUSH R2
	PUSH R5
	
	MOV R5, MISSIL_OBJETO
	MOV R0, [R5]
	ADD R5, 2
	MOV R2, [R5]
	ADD R0, R2
	SUB R5, 2
	MOV [R5], R0
	
	POP R5	
	POP R2
	POP R0
	RET
;*************************************************************************************
ciclo_desenho_missil:  							;esta rotina informa outras rotinas quando pintar ou apagar o missil
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5

	MOV R5, MISSIL_OBJETO
	MOVB R2, [R5]           ; coluna inicial
	ADD R5, 1
	MOVB R3, [R5]           ; linha inicial
	ADD R5, 3
	MOV R1, [R5]
	MOVB [R1], R2 
	ADD R1, 1
	MOVB [R1], R3
	SUB R1, 1
	CMP R4, 1								;se for igual então desenha missil
	JZ pinta_desenho_missil
	CALL apaga_missil						;caso contrário apaga
	JMP  fim_ciclo_desenho_missil

pinta_desenho_missil:
	CALL pinta_missil

fim_ciclo_desenho_missil:
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET
;********************************************************************************
pinta_missil:							; desenha o objeto bit a bit tendo em conta as coordenadas do missil
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	
	MOVB R2, [R1]         ; x coluna 
	MOV R5, R2
	ADD R1, 1    
	MOVB R3,[R1]		  ; y linha
	ADD R1, 1	 
	MOVB R0, [R1]          ; largura
	MOV R6, R0
	ADD R1, 1
	MOVB R4, [R1]		  ; altura

contar_linhas_missil:				;vê se chegou à ultima linha e coluna
	ADD R1, 1
	MOVB R9, [R1]                   ;se bit for 1 então pinta
	CALL pinta_bit1
	ADD R2, 1
	SUB R0, 1
	JZ  contar_colunas_missil		
	JMP contar_linhas_missil
	
contar_colunas_missil:
	MOV R2, R5
	MOV R0, R6
	ADD R3, 1
	SUB R4, 1
	JZ  fora_pinta_missil
	JMP contar_linhas_missil
	
fora_pinta_missil:
	POP  R9
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
	RET
; *************************************************************************************
apaga_missil:								; desenha o objeto bit a bit tendo em conta as coordenadas do missil
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	
	MOVB R2, [R1]         				; x coluna 
	MOV R5, R2
	ADD R1, 1    
	MOVB R3,[R1]		 				; y linha
	ADD R1, 1	 
	MOVB R0, [R1]          				; largura
	MOV R6, R0
	ADD R1, 1
	MOVB R4, [R1]		  				; altura

contar_linhas_2_missil:   				;vê se chegou à ultima linha e coluna
	ADD R1, 1
	MOVB R9, [R1]
	CMP R9, 0							;se o bit for 0 então lê o seguinte
	JZ  fugir_pinta_bit_missil			; caso contrário apaga
	MOV R9, 0
	CALL pinta_bit1							

fugir_pinta_bit_missil:
	ADD R2, 1
	SUB R0, 1
	JZ  contar_colunas_2_missil
	JMP contar_linhas_2_missil
	
	
contar_colunas_2_missil:
	MOV R2, R5
	MOV R0, R6
	ADD R3, 1
	SUB R4, 1
	JZ  fora_pinta_missil_2
	JMP contar_linhas_2_missil
	
fora_pinta_missil_2:
	POP R9
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
	RET
;*****************************************************************************

;*********************************************************************************
pinta_bit1:							; desenha o objeto bit a bit tendo em conta os dados fornecidos
	PUSH R0
	PUSH R1
    PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6 
	PUSH R7
	PUSH R8
	PUSH R9
	
    MOV  R7, 8
    MOV  R0, ECRA_INICIO           ; endereço do primeiro byte do ecrã
    SHL  R3, 2					; multiplica a linha por 4 (porque há 4 bytes por linha)
	MOV  R5, R2 				
    DIV  R2, R7					; DIISAO 8
    ADD  R3, R2
    ADD  R0, R3
	MOD  R5, R7
	MOV  R4, MASCARA			; endereço onde escrever o byte
    ADD  R4, R5
	MOVB R4, [R4]
	MOVB R6, [R0]
	CMP  R9, 0
	JZ  pinta01
	OR R4, R6
	JMP fim_pinta_bit1

pinta01:
	NOT R4
	AND R4, R6

fim_pinta_bit1:
	MOVB [R0], R4
	POP  R9
	POP  R8
	POP  R7
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
    RET
;*************************************************************************************
;*************************************************************************************
;* Asteróides
;*	
;**********************************************************************
;***********************************************************************************
meteorito:							;esta rotina escreve os asteróides no ecra
	PUSH R1
	PUSH R4
	PUSH R5
	PUSH R6
	MOV  R6, evento_int_1
	MOV  R1, [R6]
	CMP  R1, 0
	JZ   fim3
	MOV  R4, 0						;apaga o asteroide
	CALL ciclo_desenho
	MOV R5, asteroide_objeto
	CALL limite						;vê se está dentro dos limites
	CALL mexe_asteroide             ; movimenta o asteróide
	CALL pick_desenho				; vê se ele cresce ou não
	MOV R4, 1
	CALL ciclo_desenho				; desenha o asteróide

fim3:
	MOV  R1, 0
	MOV  [R6], R1
	POP R6 
	POP R5
	POP R4
	POP R1
	RET
;*********************************************************************************
reset: 								;volta a pôr o asteróide na posição inicial
	PUSH R1
	PUSH R2
	PUSH R5
	MOV R2, 0DH						;coluna inicial
	MOV R5, asteroide_objeto
	MOVB [R5], R2
	ADD R5, 1
	MOV R2, 0						;linha inicial
	MOVB [R5],R2
	ADD R5, 2
	MOV R2, asteroide0_mau			;estado inicial
	MOV [R5], R2
	POP R5
	POP R2
	POP R1
	RET
;********************************************************************************************	
limite:								;esta rotina verifica se o asteróide está dentro dos limites do ecrã
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10
	MOVB R6, [R5]
	ADD R5, 1
	MOVB R7, [R5]
	MOV R8, LIM32
	CMP R6, R8
	JGE limite_reset
	ADD R6, 5
	MOV R9, 80H
	AND R6, R9
	CMP R6, 0
	JNZ limite_reset
	MOV R10, LIM22
	CMP R7, R10
	JGE limite_reset
	JMP limite_return	
	
limite_reset:				;se não estiver, apaga o asteróide e ativa-o na posição inicial
	SUB R5, 1
	MOV R4, 0
	CALL ciclo_desenho
	CALL reset

limite_return:
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	RET
;*******************************************************************************
mexe_asteroide:      						;esta rotina ativa o movimento dos asteróides
	PUSH R0
	PUSH R2
	PUSH R5
	
	MOV R5, asteroide_objeto
	MOV R0, [R5]
	ADD R5, 2
	MOV R2, [R5]
	ADD R0, R2
	SUB R5, 2
	MOV [R5], R0
	
	POP R5	
	POP R2
	POP R0
	RET
;***************************************************************************************************	
pick_desenho:       						; se chegou à linha correspondente o asteróide cresce
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6

	MOV R5, asteroide_objeto
	ADD R5, 1
	MOVB R3, [R5]				          ; linha a comparar
	ADD R5, 3

	CMP R3, 2
	JLT fim_pick_desenho

	CMP R3, 5
	JLT desenho2

	MOV R2, LIM9
	CMP R3, R2
	JLT desenho3

	MOV R4, LIM14
	CMP R3, R4
	JLT desenho4

	MOV R6, LIM27
	CMP R3, R6
	JLT desenho5

desenho2:
	MOV R1, asteroide1_mau
	MOV [R5], R1
	JMP fim_pick_desenho

desenho3:
	MOV R1, asteroide2_mau
	MOV [R5], R1
	JMP fim_pick_desenho

desenho4:
	MOV R1, asteroide3_mau
	MOV [R5], R1
	JMP fim_pick_desenho

desenho5:
	MOV R1, asteroide4_mau
	MOV [R5], R1

fim_pick_desenho:
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET
;*************************************************************************************
ciclo_desenho: 								;indica as coordenadas do asteróide que a rotina pinta vai utilizar
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5

	MOV R5, asteroide_objeto
	MOVB R2, [R5]           ; coluna inicial
	ADD R5, 1
	MOVB R3, [R5]           ; linha inicial
	ADD R5, 3
	MOV R1, [R5]
	MOVB [R1], R2 
	ADD R1, 1
	MOVB [R1], R3
	SUB R1, 1
	CMP R4, 1
	JZ pinta_desenho 
	CALL apaga_asteroide
	JMP  fim_ciclo_desenho

pinta_desenho:
	CALL pinta_asteroide

fim_ciclo_desenho:
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	RET
;****************************************************************************************************************
pinta_asteroide:							;desenha o asteróide  no ecrã
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	
	MOVB R2, [R1]         				  ; x coluna 
	MOV R5, R2
	ADD R1, 1    
	MOVB R3,[R1]		 				  ; y linha
	ADD R1, 1	 
	MOVB R0, [R1]       			  	  ; largura
	MOV R6, R0
	ADD R1, 1
	MOVB R4, [R1]						  ; altura

contar_linhas:							 ;vê se chegou à ultima linha e coluna
	ADD R1, 1
	MOVB R9, [R1]							
	CALL pinta_bit3
	ADD R2, 1
	SUB R0, 1
	JZ  contar_colunas
	JMP contar_linhas
	
contar_colunas:
	MOV R2, R5
	MOV R0, R6
	ADD R3, 1
	SUB R4, 1
	JZ  fora_pinta_asteroide
	JMP contar_linhas
	
fora_pinta_asteroide:
	POP  R9
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
	RET
; *************************************************************************************
apaga_asteroide:							;apaga o asteróide  no ecrã
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R9
	
	MOVB R2, [R1]         					; x coluna 
	MOV R5, R2
	ADD R1, 1    
	MOVB R3,[R1]		  					; y linha
	ADD R1, 1	 
	MOVB R0, [R1]          					; largura
	MOV R6, R0
	ADD R1, 1
	MOVB R4, [R1]		 					 ; altura

contar_linhas_2:							;vê se chegou à ultima linha e coluna
	ADD R1, 1
	MOVB R9, [R1]
	CMP R9, 0
	JZ  fugir_pinta_bit
	MOV R9, 0
	CALL pinta_bit3

fugir_pinta_bit:
	ADD R2, 1
	SUB R0, 1
	JZ  contar_colunas_2
	JMP contar_linhas_2
	
contar_colunas_2:
	MOV R2, R5
	MOV R0, R6
	ADD R3, 1
	SUB R4, 1
	JZ  fora_pinta_asteroide_2
	JMP contar_linhas_2
	
fora_pinta_asteroide_2:
	POP R9
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
	RET
;*****************************************************************************

;*********************************************************************************
pinta_bit3:							;desenha bit a bit os asteróide
	PUSH R0
	PUSH R1
    PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6 
	PUSH R7
	PUSH R8
	PUSH R9
	
    MOV  R7, 8
    MOV  R0, ECRA_INICIO           ; endereço do primeiro byte do ecrã
    SHL  R3, 2					; multiplica a linha por 4 (porque há 4 bytes por linha)
	MOV  R5, R2 				
    DIV  R2, R7					; DIISAO 8
    ADD  R3, R2
    ADD  R0, R3
	MOD  R5, R7
	MOV  R4, MASCARA			; endereço onde escrever o byte
    ADD  R4, R5
	MOVB R4, [R4]
	MOVB R6, [R0]
	CMP  R9, 0
	JZ  pinta03
	OR R4, R6
	JMP fim_pinta_bit3

pinta03:
	NOT R4
	AND R4, R6

fim_pinta_bit3:
	MOVB [R0], R4
	POP  R9
	POP  R8
	POP  R7
	POP  R6
	POP  R5
	POP  R4
	POP  R3
	POP  R2
	POP  R1
	POP  R0
    RET
	
;***************************************************************************
rot_int_0:
     PUSH R0
     PUSH R1
     MOV  R0, evento_int_0
     MOV  R1, 1               ; assinala que houve uma interrupção 0
     MOV  [R0], R1            ; na componente 0 da variável evento_int
     POP  R1
     POP  R0
     RFE
;**************************************************************************
rot_int_1:
	 PUSH R2
     PUSH R3
     MOV  R2, evento_int_1
     MOV  R3, 1               ; assinala que houve uma interrupção 0
     MOV  [R2], R3            ; na componente 0 da variável evento_int
     POP  R3
     POP  R2
     RFE
;**********************************************************************************
;ciclo:								    *Ciclo do asteróide com direção aleatória 
;	CALL meteorito
;	MOV  R5, ASTEROIDE_OBJETO
;	CALL limite
;	MOV R1, CONTADOR_ACUMULA
;	MOV R2, [R1]
;	ADD R2, 1
;	MOV [R1], R2
;	CALL contador
;	JMP ciclo
;	RET
;
;contador:
;	PUSH R0 
;	PUSH R1
;	PUSH R3
;	MOV R0, CONTADOR_ACUMULA
;	MOV R1, [R0]
;	MOV R3, 3
;	MOD R1, R3 					;0 OU 1 OU 2
;	SUB R1, 1					;-1 OU 0 OU 1
;	ADD R5,3
;	MOVB [R5],R1

;	POP R3
;	POP R1
;	POP R0
;	RET
;*