#include <conio.h>


void cpeeks(char *s, unsigned int length) {
    unsigned char x = wherex();
    unsigned char y = wherey();

    while (length--) {
        *s++ = cpeekc();
        gotox(wherex() + 1);
    }
    *s = '\0';
    gotoxy(x, y);
}
