IO3 EQU 0030H
CODE  SEGMENT 'CODE'
    ASSUME CS:CODE,DS:CODE
MAIN PROC FAR
START:MOV AX,CODE
      MOV DS,AX
	  
L:    MOV AL,10000001B
; D7:置放向字1有效 D6-5：方式0 D4：端口A输出
; D3：端口C上半部分输出 D2：方式0 D1：端口B输出 D0:端口C下半部分输入
; 端口C上半部分 PC7-4  
      MOV DX,IO3+6;0110 数据总线->控制字寄存器 配合OUT指令
      OUT DX,AL
	  
      MOV DX,IO3+4;0100 数据总线->端口C 配合OUT指令
      MOV AL,00
      OUT DX,AL;端口C上半部分输出0000即：PC7-4=0000
	  
	  ;MOV DX,IO3+4;0100 端口C->数据总线  配合IN指令
NOKEY:IN AL,DX    ;采集端口C低 四位数据
      AND AL,0FH  
      CMP AL,0FH  ;判断是否有按键按下
      JZ NOKEY     
      CALL DELAY10;延时消抖
	  
      IN AL,DX    ;进一步 判断是否有按键按下
      MOV BL,0
      MOV CX,4
	  
LP1:  SHR AL,1;右移一位,将最低位移到C标志中
      JNC LP2  ;判断C标志，检测哪个按键按下,检测到跳转到LP2
      INC BL   ;状态标志加一，用于后续判断
      LOOP LP1 ;没检测到按键，继续检测
	  
LP2:  MOV AL,10001000B
; D7:置放向字1有效 D6-5：方式0 D4：端口A输出
; D3：端口C上半部分输入  D2：方式0 D1：端口B输出 D0:端口C下半部分输出
; 端口C上半部分 PC7-4
      MOV DX,IO3+6;0110 数据总线->控制字寄存器 配合OUT指令
      OUT DX,AL
	  
      MOV DX,IO3+4;0100 数据总线->端口C  配合OUT指令
      MOV AL,00   ;端口C下半部分输出 0000即：PC3-0=0000
      OUT DX,AL
	  
      IN AL,DX  ;采集端口C高 四位数据
      AND AL,0F0H
      CMP AL,0F0H ;判断是否有按键按下
      JZ L		  ;ZF=1 说明无按键按下。跳转到L处，重新检测按键
	  
      MOV BH,0
      MOV CX,4
	  
LP3:  SHL AL,1  ; 左移一位,将最高位送到C中
      JNC LP4   ;判断C标志，检测哪个按键按下,检测到跳转到LP2
      INC BH
      LOOP LP3
	  
LP4:  MOV AX,4
      MUL BH
      ADD AL,BL
      MOV DX,IO3+2;0010 数据总线->端口B  配合OUT指令
      OUT DX,AL
	  
      MOV BX,OFFSET SEGDATA
      XLAT
      MOV DX,IO3;0000 数据总线->端口A  配合OUT指令
      OUT DX,AL
	  
      MOV CX,0
J1:   LOOP J1;65536*17/fclk
      JMP L
      RET
MAIN  ENDP

;延时子程序
DELAY10 PROC
      MOV CX,882
      LOOP $;一个loop执行周期17个时钟周期
      RET
DELAY10 ENDP
;共阴数码管
SEGDATA DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH,77H,7CH,39H,5EH,79H,71H
CODE ENDS
 END START
   



