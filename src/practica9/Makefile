build:
	gcc -m32 -c main.c
	nasm -f elf funciones.asm
	gcc -m32 funciones.o main.o -no-pie -z noexecstack -o ../../bin/practica9.exe

run:
	./../../bin/practica9.exe

clean:
	rm -f *.o ../../bin/practica9.exe
