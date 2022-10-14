;stack segment
;db 10 dup(?)
;stack ends
code segment 
;assume ss:stack

START:
	;mov ax,stack
	;mov ss,ax
   	mov BL,0FH
    L:  mov DX,020H
    	in AL,DX
    	test AL,1
    	jz N
    	not BL
		;mov BL,0FH
    N:  mov AL,BL
        mov DX,020H
        out DX,AL
        jmp L
code ends
    	end START