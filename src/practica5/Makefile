build:
	@for i in a b c d e f; do \
		nasm -f elf p5$$i.asm -o p5$$i.o || exit 1; \
		ld -m elf_i386 p5$$i.o -o ../../bin/practica5$$i.exe ../../lib/libpc_io.a || exit 1; \
	done

run:
	@for i in a b c d e f; do \
		echo "========== INCISO $$i =========="; \
		../../bin/practica5$$i.exe || exit 1; \
		echo ""; \
	done