#include <stdio.h>
#include <string.h>
#include <conio.h>


int main(void) {
    unsigned char x;
    unsigned char y;

    clrscr();
    revers(1);
    cputs("Hello, world!\n");
    revers(0);
    cputs("Line two\n");
    cputs("Line florpflorp\rLine three\n");
    gotoxy(0, 5);
    cprintf("Hello %s!\n", "world");
    cprintf("Large number: %ld\n", 574839257);
    cprintf("Right adjusted string: <%20s>\n", "blahonga");

    gotox(37);
    gotoy(12);
    cputs("Hello!");
    for (x = 35; x <= 44; x++) {
        gotoxy(x, 11);
        cputc(0x60);
        gotoxy(x, 13);
        cputc(0x60);
    }
    for (y = 11; y <= 13; y++) {
        gotoxy(34, y);
        cputc(0xab);
        gotoxy(45, y);
        cputc(0xb3);
    }

    cputsxy(0, 8, "Text from top line: <          >");
    char buf[11];
    gotoxy(0, 0);
    cpeeks(buf, 10);
    cputsxy(21, 8, buf);
    cputc('\n');

    x = wherex();
    y = wherey();
    gotoxy(0, 0);
    unsigned char rev0 = cpeekrevers();
    gotoxy(0, 1);
    unsigned char rev1 = cpeekrevers();
    gotoxy(x, y);
    cprintf("Reverse on line 0 = %d, reverse on line 1 = %d\n", rev0, rev1);

    unsigned char width;
    unsigned char height;
    cprintf("width at $%04x, height at $%04x\n", &width, &height);
    screensize(&width, &height);
    cprintf("Screen is %dx%d\n", width, height);

    cputs("Waiting for key: ");
    cursor(1);
    char c = cgetc();
    cprintf("got key '%c'", c);


    cputsxy(0, 24, "Press a key to exit");
    while (!kbhit());
    cgetc();
}
