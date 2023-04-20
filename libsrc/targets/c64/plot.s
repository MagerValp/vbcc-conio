	include "cbm.i"


	global plot

	section text

plot:
	ldy CURS_X
	ldx CURS_Y
	clc
	jmp PLOT
