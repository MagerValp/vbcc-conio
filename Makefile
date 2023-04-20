
.PHONY: all
all: pet c64


.PHONY: pet
pet:
	make target=pet -f target.mk all

.PHONY: c64
c64:
	make target=c64 -f target.mk all


.PHONY: clean
clean:
	make target=pet -f target.mk clean
	make target=c64 -f target.mk clean

.PHONY: distclean
distclean: clean
	rm -f *~
	find . -name .DS_Store -print0 | xargs -0 rm -f



.PHONY: xpet
xpet:
	make target=pet -f target.mk xpet

.PHONY: x64sc
x64sc:
	make target=c64 -f target.mk x64sc

