; Programmierung eines Lauflichtes
; auf der rechten LED-Reihe soll ein Lichtpunkt von
; links nach rechts laufen und dann wieder links beginnen

MOV EDX, 400000H 
MOV [verzoe], EDX   ; Wartezeit          

MOV ESI, OFFSET led
m1: MOV EDI, 8      ; Ansteuern des linkesten Bits
m2: MOV AL, [ESI+EDI-1]
    OUT 5DH, AL     ; Bit leuchten lassen
    CALL zeit  
    DEC EDI
    JZ m1           ; wenn rechts -> start von links
    JMP m2   
    
zeit:               ; Programm zum Zeit verbrauchen
    MOV ECX, [verzoe]
z1: DEC ECX
    JNZ z1
    RET           
    
; Datenbereich
voerzoe DD ?    
led DB 01H, 02H, 04H, 08H, 10H, 20H, 40H, 80H
    ; Belegung fuer die LEDs
    ; alternativer Versuch per Rotation
