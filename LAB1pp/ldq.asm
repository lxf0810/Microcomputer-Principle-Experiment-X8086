stack segment
dw 10 dup(?)
stack ends

code segment 
assume ss:stack

START:
	mov ax,stack
	mov ss,ax
	mov sp,800;程序设定
	
   	mov BX,0aaaaH
    L:  mov DX,030H
    	in AL,DX
    	test AL,1
    	jz M
    	not BX
    N:  mov AX,BX
        mov DX,030H
        out DX,AX
		
		PUSH BX
	
	;delay:
	;	mov cx,02h
	;	loop delay 
		
		
		MOV BX,0001H
		mov cx,0fh
		
	E:	mov AX,BX
        mov DX,030H
        out DX,AX
		ROL BX,1;循环左移
		LOOP E;CX!=0
	
	M:	mov BX,0ffffh
		mov AX,BX
        mov DX,030H
        out DX,AX
		
	;	POP BX
	;M:  mov AX,BX
    ;    mov DX,030H
    ;    out DX,AX
		
		POP BX
        jmp L
code ends
    	end START