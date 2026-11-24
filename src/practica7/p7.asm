%include "../../lib/pc_io.inc"

ln equ 10
bskey equ 127

section .data
    msg1 db "Introduce un numero: ",0
    msg_atoi db "atoi -> ",0
    msg_itoa db "itoa -> ",0
    lencadena equ 64

section .bss
    cadena resb 64
    resultado resb 64

section .text
    global _start

_start:
    ; CAPTURAR CADENA
    mov edx,msg1
    call puts

    mov edx,cadena
    mov ax,lencadena
    call captura

    ; CONVERTIR CADENA A ENTERO
    mov esi,cadena
    call atoi
    add eax, 35

    ; CONVERTIR ENTERO A CADENA
    mov edi,resultado
    mov ecx,64
    call itoa

    ; MOSTRAR RESULTADO DE ATOI
    mov edx,msg_atoi
    call puts

    mov edx,resultado
    call puts

    mov al,10
    call putchar

    ; MOSTRAR RESULTADO DE ITOA
    mov edx,msg_itoa
    call puts

    mov edx,resultado
    call puts

    mov al,10
    call putchar

    ; TERMINAR PROGRAMA
    mov eax,1
    xor ebx,ebx
    int 0x80


; PROCEDIMIENTO ATOI
; ESI = direccion de cadena
; EAX = numero entero

atoi:
    xor eax,eax
    xor ebx,ebx

.espacios:
    mov cl,[esi]
    cmp cl,' '
    je .siguiente
    cmp cl,9
    je .siguiente
    jmp .signo

.siguiente:
    inc esi
    jmp .espacios

.signo:
    cmp cl,'-'
    jne .positivo
    mov bl,1
    inc esi
    jmp .convertir

.positivo:
    cmp cl,'+'
    jne .convertir
    inc esi

.convertir:
    mov cl,[esi]

    cmp cl,'0'
    jb .fin

    cmp cl,'9'
    ja .fin

    imul eax,eax,10

    sub cl,'0'
    movzx ecx,cl
    add eax,ecx

    inc esi
    jmp .convertir

.fin:
    cmp bl,1
    jne .salir
    neg eax

.salir:
    ret


; PROCEDIMIENTO ITOA
; EAX = numero entero
; EDI = direccion del resultado
; ECX = longitud del buffer
; EAX = direccion de la cadena resultante

itoa:
    push ebx
    push esi
    push edi
    push ebp

    mov ebp,edi
    mov ebx,10
    xor esi,esi
    xor ecx,ecx

    cmp eax,0
    jge .dividir

    mov esi,1

.dividir:
    cdq
    idiv ebx

    cmp edx,0
    jge .digito
    neg edx

.digito:
    add dl,'0'
    push edx
    inc ecx

    cmp eax,0
    jne .dividir

    cmp esi,1
    jne .escribir

    mov byte [edi],'-'
    inc edi

.escribir:
    pop edx
    mov [edi],dl
    inc edi
    loop .escribir

    mov byte [edi],0

    mov eax,ebp

    pop ebp
    pop edi
    pop esi
    pop ebx
    ret


; PROCEDIMIENTO CAPTURA
captura:
    push ebx
    push ecx
    push edx

    mov ebx,edx
    movzx ecx,ax
    dec ecx

.ciclo:
    call getch

    cmp al,ln
    je .fin

    cmp al,13
    je .fin

    cmp al,bskey
    je .retroceso

    cmp al,8
    je .retroceso

    cmp ecx,0
    je .ciclo

    cmp al,32
    jb .ciclo

    mov [ebx],al
    inc ebx
    dec ecx

    call putchar
    jmp .ciclo

.retroceso:
    cmp ebx,edx
    je .ciclo

    dec ebx
    inc ecx
    call borrar
    jmp .ciclo

.fin:
    mov byte [ebx],0
    mov al,10
    call putchar

    pop edx
    pop ecx
    pop ebx
    ret


; PROCEDIMIENTO BORRAR
borrar:
    push ax

    mov al,0x8
    call putchar

    mov al,' '
    call putchar

    mov al,0x8
    call putchar

    pop ax
    ret