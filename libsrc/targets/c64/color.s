	include "cbm.i"


	global _textcolor
	global _bgcolor
	global _bordercolor

	section text

_textcolor:
	tax
	lda CHARCOLOR
	and #$0f
	stx CHARCOLOR
	rts

_bgcolor:
	tax
	lda VIC_BGCOLOR
	and #$0f
	stx VIC_BGCOLOR
	rts

_bordercolor:
	tax
	lda VIC_BORDERCOLOR
	and #$0f
	stx VIC_BORDERCOLOR
	rts
