	include "cbm.i"


	global _cgetc

	extern cursor_enabled

	section text

_cgetc:
	lda KEY_COUNT
	bne .getbuf

	lda cursor_enabled
	eor #1
	sta CURS_FLAG

:	lda KEY_COUNT
	beq :-

	lda #1
	sta CURS_FLAG
	lda CURS_STATE
	beq :+

	ldy CURS_X
	lda (SCREEN_PTR),y
	eor #$80
	sta (SCREEN_PTR),y
 ifdef CURS_COLOR
	lda CURS_COLOR
	sta (CRAM_PTR),y
 endif
	lda #0
	sta CURS_STATE
:

.getbuf:
 ifdef KBDREAD
	jmp KBDREAD
 else
	php
	sei
	ldy KEY_BUF

	ldx #0
:	lda KEY_BUF + 1,x
	sta KEY_BUF,x
	inx
	cpx KEY_COUNT
	bne :-
	dec KEY_COUNT

	plp
	tya
	rts
 endif
