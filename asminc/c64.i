

SCREEN_WIDTH	= 40
SCREEN_HEIGHT	= 25


KEY_COUNT	= $c6	; Number of keys in keyboard buffer
RVS		= $c7	; Reverse flag, $80 = enabled
CURS_FLAG	= $cc	; Cursor enabled, 1 = off
CURS_STATE	= $cf	; Cursor last blink on or off
SCREEN_PTR	= $d1	; Pointer to current screen line
CURS_X		= $d3	; Current cursor column

CURS_Y		= $d6	; Current cursor row
CRAM_PTR	= $f3	; Pointer to current color ram line


CHARCOLOR	= $0286	; Current text color
CURS_COLOR	= $0287	; Color under the cursor


KBDREAD		= $e5b4	; Read from keyboard buffer
CLRSCR		= $e544	; Clear screen


VIC_BORDERCOLOR	= $d020
VIC_BGCOLOR	= $d021


PLOT		= $fff0	; Set or get cursor position
