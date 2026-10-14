%include "../../lib/pc_io.inc"

section .data
    bskey equ 0x7F
    lencadena equ 255
    ln equ 0x0A

    nline db ln,0
    msg1 db ln,'Captura: ',0
    msg2 db ln,'Cadena original: ',0
    msg3 db ln,'Mayusculas: ',0
    msg4 db ln,'Minusculas: ',0

section .bss
    cadena resb lencadena

section .text
    global _start

_start:
    ; --- CAPTURAR CADENA ---
    mov edx,msg1
    call puts

    mov edx,cadena
    mov ax,lencadena
    call captura

    ; --- MOSTRAR CADENA ORIGINAL ---
    mov edx,msg2
    call puts
    mov edx,cadena
    call puts

    ; --- CONVERTIR A MAYUSCULAS ---
    mov edx,cadena
    call mayusculas

    mov edx,msg3
    call puts
    mov edx,cadena
    call puts

    ; --- CONVERTIR A MINUSCULAS ---
    mov edx,cadena
    call minusculas

    mov edx,msg4
    call puts
    mov edx,cadena
    call puts

.fin_programa:
    mov edx,nline
    call puts

    mov eax,1
    xor ebx,ebx
    int 0x80


; --- PROCEDIMIENTO CAPTURA ---
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

    pop edx
    pop ecx
    pop ebx
    ret


; --- PROCEDIMIENTO BORRAR ---
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


; --- PROCEDIMIENTO MAYUSCULAS ---
mayusculas:
    push edx

.ciclo:
    mov al,[edx]
    cmp al,0
    je .fin

    cmp al,'a'
    jb .sig
    cmp al,'z'
    ja .sig

    sub al,32
    mov [edx],al

.sig:
    inc edx
    jmp .ciclo

.fin:
    pop edx
    ret


; --- PROCEDIMIENTO MINUSCULAS ---
minusculas:
    push edx

.ciclo:
    mov al,[edx]
    cmp al,0
    je .fin

    cmp al,'A'
    jb .sig
    cmp al,'Z'
    ja .sig

    add al,32
    mov [edx],al

.sig:
    inc edx
    jmp .ciclo

.fin:
    pop edx
    ret