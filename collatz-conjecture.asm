; -----------------------------------------------------------------------
; Collatz Conjecture - 8 bit target, 16 bit aware
; Return stopping time
; 16 bit awareness is to prevent overflow with 3n+1
;
; 34 bytes
; TT-states 9408 worst case
; ------------------------------------------------------------------------
org &8000

Start:
	ld b, 0             ; B = total steps
	ld hl, Target       ; HL = starting number
	ld a, h
	or a
	jr z, Finish	    ; return 0 if target = 0

Check:                  ; check if L is 1
	ld a, l
	cp 1
	jr z, Finish	

CheckOdd:               ; check if L is odd
	inc b               ; increment step
	ld a, l
	and 1
	jr z, IsEven        ; fall through to IsOdd if nz

IsOdd:
	ld d, h
	ld e, l
	add hl, de
	add hl, de
	inc hl              ; 3n + 1
	jr Check

IsEven:
	srl h	
	rr l                ; / 2
	jr Check

Finish
	ld a, b             ; A = total steps

Target equ 17           ; starting number (255 max)