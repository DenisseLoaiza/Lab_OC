%include "../../lib/pc_io.inc"   ; incluir declaraciones de procedimiento externos


section .bss
    cedena resb 255

section .text
    global _start         ; referencia para inicio de programa
    
_start:   
   
    ; --- IMPRIMIR CADENA  ---
    mov edx, msg1        
    call puts           
    jmp .fin_programa  
    
    
    
    ; --- FIN DE PROGRAMA ---
    .fin_programa: 
        mov edx, salto    
        call puts     
        call puts     
        mov eax, 1            ; Llamada sys_exit
	    xor ebx, ebx          ; return 0
        int 0x80              ; Fin de programa


section .data
    lencadena equ 255
    msg1 db 0xa,'Captura: ', 0
    msg2 db 0xa,'Cadena: ', 0
    salto db 0xa