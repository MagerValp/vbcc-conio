#include <conio.h>


void cvline(unsigned char length) {
    unsigned char x = wherex();
    unsigned char y = wherey();

    for (unsigned char l = 0; l < length; l++) {
        cputc(CH_VLINE);
        gotoxy(x, y + l);
    }
}
