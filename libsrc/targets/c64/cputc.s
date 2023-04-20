	include "cbm.i"


	global _cputc
	global _putchar_

	extern plot

	section text

_cputc:
_putchar_:
	cmp #$0d		; \n is translated to $0d
	bne :+
.newline
	inc CURS_Y
.cr:
	lda #0
	sta CURS_X
	jmp plot
:
	cmp #$0a		; \r is translated to $0a
	beq .cr

	cmp #$20
	bcc .putchar

	tay
	bmi .hibit

	cmp #$60
	bcc :+
	and #$df
	bne .putchar		; bra
:
	and #$3f
	bpl .putchar		; bra

.hibit:
	and #$7f
	cmp #$7e		; pi
	bne :+
	lda #$5e
	bne .putchar
:
	ora #$40
	;bne .putchar

.putchar:
	ora RVS
	ldy CURS_X
	sta (SCREEN_PTR),y
	lda CHARCOLOR
	sta (CRAM_PTR),y

	cpy #SCREEN_WIDTH - 1
	bcs .newline

	inc CURS_X
	rts
