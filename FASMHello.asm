extern io_get_dec, io_print_dec

section .bss
    array resd 1000000
    n resd 1
    
section .data
    tmp dd -2147483648, -2147483648, -2147483648


    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    call io_get_dec
    mov dword[n], eax
    xor esi, esi; i = 0
    
.loop:
    cmp esi, dword[n]
    jge .loop_end; если i >= n
    
    call io_get_dec
    
    jmp .find_min
    
.loop_end:   
    
    
    
    
    xor eax, eax
    ret
