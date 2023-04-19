	include "cbm.i"


	global _gotox

	extern plot

	section text

_gotox:
	sta CURS_X
	jmp plot
