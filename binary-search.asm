; -----------------------------------------
; Binary Search - 8 bit
; Return index/offset of target
;
; 47 bytes
; -----------------------------------------
org &8000

Start:
	ld c, 0			; C = START POINT				
	ld b, Size
	dec b			; B = END POINT 

CheckMid:
	ld a, c	   		; check if start > end
	cp b             
	jr nc, NotFound  

DoMid:
	ld hl, Nums		; load the nums list into HL (&8015)
	ld a, b 			; mid = start + ((end - start) >> 1)   ; avoids overflow
	sub c                		; A = end - start
	srl a               		; A = (end - start) >> 1
	add a, c          		; A = start + half_diff
	ld d, 0        
	ld e, a            		; DE = mid
	add hl, de        		; HL = base + mid
	ld a, (hl)        		; A = value at mid
	cp Target 
	jr z, Found 
	jr c, SearchUpper 	  	; if value < target -> search upper half

SearchLower:			; else value > target -> search lower half
	dec e          		; A = mid - 1 (handles underflow in A) - possibly dec e directly
	ld b, e         		; B = new end
	jr CheckMid 

SearchUpper: 
	inc e			; A = mid + 1 - possibly inc e directly
	ld c, e			; C = new start
	jr CheckMid 

; -----------------------------------
; Exit cases
; -----------------------------------
NotFound:
	ld a, 255       		; 255 represents an error, not found
    	ret         

Found:				
	ld a, e			; A =  index/offset for target
	ret            

; -----------------------------------
; Data
; -----------------------------------
Nums: db 2, 3, 7, 10, 128, 254		; a list of 8bit ints to traverse
Size equ 6				; the size of Nums
Target equ 128			; target number to find
