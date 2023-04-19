	include "cbm.i"


	global _cursor
	global cursor_enabled

	section text

_cursor:
	tay
	lda cursor_enabled
	sty cursor_enabled
	rts

	section bss

cursor_enabled:	reserve 1
