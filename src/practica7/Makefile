
all: p7

p7: p7.o
	ld -m elf_i386 p7.o -o ../../bin/practica7.exe ../../lib/libpc_io.a

p7.o: p7.asm
	nasm -f elf32 p7.asm -o p7.o

run: p7
	../../bin/practica7.exe

clean:
	rm -f p7.o ../../bin/practica7.exe
