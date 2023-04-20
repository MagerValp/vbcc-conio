

KEY_COUNT	= $9e	; Number of keys in keyboard buffer
RVS		= $9f	; Reverse flag, $80 = enabled
CURS_FLAG	= $a7	; Cursor enabled, 1 = off
CURS_STATE	= $aa	; Cursor last blink on or off
SCREEN_PTR	= $c4	; Pointer to current screen line
CURS_X		= $c6	; Current cursor column
SCR_LINELEN	= $d5	; Length of screen line
CURS_Y		= $d8	; Current cursor row


KEY_BUF		= $026f	; Keyboard buffer
