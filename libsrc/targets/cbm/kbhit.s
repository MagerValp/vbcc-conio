	include "cbm.i"


	global _kbhit

	section text

_kbhit:
	lda KEY_COUNT
	beq :+
	lda #1
:
	rts
