	include "cbm.i"


	global _clrscr

	section text

_clrscr:
	lda #$93
	jmp $ffd2
