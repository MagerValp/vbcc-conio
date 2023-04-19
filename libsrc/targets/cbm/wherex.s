	include "cbm.i"


	global _wherex

	section text

_wherex:
	lda CURS_X
	rts
