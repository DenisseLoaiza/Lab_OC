section .text

global set_bit
global get_bit

; Activar un bit especifico
set_bit:
    push ebp
    mov ebp, esp

    mov edx, [ebp+8]
    mov cl, [ebp+12]

    mov al, 1
    shl al, cl
    or [edx], al

    pop ebp
    ret

; Obtener el valor de un bit
get_bit:
    push ebp
    mov ebp, esp

    movzx eax, byte [ebp+8]
    mov cl, [ebp+12]

    shr al, cl
    and al, 1

    pop ebp
    ret
