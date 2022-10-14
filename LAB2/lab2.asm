
IO2 =0400H;0000 01(A10=1)00 0000 0000 IO2
IO3 =0600H;0000 01(A10=1)10 0000 0000 IO2

stack segment
dw 10 dup(?)
stack ends

code segment 
assume ss:stack,CS:code

START:
	mov ax,stack
	mov ss,ax
	mov sp,800;程序设定

   	mov AL,00110100B
	;计数器0控制寄存器，先读低8位，再读高8位，方式2，计数方式二进制
    mov DX,IO2+6   ;写方式字 0000 0100 0000 01(A2=1)1(A1=1)0
	out DX,AL
	
	mov AX,2E9CH;
	mov DX,IO2;写入计数器0 0000 0100 0000 00(A2=0)0(A1=0)0
	out DX,AL
	MOV AL,AH
	OUT DX,AL
	
	MOV AL,01010110B;0101 0110B
	mov DX,IO2+6
	out DX,AL
	MOV AX,100
	mov DX,IO2+2;写入计数器1 0000 0100 0000 00(A2=0)1(A1=1)0
	out DX,AL
	
	MOV DX,IO3
	MOV AL,01H
	OUT DX,AL
	;jmp $
	MOV BX,500
	
WIAT:
	MOV CX,882
	LOOP $
	
	DEC BX 
	JNZ WIAT
	MOV DX,IO3
	MOV AL,00H
	OUT DX,AL
LDQ:JMP LDQ
EXIT:RET
code ends
    	end START