ifndef target
$(error No target specified)
endif

TARGET=$(target)
CBM_TARGETS=pet c64
ifneq ($(filter $(TARGET),$(CBM_TARGETS)),)
TARGET_FAMILY=-D__cbm__
endif

CC = vc
CFLAGS = +$(TARGET) $(TARGET_FAMILY) -D__$(TARGET)__ -Iinclude
AS = vasm6502_oldstyle -Fvobj -quiet
AFLAGS =  $(TARGET_FAMILY) -D__$(TARGET)__ -Iasminc
LD = vlink
LDFLAGS = -b cbmprg -Cvbcc -T$(VBCC)/targets/6502-$(TARGET)/vlinkr.cmd -L$(VBCC)/targets/6502-$(TARGET)/lib $(VBCC)/targets/6502-$(TARGET)/lib/startupr.o -lvc
C1541 = c1541
AR = ar


CFLAGS += -DPRINTF_SUPPORT_LONG_LONG=0
CFLAGS += -DSUPPORT_MSVC_STYLE_INTEGER_SPECIFIERS=0
CFLAGS += -DPRINTF_SUPPORT_WRITEBACK_SPECIFIER=0
CFLAGS += -DPRINTF_SUPPORT_DECIMAL_SPECIFIERS=0
CFLAGS += -DPRINTF_SUPPORT_EXPONENTIAL_SPECIFIERS=0


%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

build/$(target)/%.o: libsrc/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

test/$(target)/%.o: test/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(AS) $(AFLAGS) -o $@ $<

build/$(target)/%.o: libsrc/%.s
	@mkdir -p $(dir $@)
	$(AS) $(AFLAGS) -o $@ $<

%.d64: %.prg
	@rm -f $@ tmp.d64
	@c1541 -format "genesis*project,$$(date +%y)" d64 tmp.d64
	@c1541 -attach tmp.d64 -write $< $(patsubst %.prg,%,$<)
	@mv tmp.d64 $@



all: test/$(target)/test_conio.d64 test/$(target)/test_conio_cc65.d64


lib_common_srcs = \
	libsrc/_cprintf.c \
	libsrc/cclear.c \
	libsrc/chline.c \
	libsrc/cpeeks.c \
	libsrc/cputs.c \
	libsrc/cursor.s \
	libsrc/cvline.c \

lib_cbm_srcs = \
	libsrc/targets/cbm/cgetc.s \
	libsrc/targets/cbm/cpeekc.s \
	libsrc/targets/cbm/cpeekrevers.s \
	libsrc/targets/cbm/gotox.s \
	libsrc/targets/cbm/gotoxy.s \
	libsrc/targets/cbm/gotoy.s \
	libsrc/targets/cbm/kbhit.s \
	libsrc/targets/cbm/revers.s \
	libsrc/targets/cbm/wherex.s \
	libsrc/targets/cbm/wherey.s \

lib_pet_srcs = \
	$(lib_common_srcs) \
	$(lib_cbm_srcs) \
	libsrc/targets/pet/clrscr.s \
	libsrc/targets/pet/color.s \
	libsrc/targets/pet/cputc.s \
	libsrc/targets/pet/plot.s \
	libsrc/targets/pet/screensize.s \

lib_c64_srcs = \
	$(lib_common_srcs) \
	$(lib_cbm_srcs) \
	libsrc/targets/c64/clrscr.s \
	libsrc/targets/c64/color.s \
	libsrc/targets/c64/cpeekcolor.s \
	libsrc/targets/c64/cputc.s \
	libsrc/targets/c64/plot.s \
	libsrc/targets/c64/screensize.s \

lib_$(target)_objs = $(subst libsrc,build/$(target),$(patsubst %.s,%.o,$(patsubst %.c,%.o,$(lib_$(target)_srcs))))


lib/$(target)/libconio.a: $(lib_$(target)_objs)
	@mkdir -p $(dir $@)
	$(AR) -r $@ $^

test/$(target)/%.prg: test/$(target)/%.o lib/$(target)/libconio.a
	$(LD) $(LDFLAGS) -M$(patsubst %.prg,%.map,$@) -vicelabels $(patsubst %.prg,%.lab,$@) $^ -o $@


.PHONY: xpet
xpet: test/pet/test_conio.d64
	@echo 'll "$(patsubst %.d64,%.lab,$<)"' > $(patsubst %.d64,%.mon,$<)
	@if [[ -n "$(break)" ]]; then echo 'break $(break)' >> $(patsubst %.d64,%.mon,$<); fi
	xpet -moncommands $(patsubst %.d64,%.mon,$<) $<

.PHONY: x64sc
x64sc: test/c64/test_conio.d64
	@echo 'll "$(patsubst %.d64,%.lab,$<)"' > $(patsubst %.d64,%.mon,$<)
	@if [[ -n "$(break)" ]]; then echo 'break $(break)' >> $(patsubst %.d64,%.mon,$<); fi
	x64sc -moncommands $(patsubst %.d64,%.mon,$<) $<


.PHONY: clean
clean:
	find build/$(target) -name '*.o' -print0 | xargs -0 rm -f
	find lib/$(target) -name '*.a' -print0 | xargs -0 rm -f
	find test/$(target) \( \
		   -name '*.d64' \
		-o -name '*.prg' \
		-o -name '*.o' \
		-o -name '*.lab' \
		-o -name '*.map' \
		-o -name '*.mon' \
		\) \
		-print0 | xargs -0 rm -f
