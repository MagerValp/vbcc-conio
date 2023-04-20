	include "cbm.i"


	global _screensize

	extern r0, r2

	section text

_screensize:
	ldy #0
	lda #40
	sta (r0),y
	lda #25
	sta (r2),y
	rts
