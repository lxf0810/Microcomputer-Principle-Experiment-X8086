IO3 EQU 0030H
CODE  SEGMENT 'CODE'
    ASSUME CS:CODE,DS:CODE
MAIN PROC FAR
START:MOV AX,CODE
      MOV DS,AX
	  
L:    MOV AL,10000001B
; D7:�÷�����1��Ч D6-5����ʽ0 D4���˿�A���
; D3���˿�C�ϰ벿����� D2����ʽ0 D1���˿�B��� D0:�˿�C�°벿������
; �˿�C�ϰ벿�� PC7-4  
      MOV DX,IO3+6;0110 ��������->�����ּĴ��� ���OUTָ��
      OUT DX,AL
	  
      MOV DX,IO3+4;0100 ��������->�˿�C ���OUTָ��
      MOV AL,00
      OUT DX,AL;�˿�C�ϰ벿�����0000����PC7-4=0000
	  
	  ;MOV DX,IO3+4;0100 �˿�C->��������  ���INָ��
NOKEY:IN AL,DX    ;�ɼ��˿�C�� ��λ����
      AND AL,0FH  
      CMP AL,0FH  ;�ж��Ƿ��а�������
      JZ NOKEY     
      CALL DELAY10;��ʱ����
	  
      IN AL,DX    ;��һ�� �ж��Ƿ��а�������
      MOV BL,0
      MOV CX,4
	  
LP1:  SHR AL,1;����һλ,�����λ�Ƶ�C��־��
      JNC LP2  ;�ж�C��־������ĸ���������,��⵽��ת��LP2
      INC BL   ;״̬��־��һ�����ں����ж�
      LOOP LP1 ;û��⵽�������������
	  
LP2:  MOV AL,10001000B
; D7:�÷�����1��Ч D6-5����ʽ0 D4���˿�A���
; D3���˿�C�ϰ벿������  D2����ʽ0 D1���˿�B��� D0:�˿�C�°벿�����
; �˿�C�ϰ벿�� PC7-4
      MOV DX,IO3+6;0110 ��������->�����ּĴ��� ���OUTָ��
      OUT DX,AL
	  
      MOV DX,IO3+4;0100 ��������->�˿�C  ���OUTָ��
      MOV AL,00   ;�˿�C�°벿����� 0000����PC3-0=0000
      OUT DX,AL
	  
      IN AL,DX  ;�ɼ��˿�C�� ��λ����
      AND AL,0F0H
      CMP AL,0F0H ;�ж��Ƿ��а�������
      JZ L		  ;ZF=1 ˵���ް������¡���ת��L�������¼�ⰴ��
	  
      MOV BH,0
      MOV CX,4
	  
LP3:  SHL AL,1  ; ����һλ,�����λ�͵�C��
      JNC LP4   ;�ж�C��־������ĸ���������,��⵽��ת��LP2
      INC BH
      LOOP LP3
	  
LP4:  MOV AX,4
      MUL BH
      ADD AL,BL
      MOV DX,IO3+2;0010 ��������->�˿�B  ���OUTָ��
      OUT DX,AL
	  
      MOV BX,OFFSET SEGDATA
      XLAT
      MOV DX,IO3;0000 ��������->�˿�A  ���OUTָ��
      OUT DX,AL
	  
      MOV CX,0
J1:   LOOP J1;65536*17/fclk
      JMP L
      RET
MAIN  ENDP

;��ʱ�ӳ���
DELAY10 PROC
      MOV CX,882
      LOOP $;һ��loopִ������17��ʱ������
      RET
DELAY10 ENDP
;���������
SEGDATA DB 3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH,77H,7CH,39H,5EH,79H,71H
CODE ENDS
 END START
   



