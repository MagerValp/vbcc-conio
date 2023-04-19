ifndef target
$(error No target specified)
endif

TARGET=$(target)
CBM_TARGETS=pet c64
ifneq ($(filter $(TARGET),$(CBM_TARGETS)),)
TARGET_FAMILY=-D__cbm__
endif

CC=vc
CFLAGS=+$(TARGET) $(TARGET_FAMILY) -D__$(TARGET)__ -Iinclude
#AS=vc -as
#AFLAGS=+$(TARGET) -D__cbm__ -D__$(TARGET)__ -I/Users/xolope/Resilio/prog/vbcc/asminc
AS=vasm6502_oldstyle -Fvobj -quiet
AFLAGS= $(TARGET_FAMILY) -D__$(TARGET)__ -Iasminc
LD=vlink
#LDFLAGS=+$(TARGET)
LDFLAGS=-b cbmprg -Cvbcc -T$(VBCC)/targets/6502-$(TARGET)/vlinkr.cmd -L$(VBCC)/targets/6502-$(TARGET)/lib $(VBCC)/targets/6502-$(TARGET)/lib/startupr.o -lvc
C1541=c1541
AR=ar


%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.o: %.s
	$(AS) $(AFLAGS) -o $@ $<

%.d64: %.prg
	@rm -f $@ tmp.d64
	@c1541 -format "genesis*project,$$(date +%y)" d64 tmp.d64
	@c1541 -attach tmp.d64 -write $< $(patsubst %.prg,%,$<)
	@mv tmp.d64 $@



all: test/pet/test_conio.d64 test/pet/test_conio_cc65.d64


CFLAGS+=-DPRINTF_SUPPORT_LONG_LONG=0
CFLAGS+=-DSUPPORT_MSVC_STYLE_INTEGER_SPECIFIERS=0
CFLAGS+=-DPRINTF_SUPPORT_WRITEBACK_SPECIFIER=0
CFLAGS+=-DPRINTF_SUPPORT_DECIMAL_SPECIFIERS=0
CFLAGS+=-DPRINTF_SUPPORT_EXPONENTIAL_SPECIFIERS=0

LIB_PET_OBJS = \
	libsrc/_cprintf.o \
	libsrc/cclear.o \
	libsrc/chline.o \
	libsrc/cpeeks.o \
	libsrc/cputs.o \
	libsrc/cursor.o \
	libsrc/cvline.o \
	libsrc/targets/cbm/cgetc.o \
	libsrc/targets/cbm/cpeekc.o \
	libsrc/targets/cbm/cpeekrevers.o \
	libsrc/targets/cbm/cputc.o \
	libsrc/targets/cbm/gotox.o \
	libsrc/targets/cbm/gotoxy.o \
	libsrc/targets/cbm/gotoy.o \
	libsrc/targets/cbm/kbhit.o \
	libsrc/targets/cbm/revers.o \
	libsrc/targets/cbm/wherex.o \
	libsrc/targets/cbm/wherey.o \
	libsrc/targets/pet/clrscr.o \
	libsrc/targets/pet/color.o \
	libsrc/targets/pet/plot.o \
	libsrc/targets/pet/screensize.o \

LIB_C64_OBJS = \
	libsrc/_cprintf.o \
	libsrc/cclear.o \
	libsrc/chline.o \
	libsrc/cpeeks.o \
	libsrc/cputs.o \
	libsrc/cursor.o \
	libsrc/cvline.o \
	libsrc/targets/cbm/cgetc.o \
	libsrc/targets/cbm/cpeekc.o \
	libsrc/targets/cbm/cpeekrevers.o \
	libsrc/targets/cbm/cputc.o \
	libsrc/targets/cbm/gotox.o \
	libsrc/targets/cbm/gotoxy.o \
	libsrc/targets/cbm/gotoy.o \
	libsrc/targets/cbm/kbhit.o \
	libsrc/targets/cbm/revers.o \
	libsrc/targets/cbm/wherex.o \
	libsrc/targets/cbm/wherey.o \
	libsrc/targets/c64/clrscr.o \
	libsrc/targets/c64/color.o \
	libsrc/targets/c64/plot.o \
	libsrc/targets/c64/screensize.o \


lib/pet/libconio.a: $(LIB_PET_OBJS)
	$(AR) -r $@ $^

test/pet/test_conio.prg: test/test_conio.o lib/pet/libconio.a
	$(LD) $(LDFLAGS) -M$(patsubst %.prg,%.map,$@) -vicelabels $(patsubst %.prg,%.lab,$@) $^ -o $@

test/pet/test_conio_cc65.prg: test/test_conio_cc65.o lib/pet/libconio.a
	$(LD) $(LDFLAGS) -M$(patsubst %.prg,%.map,$@) -vicelabels $(patsubst %.prg,%.lab,$@) $^ -o $@

.PHONY: xpet
xpet: test/pet/test_conio.d64
	@echo 'll "$(patsubst %.d64,%.lab,$<)"' > $(patsubst %.d64,%.mon,$<)
	@if [[ -n "$(break)" ]]; then echo 'break $(break)' >> $(patsubst %.d64,%.mon,$<); fi
	xpet -moncommands $(patsubst %.d64,%.mon,$<) $<
