
extern canonical_off
extern canonical_on

lencadena equ 255
bskey equ 8

section .data
    msg1 db 'Captura una cadena: ', 0
    msg2 db 10, 'Cadena en mayusculas: ', 0
    msg3 db 10, 'Cadena en minusculas: ', 0
    salto db 10, 0

section .bss
    cadena resb lencadena

section .text
    global _start

_start:
    ; Pedir mensaje
    mov edx, msg1
    call puts

    ; Capturar mensaje
    mov edx, cadena
    mov ax, lencadena
    call captura

    ; Convertir a mayusculas
    mov edx, cadena
    call mayusculas

    mov edx, msg2
    call puts

    mov edx, cadena
    call puts

    ; Convertir a minusculas
    mov edx, cadena
    call minusculas

    mov edx, msg3
    call puts

    mov edx, cadena
    call puts

    mov edx, salto
    call puts

    ; Fin del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80


; Mostrar un caracter de AL
putchar:
    push eax
    push ebx
    push ecx
    push edx

    push eax
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 0x80
    pop eax

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret


; Mostrar cadena apuntada por EDX
puts:
    push eax
    push edx

.sig:
    mov al, [edx]
    cmp al, 0
    je .fin

    call putchar
    inc edx
    jmp .sig

.fin:
    pop edx
    pop eax
    ret


; Capturar una tecla sin mostrarla
getch:
    call canonical_off

    push ebx
    push ecx
    push edx

    sub esp, 4
    mov eax, 3
    mov ebx, 0
    mov ecx, esp
    mov edx, 1
    int 0x80

    movzx eax, byte [esp]
    add esp, 4

    push eax
    call canonical_on
    pop eax

    pop edx
    pop ecx
    pop ebx
    ret


; Capturar y mostrar una tecla
getche:
    call getch
    call putchar
    ret


; Capturar mensaje
; EDX = direccion de mensaje
; AX = capacidad total
captura:
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov esi, edx
    movzx edi, ax
    xor ebx, ebx

    cmp edi, 0
    je .fin
    dec edi

.leer:
    call getch

    cmp al, 10
    je .terminar

    cmp al, 13
    je .terminar

    cmp al, bskey
    je .retroceso

    cmp al, 127
    je .retroceso

    cmp ebx, edi
    jae .leer

    mov [esi + ebx], al
    inc ebx
    call putchar
    jmp .leer

.retroceso:
    cmp ebx, 0
    je .leer

    dec ebx
    call borrar
    jmp .leer

.terminar:
    mov byte [esi + ebx], 0
    mov al, 10
    call putchar
    jmp .salir

.fin:
    mov byte [esi], 0

.salir:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret


; Borrar un caracter de la terminal
borrar:
    push eax

    mov al, 8
    call putchar

    mov al, ' '
    call putchar

    mov al, 8
    call putchar

    pop eax
    ret


; Convertir mensaje a mayusculas
mayusculas:
    push eax
    push edx

.sig:
    mov al, [edx]
    cmp al, 0
    je .fin

    cmp al, 'a'
    jb .siguiente

    cmp al, 'z'
    ja .siguiente

    sub byte [edx], 32

.siguiente:
    inc edx
    jmp .sig

.fin:
    pop edx
    pop eax
    ret


; Convertir mensaje a minusculas
minusculas:
    push eax
    push edx

.sig:
    mov al, [edx]
    cmp al, 0
    je .fin

    cmp al, 'A'
    jb .siguiente

    cmp al, 'Z'
    ja .siguiente

    add byte [edx], 32

.siguiente:
    inc edx
    jmp .sig

.fin:
    pop edx
    pop eax
    ret
