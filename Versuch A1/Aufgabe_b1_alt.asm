; Programmierung eines Lauflichtes
; auf der rechten LED-Reihe soll ein Lichtpunkt von
; links nach rechts laufen und dann wieder links beginnen

; AUFGABE 1 NOCHMAL, NUR MIT ROTIEREN

MOV EDX, 400000H 
MOV [verzoe], EDX   ; Wartezeit            

MOV AL, 80H

m1: OUT 5DH, AL
    ROR AL, 1
    CALL zeit
    JMP m1    
    
zeit:               ; Programm zum Zeit verbrauchen
    MOV ECX, [verzoe]
z1: DEC ECX
    JNZ z1
    RET           
    
; Datenbereich
voerzoe DD ? 