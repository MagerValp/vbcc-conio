	include "cbm.i"


	global _cpeekcolor

	section text

_cpeekcolor:
	ldy CURS_X
	lda (CRAM_PTR),y
	and #$0f
	rts
