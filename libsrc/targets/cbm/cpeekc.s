	include "cbm.i"


	global _cpeekc

	section text

_cpeekc:
	ldy CURS_X
	lda (SCREEN_PTR),y

	and #$7f
	tay

	asl
	asl
	rol
	rol
	and #3
	tax

	tya
	clc
	adc .adjust,x
	rts

	section rodata

.adjust:
	byte $40, $00, $20, $40
