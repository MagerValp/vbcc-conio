#include <conio.h>


void chline(unsigned char length) {
    while (length--) {
        cputc(CH_HLINE);
    }
}
