;---------------------------------------------------------------------------- 
;-- Data Definitions 
;---------------------------------------------------------------------------- 
.DSEG                ; we’re in the data segment 
.ORG 0x00            ; set the data segment counter to 0x00 
                    
;----------------------------------------------------------------------------
; data used to drive segments for decimal numbers
;----------------------------------------------------------------------------  
seg_data:    .DB 0x03, 0x9F, 0x25, 0x0D, 0x99  ; for (0-4) not correct data!
             .DB 0x49, 0x41, 0x1F, 0x01, 0x09  ; for (5-9) not correct data!


;-------------------------------------------------------------
; This program counts the number of times a button is pressed
; up until 49 where it then goes back to 0
;-------------------------------------------------------------
.CSEG
.ORG	0x21

;-------------------------------------------------------------
; Varius Ports
;-------------------------------------------------------------
.EQU SEGS     = 0x82
.EQU DISP_EN  = 0x83

init:		MOV		r0,0x00
			MOV		r1,0x00
			MOV		r10,0x00
			MOV		r11,0x01
			MOV		r12,0x02
			SEI

MAIN:		OUT		r10,DISP_EN
			LD		r20,(r0)
			OUT		r20,SEGS
			OUT		r10,DISP_EN
			CALL	WAIT
			OUT		r10,DISP_EN
			LD		r21,(r1)
			OUT		r21,SEGS
			OUT		r10,DISP_EN
			CALL	WAIT
			BRN		MAIN

WAIT:   	MOV   r29,0x5F   ;set outside loop count

loop1_s:  	MOV   r28,0xFF   ;set middle loop count

loop0_s:  	MOV   r27,0xFF   ;set inside loop count
loop0:    	SUB   r27,0x01   ;decrement inside loop
			BRNE  loop0      ; branch if count not zero

			SUB   r28,0x01   ;decrement middle loop
			BRNE  loop0_s    ; branch if not zero
         
			SUB   r29,0x01   ;decrement outside loop
			BRNE  loop1_s    ; branch if not zero
			
			RET 


WAITx:		MOV	  r29, r29
			RET


ISR: 			ADD	r0, 0x01
				CMP	r0, 0x0A
				BREQ	addToUpperBit
				RETIE

addToUpperBit:  MOV		r0, 0x00
				ADD		r1, 0x01
				CMP		r1, 0x05
				BREQ	clrUpperBit
				RETIE

clrUpperBit:  	MOV		r1, 0x00
				RETIE


.CSEG
.ORG 0x3FF

				BRN 	ISR
