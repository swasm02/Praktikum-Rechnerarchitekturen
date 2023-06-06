; Umschaltfunktion fuer die Geschwindigkeit
; linker Schalter (Port 58H) -> schnell (Schalter oben)
;                            -> langsam (Schalter unten)
; auf Port 58H Bits ueberpruefen: 80H (L), 01H (R)
; Schalter ergeben in oberen Stellung Eins-Pegel und 
;                  in unterer Stellung Null-Pegel
; rechter Schalter soll zwischen "nach links" 
; und zwischen "nach rechts" unterscheiden    
; Ergaenzung: 
; druecken einer der blauen Tasten resultiert in kurzzeitige
; Inversion (nur so lange, wie Tasten gedrueckt!)
        
           
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
    JMP LROrRL
    
slow: 
    MOV EBX, 1

; Left->Right or Right->Left?  
; Schalter oben -> LR
; Schalter unten -> RL
LROrRL:
    BT EAX, 0
    JC LR
    JMP RL 
    
LR:
    ROR DL, 1
    CALL output
    JMP SlowOrFast 

RL:
    ROL DL, 1 
    CALL output
    JMP SlowOrFast 

output: 
    IN AL, 59H       ; Ueberpruefen, ob eine der Tasten gedrueckt ist
    CMP AL, 0
    JZ normal
    JNZ notnormal    ; wenn eine der Tasten gedrueckt ist -> Negation von AL in Ausgabe

normal:
    MOV AL, DL
    OUT 5DH, AL 
    JMP z 

notnormal:
    MOV AL, DL
    NOT AL
    OUT 5DH, AL
    
z:  call zeit
    RET

zeit:
    MOV ECX, [verzoe]
z1: SUB ECX, EBX 
    JNZ z1
    RET        
    
; Datenbereich                    
verzoe DD ?
