	include "cbm.i"


	global _cpeekcolor
	global _textcolor
	global _bgcolor
	global _bordercolor

	section text

_cpeekcolor:
_textcolor:
	lda #1
	rts

_bgcolor:
_bordercolor:
	lda #0
	rts
