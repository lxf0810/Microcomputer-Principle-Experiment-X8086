IO0 EQU 00H
IO1 EQU 10H
IO2 EQU 20H
IO3 EQU 30H
IO4 EQU 40H
IO5 EQU 50H
IO6 EQU 60H
IO7 EQU 70H
IO8 EQU 80H
IO9 EQU 90H
IO10 EQU 0A0H
IO11 EQU 0B0H
IO12 EQU 0C0H
IO13 EQU 0D0H
IO14 EQU 0E0H
IO15 EQU 0F0H

DATA SEGMENT
	OUTBUFF DB 1,2,0,4
	LEDTAB DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
DATA ENDS

CODE SEGMENT 
	ASSUME CS:CODE,DS:DATA
	
START:
	MOV AX,DATA
	MOV DS,AX
	
	MOV AL,88H
	MOV DX,IO3+6
	OUT DX,AL
	
	MOV AL,00110000B
	MOV DX,IO5+6
	OUT DX,AL
	MOV DX,IO5
	MOV AX,500
	OUT DX,AL
	MOV AL,AH
	OUT DX,AL
	MOV AL,01110110B
	MOV DX,IO5+6
	OUT DX,AL
	MOV DX,IO5+2
	MOV AX,5
	OUT DX,AL
	MOV AL,AH
	OUT DX,AL
	
AGAIN:
	MOV DX,IO3+2
	MOV AL,0H
	OUT DX,AL;????
	MOV DX,IO3+4
	IN AL,DX
	TEST AL,20H
	JZ L1;K0?պ?
	
	TEST AL,40H
	JZ L2;K1?պ?
	
	TEST AL,80H
	JZ L3;K2?պ?
	JMP LOP1

L1:
	MOV CL,06H

AGAIN1:
	MOV DX,IO3+2
	MOV AL,CL
	OUT DX,AL
	MOV BX,10
	CALL DELAY
	ROL CL,1
	MOV DX,IO3+4
	IN AL,DX
	TEST AL,20H
	JZ AGAIN1
	JMP AGAIN
	
L2:
	MOV CL,0FFH
AGAIN2:
	MOV DX,IO3+2
	MOV AL,CL
	OUT DX,AL
	MOV BX,10
	CALL DELAY
	NOT CL
	MOV DX,IO3+4
	IN AL,DX
	TEST AL,40H
	JZ AGAIN2
	JMP AGAIN

L3:
	MOV CL,55H
AGAIN3:
	MOV DX,IO3+2
	MOV AL,CL
	OUT DX,AL
	MOV BX,10
	CALL DELAY
	NOT CL
	MOV DX,IO3+4
	IN AL,DX
	TEST AL,80H
	JZ AGAIN3
	JMP AGAIN	

LOP1:
	CALL DISP
	JMP AGAIN
	
DISP PROC NEAR
AGAIN4:
	MOV CL,08H
	LEA SI,OUTBUFF
LEDDISP:
	MOV AL,CL
	MOV DX,IO3+4
	OUT DX,AL
	LEA BX,LEDTAB
	MOV AL,[SI]
	XLAT
	MOV DX,IO3
	OUT DX,AL
	CALL DELAY_1S
	MOV AL,0FFH
	MOV DX,IO3
	OUT DX,AL
	CMP CL,01H
	JZ NEXT
	INC SI
	ROR CL,1
	JMP LEDDISP

NEXT:
	RET
DISP ENDP
	
DELAY_1S PROC
	PUSH CX
	PUSH BX
	MOV BX,01H
D1:
	MOV CX,0FH
D2:
	LOOP D2
	DEC BX
	JNZ D1
	POP BX
	POP CX
	RET
DELAY_1S ENDP
DELAY PROC
	PUSH CX
	PUSH BX
WAIT0:
	MOV CX,2801
WAIT1:
	LOOP WAIT1
	DEC BX
	JNZ WAIT0
	POP CX
	POP BX
	RET 
DELAY ENDP	
CODE ENDS
END START

	
	
	
	
	
	