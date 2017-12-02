

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || ;---------------------------------------------------------------------------- 
(0002)                            || ;-- Data Definitions 
(0003)                            || ;---------------------------------------------------------------------------- 
(0004)                            || .DSEG                ; we’re in the data segment 
(0005)                       000  || .ORG 0x00            ; set the data segment counter to 0x00 
(0006)                            ||                     
(0007)                            || ;----------------------------------------------------------------------------
(0008)                            || ; data used to drive segments for decimal numbers
(0009)                            || ;----------------------------------------------------------------------------  
(0010)  DS-0x000             005  || seg_data:    .DB 0x03, 0x9F, 0x25, 0x0D, 0x99  ; for (0-4) not correct data!
(0011)  DS-0x005             005  ||              .DB 0x49, 0x41, 0x1F, 0x01, 0x09  ; for (5-9) not correct data!
(0012)                            || 
(0013)                            || 
(0014)                            || ;-------------------------------------------------------------
(0015)                            || ; This program counts the number of times a button is pressed
(0016)                            || ; up until 49 where it then goes back to 0
(0017)                            || ;-------------------------------------------------------------
(0018)                            || .CSEG
(0019)                       033  || .ORG	0x21
(0020)                            || 
(0021)                            || ;-------------------------------------------------------------
(0022)                            || ; Varius Ports
(0023)                            || ;-------------------------------------------------------------
(0024)                       130  || .EQU SEGS     = 0x82
(0025)                       131  || .EQU DISP_EN  = 0x83
(0026)                            || 
-------------------------------------------------------------------------------------------
-STUP-  CS-0x000  0x36003  0x003  ||              MOV     r0,0x03     ; write dseg data to reg
-STUP-  CS-0x001  0x3A000  0x000  ||              LD      r0,0x00     ; place reg data in mem 
-STUP-  CS-0x002  0x3609F  0x09F  ||              MOV     r0,0x9F     ; write dseg data to reg
-STUP-  CS-0x003  0x3A001  0x001  ||              LD      r0,0x01     ; place reg data in mem 
-STUP-  CS-0x004  0x36025  0x025  ||              MOV     r0,0x25     ; write dseg data to reg
-STUP-  CS-0x005  0x3A002  0x002  ||              LD      r0,0x02     ; place reg data in mem 
-STUP-  CS-0x006  0x3600D  0x00D  ||              MOV     r0,0x0D     ; write dseg data to reg
-STUP-  CS-0x007  0x3A003  0x003  ||              LD      r0,0x03     ; place reg data in mem 
-STUP-  CS-0x008  0x36099  0x099  ||              MOV     r0,0x99     ; write dseg data to reg
-STUP-  CS-0x009  0x3A004  0x004  ||              LD      r0,0x04     ; place reg data in mem 
-STUP-  CS-0x00A  0x36049  0x049  ||              MOV     r0,0x49     ; write dseg data to reg
-STUP-  CS-0x00B  0x3A005  0x005  ||              LD      r0,0x05     ; place reg data in mem 
-STUP-  CS-0x00C  0x36041  0x041  ||              MOV     r0,0x41     ; write dseg data to reg
-STUP-  CS-0x00D  0x3A006  0x006  ||              LD      r0,0x06     ; place reg data in mem 
-STUP-  CS-0x00E  0x3601F  0x01F  ||              MOV     r0,0x1F     ; write dseg data to reg
-STUP-  CS-0x00F  0x3A007  0x007  ||              LD      r0,0x07     ; place reg data in mem 
-STUP-  CS-0x010  0x36001  0x001  ||              MOV     r0,0x01     ; write dseg data to reg
-STUP-  CS-0x011  0x3A008  0x008  ||              LD      r0,0x08     ; place reg data in mem 
-STUP-  CS-0x012  0x36009  0x009  ||              MOV     r0,0x09     ; write dseg data to reg
-STUP-  CS-0x013  0x3A009  0x009  ||              LD      r0,0x09     ; place reg data in mem 
-STUP-  CS-0x014  0x08108  0x100  ||              BRN     0x21        ; jump to start of .cseg in program mem 
-------------------------------------------------------------------------------------------
(0027)  CS-0x021  0x36002  0x021  || init:		MOV		r0,0x02
(0028)  CS-0x022  0x36101         || 			MOV		r1,0x01
(0029)  CS-0x023  0x36AFF         || 			MOV		r10,0xFF
(0030)  CS-0x024  0x36B0E         || 			MOV		r11,0x0E
(0031)  CS-0x025  0x36C0D         || 			MOV		r12,0x0D
(0032)  CS-0x026  0x1A000         || 			SEI
(0033)                            || 
(0034)  CS-0x027  0x34A83  0x027  || MAIN:		OUT		r10,DISP_EN
(0035)  CS-0x028  0x39400         || 			LD		r20,0X00
(0036)  CS-0x029  0x35482         || 			OUT		r20,SEGS
(0037)  CS-0x02A  0x34B83         || 			OUT		r11,DISP_EN
(0038)  CS-0x02B  0x08191         || 			CALL	WAIT
(0039)  CS-0x02C  0x34A83         || 			OUT		r10,DISP_EN
(0040)  CS-0x02D  0x0550A         || 			LD		r21,(r1)
(0041)  CS-0x02E  0x35582         || 			OUT		r21,SEGS
(0042)  CS-0x02F  0x34C83         || 			OUT		r12,DISP_EN
(0043)  CS-0x030  0x08191         || 			CALL	WAIT
(0044)  CS-0x031  0x08138         || 			BRN		MAIN
(0045)                            || 
(0046)  CS-0x032  0x37D5F  0x032  || WAIT:   	MOV   r29,0x5F   ;set outside loop count
(0047)                            || 
(0048)  CS-0x033  0x37CFF  0x033  || loop1_s:  	MOV   r28,0xFF   ;set middle loop count
(0049)                            || 
(0050)  CS-0x034  0x37BFF  0x034  || loop0_s:  	MOV   r27,0xFF   ;set inside loop count
(0051)  CS-0x035  0x2DB01  0x035  || loop0:    	SUB   r27,0x01   ;decrement inside loop
(0052)  CS-0x036  0x081AB         || 			BRNE  loop0      ; branch if count not zero
(0053)                            || 
(0054)  CS-0x037  0x2DC01         || 			SUB   r28,0x01   ;decrement middle loop
(0055)  CS-0x038  0x081A3         || 			BRNE  loop0_s    ; branch if not zero
(0056)                            ||          
(0057)  CS-0x039  0x2DD01         || 			SUB   r29,0x01   ;decrement outside loop
(0058)  CS-0x03A  0x0819B         || 			BRNE  loop1_s    ; branch if not zero
(0059)                            || 			
(0060)  CS-0x03B  0x18002         || 			RET 
(0061)                            || 
(0062)                            || 
(0063)  CS-0x03C  0x05DE9  0x03C  || WAITx:		MOV	  r29, r29
(0064)  CS-0x03D  0x18002         || 			RET
(0065)                            || 
(0066)                            || 
(0067)  CS-0x03E  0x28001  0x03E  || ISR: 			ADD	r0, 0x01
(0068)  CS-0x03F  0x3000A         || 				CMP	r0, 0x0A
(0069)  CS-0x040  0x08212         || 				BREQ	addToUpperBit
(0070)  CS-0x041  0x1A003         || 				RETIE
(0071)                            || 
(0072)  CS-0x042  0x36000  0x042  || addToUpperBit:  MOV		r0, 0x00
(0073)  CS-0x043  0x28101         || 				ADD		r1, 0x01
(0074)  CS-0x044  0x30105         || 				CMP		r1, 0x05
(0075)  CS-0x045  0x0823A         || 				BREQ	clrUpperBit
(0076)  CS-0x046  0x1A003         || 				RETIE
(0077)                            || 
(0078)  CS-0x047  0x36100  0x047  || clrUpperBit:  	MOV		r1, 0x00
(0079)  CS-0x048  0x1A003         || 				RETIE
(0080)                            || 
(0081)                            || 
(0082)                            || .CSEG
(0083)                       1023  || .ORG 0x3FF
(0084)                            || 
(0085)  CS-0x3FF  0x081F0         || 				BRN 	ISR





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
ADDTOUPPERBIT  0x042   (0072)  ||  0069 
CLRUPPERBIT    0x047   (0078)  ||  0075 
INIT           0x021   (0027)  ||  
ISR            0x03E   (0067)  ||  0085 
LOOP0          0x035   (0051)  ||  0052 
LOOP0_S        0x034   (0050)  ||  0055 
LOOP1_S        0x033   (0048)  ||  0058 
MAIN           0x027   (0034)  ||  0044 
WAIT           0x032   (0046)  ||  0038 0043 
WAITX          0x03C   (0063)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
DISP_EN        0x083   (0025)  ||  0034 0037 0039 0042 
SEGS           0x082   (0024)  ||  0036 0041 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
SEG_DATA       0x005   (0010)  ||  
