	include "cbm.i"


	global _gotoxy

	extern plot, r2

	section text

_gotoxy:
	sta CURS_X
	lda r2
	sta CURS_Y
	jmp plot
