extern io_print_char
extern io_print_char
extern io_get_dec

section .data
    array1 db '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'
    array2 db 'S', 'C', 'D', 'H'

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    
    call io_get_dec
    
    
    xor edx, edx
    mov ebx, 13
    div ebx
    ;eax = сколко уже было мастей, edx - номер карты 
    
    sub edx, 1
    mov ecx, eax
    movzx eax, byte[array1 + edx]
    call io_print_char
    
    mov eax, ecx
    movzx eax, byte[array2 + eax]
    call io_print_char
    
    
    xor eax, eax
    ret
