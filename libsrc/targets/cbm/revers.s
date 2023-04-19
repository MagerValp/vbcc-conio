	include "cbm.i"


	global _revers

	section text

_revers:
	ldy RVS
	lsr
	ror
	sta RVS
	tya
	asl
	rol
	rts
