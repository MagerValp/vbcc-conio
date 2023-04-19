#ifndef __CBM_H
#define __CBM_H



/* Check for errors */
#if !defined(__cbm__)
#error This header contains CBM-specific definitions
#endif


#if defined(__c64__)
#include <c64.h>
#elif defined(__pet__)
#include <pet.h>
#endif


#define CH_HLINE        192
#define CH_VLINE        221
#define CH_ULCORNER     176
#define CH_URCORNER     174
#define CH_LLCORNER     173
#define CH_LRCORNER     189
#define CH_TTEE         178
#define CH_BTEE         177
#define CH_LTEE         171
#define CH_RTEE         179
#define CH_CROSS        219
#define CH_CURS_UP      145
#define CH_CURS_DOWN     17
#define CH_CURS_LEFT    157
#define CH_CURS_RIGHT    29
#define CH_PI           222
#define CH_HOME          19
#define CH_DEL           20
#define CH_INS          148
#define CH_ENTER         13
#define CH_STOP           3
#define CH_LIRA          92
#define CH_ESC           27
#define CH_FONT_LOWER    14
#define CH_FONT_UPPER   142


#endif
