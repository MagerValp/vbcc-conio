	include "cbm.i"


	global _cpeekrevers

	section text

_cpeekrevers:
	ldy CURS_X
	lda (SCREEN_PTR),y
	and #$80
	asl
	rol
	rts
