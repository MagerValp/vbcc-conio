#ifndef __CONIO_H
#define __CONIO_H


#if defined(__cbm__)
#include <cbm.h>
#endif


#include <stdarg.h>
#include <_cprintf.h>


/**
 * Clear the screen and put cursor in top left corner.
 */
void clrscr(void);

/**
 * Return 1 if there is a keypress waiting in the input queue.
 */
unsigned char kbhit(void);

/**
 * Move cursor to column.
 * \param x Column
 */
void gotox(unsigned char x);

/**
 * Move cursor to row.
 * \param y Row
 */
void gotoy(unsigned char y);

/**
 * Move cursor to column and row.
 * \param x Column
 * \param y Row
 */
void gotoxy(unsigned char x, unsigned char y);

/**
 * Return current cursor column.
 */
unsigned char wherex(void);

/**
 * Return current cursor row.
 */
unsigned char wherey(void);


/**
 * Print a character.
 * \param c Character
 */
void cputc(char c);

/**
 * Print a character at x, y.
 * \param x Column
 * \param y Row
 * \param c Character
 */
void cputcxy(unsigned char x, unsigned char y, char c);
#define cputcxy(X, Y, C) do { gotoxy((X), (Y)); cputc((C)); } while (0)

/**
 * Print a null terminated string.
 * \param s Null terminated string
 */
void cputs(const char *s);

/**
 * Print a null terminated string at x, y.
 * \param x Column
 * \param y Row
 * \param s Null terminated string
 */
void cputsxy(unsigned char x, unsigned char y, const char *s);
#define cputsxy(X, Y, S) do { gotoxy((X), (Y)); cputs((S)); } while (0)

/**
 * Print a formatted string.
 * \param format Format string
 * \param ... Format string arguments
 * \return The number of characters printed
 */
int cprintf(const char *format, ...);
#define cprintf printf_
#ifdef __VBCC__
#pragma printflike cprintf
#endif

/**
 * Print a formatted string.
 * \param format Format string
 * \param ap Varargs list
 * \return The number of characters printed
 */
int vcprintf(const char *format, va_list ap);
#define vcprintf vprintf_

/**
 * Get character from keyboard buffer, waiting if empty.
 * \return Character
 */
char cgetc(void);


// int cscanf(const char *format, ...);
// int vcscanf(const char *format, va_list ap);


/**
 * Read the character under the current cursor position.
 * \return Character
 */
char cpeekc(void);

/**
 * Read the color of the character under the current cursor position.
 * \return Color
 */
unsigned char cpeekcolor(void);

/**
 * Check if the character under the current cursor position is reversed.
 * \return 1 if reversed, 0 if not
 */
unsigned char cpeekrevers(void);

/**
 * Read characters at the current cursor position and write them to a null
 * terminated string buffer.
 * \param[out] s String buffer of size length + 1
 * \param length Number of characters to read
 */
void cpeeks(char *s, unsigned int length);

/**
 * Display a cursor when waiting for keyboard input.
 * \param onoff 1 to enable, 0 to disable
 * \return The old setting
 */
unsigned char cursor(unsigned char onoff);

/**
 * Print reverse character text.
 * \param onoff 1 to enable, 0 to disable
 * \return The old setting
 */
unsigned char revers(unsigned char onoff);

/**
 * Set current text color.
 * \param color Color
 * \return The old color
 */
unsigned char textcolor(unsigned char color);

/**
 * Set current background color.
 * \param color Color
 * \return The old color
 */
unsigned char bgcolor(unsigned char color);

/**
 * Set current border color.
 * \param color Color
 * \return The old color
 */
unsigned char bordercolor(unsigned char color);

/**
 * Draw a horizontal line.
 * \param length Length
 */
void chline(unsigned char length);

/**
 * Draw a horizontal line at x, y.
 * \param x Column
 * \param y Row
 * \param length Length
 */
void chlinexy(unsigned char x, unsigned char y, unsigned char length);
#define chlinexy(X, Y, L) do { gotoxy((X), (Y)); chline((L)); } while (0)

/**
 * Draw a vertical line.
 * \param length Length
 */
void cvline(unsigned char length);

/**
 * Draw a vertical line at x, y.
 * \param x Column
 * \param y Row
 * \param length Length
 */
void cvlinexy(unsigned char x, unsigned char y, unsigned char length);
#define cvlinexy(X, Y, L) do { gotoxy((X), (Y)); cvline((L)); } while (0)

/**
 * Draw spaces.
 * \param length Length
 */
void cclear(unsigned char length);

/**
 * Draw spaces at x, y.
 * \param x Column
 * \param y Row
 * \param length Length
 */
void cclearxy(unsigned char x, unsigned char y, unsigned char length);
#define cclearxy(X, Y, L) do { gotoxy((X), (Y)); cclear((L)); } while (0)

/**
 * Get the current screen size.
 * \param[out] x Width
 * \param[out] y Height
 */
void screensize(unsigned char *x, unsigned char *y);

#define cputhex8(V) cprintf("%02X", (unsigned char)(V))
#define cputhex16(V) cprintf("%04X", (unsigned int)(V))


#endif
