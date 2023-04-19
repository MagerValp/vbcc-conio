	include "cbm.i"


	global _gotoy

	extern plot

	section text

_gotoy:
	sta CURS_Y
	jmp plot
