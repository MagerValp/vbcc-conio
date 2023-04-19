	include "cbm.i"


	global plot

	section text

plot:
	ldy CURS_Y
	lda scr_lo,y
	sta SCREEN_PTR
	lda scr_hi,y
	ldy SCR_LINELEN
	cpy #41
	bcc :+
	asl SCREEN_PTR
	rol
:	ora #$80
	sta SCREEN_PTR + 1
	rts


	section rodata

scr_lo:	
	byte $00, $28, $50, $78, $a0, $c8, $f0, $18
	byte $40, $68, $90, $b8, $e0, $08, $30, $58
	byte $80, $a8, $d0, $f8, $20, $48, $70, $98
	byte $c0

scr_hi:
	byte $00, $00, $00, $00, $00, $00, $00, $01
	byte $01, $01, $01, $01, $01, $02, $02, $02
	byte $02, $02, $02, $02, $03, $03, $03, $03
	byte $03


