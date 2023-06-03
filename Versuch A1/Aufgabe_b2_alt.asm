; Umschaltfunktion fuer die Geschwindigkeit
; linker Schalter (Port 58H) -> schnell (Schalter oben)
;                            -> langsam (Schalter unten)
; auf Port 58H Bits ueberpruefen: 80H (L), 01H (R)
; Schalter ergeben in oberen Stellung Eins-Pegel und 
;                  in unterer Stellung Null-Pegel       
                                          
; ALTERNATIVE ZU AUFGABE 2 MIT ROTIEREN
                                          
MOV EDX, 400000H 
MOV [verzoe], EDX       ; Wartezeit              

; Basiswert -> dient zum Rotieren
MOV DL, 80H
        
; Evaluieren, ob schnell oder langsam
; entweder um 1 verringern oder um 2        
SlowOrFast:
    IN AL, 58H
    BT EAX, 7
    JC fast
    JMP slow
    
fast:
    MOV EBX, 2
    JMP output
    
slow: 
    MOV EBX, 1
 
output: 
    ROR DL, 1
    MOV AL, DL
    OUT 5DH, AL
    call zeit  
    JMP SlowOrFast

zeit:
    MOV ECX, [verzoe]
z1: SUB ECX, EBX 
    JNZ z1
    RET        
    
; Datenbereich                    
verzoe DD ?