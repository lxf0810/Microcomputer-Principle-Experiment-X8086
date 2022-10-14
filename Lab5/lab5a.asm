a8255 equ 40h
b8255 equ 42h
c8255 equ 44h
Q8255 equ 46h 

adc0808 equ 20h
 

CODE      SEGMENT ;
          ASSUME DS:DATA,CS:CODE

START:   
        MOV AX,DATA
        MOV DS,AX
        
  	mov dx, Q8255
    	mov al, 90h
    	out dx, al
	mov dx, c8255
    	mov al, 0ffh
    	out dx, al   
    	mov al, 0fh
    	out dx, al
	mov al, 0ffh
    	out dx, al 
	mov si,offset tempdata         
here:
    
    	mov dx, adc0808
    	mov al, 0
    	out dx, al
	mov cx,5

mon:	mov al,[si]
	mov ah,0
	mov bl,51
	div bl
	mov bx,offset segdata
	xlat
 	or al,80h
    	mov dx, b8255
    	out dx, al
	mov al,11011111b
	mov dx,c8255
	out dx,al
	 call DELAY_1S

	MOV AL,0ffH               ;«Â∆¡
        OUT dx,AL
	mov al,ah
	mov ah,0
	mov bl,5
	div bl
	mov bx,offset segdata
	xlat
	mov dx, b8255
    	out dx, al
	mov al, 10111111b
	mov dx,c8255
	out dx,al
	 call DELAY_1S

	MOV AL,0ffH               ;«Â∆¡
        OUT dx,AL
  	mov al,01111111b
	out dx,al
	mov al,00011100b
	mov dx,b8255
	out dx,al
	 call DELAY_1S

	mov dx,c8255
	MOV AL,0ffH               ;«Â∆¡
        OUT dx,AL
    	call DELAY_1S
    	loop mon
	
	mov dx, adc0808
    	in al,dx
 	mov [si],al
    	jmp here     
    
DELAY_1S proc
    	PUSH BX
    	PUSH CX
	MOV BX, 1
LP2:	MOV CX, 10
LP1:	LOOP LP1
	DEC BX
	JNZ LP2   
	POP CX
	POP BX
	RET    
DELAY_1S endp 



CODE      ENDS
DATA    SEGMENT
segdata db 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh,77h,7ch,39h,5eh,79h,71h
tempdata db 0
DATA    ENDS
          END START