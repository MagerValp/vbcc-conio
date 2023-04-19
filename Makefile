.PHONY: all clean distclean

all:
	make target=pet -f target.mk all
	#make target=c64 -f target.mk all

clean:
	find libsrc -name '*.o' -print0 | xargs -0 rm -f
	find lib -name '*.a' -print0 | xargs -0 rm -f
	find test \( \
		   -name '*.d64' \
		-o -name '*.prg' \
		-o -name '*.o' \
		-o -name '*.lab' \
		-o -name '*.map' \
		-o -name '*.mon' \
		\) \
		-print0 | xargs -0 rm -f

distclean: clean
	rm -f *~
	find . -name .DS_Store -print0 | xargs -0 rm -f
