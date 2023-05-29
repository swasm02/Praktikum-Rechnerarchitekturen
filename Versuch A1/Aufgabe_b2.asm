; Umschaltfunktion fuer die Geschwindigkeit
; linker Schalter (Port 58H) -> schnell (Schalter oben)
; rechter Schalter (Port 58H) -> langsam (Schalter unten)
; auf Port 58H Bits ueberpruefen: 80H (L), 01H (R)
; Schalter ergeben in oberen Stellung Eins-Pegel und 
;                  in unterer Stellung Null-Pegel            
           
MOV EDX, 400000H 
MOV [verzoe], EDX       ; Wartezeit              

    MOV ESI, OFFSET led  
    
new: 
    MOV EDI, 8    
    
check: 
    IN AL, 58H
    BT EAX, 7
    JC fast
    JMP slow    
    
fast:
    MOV AL, [ESI+EDI-1]
    OUT 5DH, AL
    
    ; eingefuegtes Unterprogramm Zeit 
    MOV ECX, 200000H 
    z1:
        DEC ECX
        JNZ z1   
    
    DEC EDI
    JZ new
    JMP check

slow:
    MOV AL, [ESI+EDI-1]
    OUT 5DH, AL
    
    ; eingefuegtes Unterprogramm Zeit 
    MOV ECX, 600000H 
    z1:
        DEC ECX
        JNZ z1   
    
    DEC EDI
    JZ new
    JMP check
    
; Datenbereich
led DB 01H, 02H, 04H, 08H, 10H, 20H, 40H, 80H    