; Macro WHILE para recorrer el arreglo
%macro WHILE 1
    %%inicio:
        cmp ecx, 0
        jle %%fin

        call %1

        add esi, 4
        dec ecx
        jmp %%inicio

    %%fin:
%endmacro

section .text

global maximo
global minimo
global sumatoria

; Obtener el numero maximo
maximo:
    push ebp
    mov ebp, esp
    push esi

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov eax, [esi]

    WHILE comparar_max

    pop esi
    pop ebp
    ret

comparar_max:
    cmp eax, [esi]
    jge .fin
    mov eax, [esi]

.fin:
    ret

; Obtener el numero minimo
minimo:
    push ebp
    mov ebp, esp
    push esi

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov eax, [esi]

    WHILE comparar_min

    pop esi
    pop ebp
    ret

comparar_min:
    cmp eax, [esi]
    jle .fin
    mov eax, [esi]

.fin:
    ret

; Obtener la sumatoria
sumatoria:
    push ebp
    mov ebp, esp
    push esi

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
    mov eax, 0

    WHILE sumar

    pop esi
    pop ebp
    ret

sumar:
    add eax, [esi]
    ret
