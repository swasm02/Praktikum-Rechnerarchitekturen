MOV EDX, 400000H 
MOV [verzoe], EDX             

m1: MOV EDI, 10
    MOV ESI, OFFSET ziff
    
m2: MOV AL, [ESI+EDI-1]
    OUT 0B0, AL
    CALL zeit
    DEC EDI
    JNZ m2
    MOV AL, 0FFH
    
m3: OUT 5CH, AL
    NOT AL
    OUT 5DH, AL
    CALL zeit
    MOV BL, AL 
    
    IN AL, 59H
    BT EAX, 7  
    MOV AL, BL
    JC m1
    JMP m3   
    
zeit:
    MOV ECX, [verzoe]
z1: DEC ECX
    JNZ z1
    RET