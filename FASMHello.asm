extern io_get_dec, io_print_dec

section .bss
    n resd 1
    tmp resd 1
    tmp2 resd 1
 
 

section .data
    res dd 0
    cnt dd 0

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;
    call io_get_dec
    mov dword[n], eax
    call io_get_dec
    mov ebx, eax; ebx = k
    xor ecx, ecx
    ;
    ;ищем позицию старшего бита в числе n
    mov eax, dword[n]
.loop1:
    shr eax, 1
    cmp eax, 0
    je .find_m
    inc ecx
    jmp .loop1
    
    
.find_m:
    ; len = ecx
    mov esi, ecx
   
.loop:
    dec esi; позиция бита
    cmp ecx, 0; ecx < 0 ?
    jl .end_loop
    cmp dword[cnt], ebx; cnt >= K ?
    jge .end_loop
    bt dword[n], esi
    jc .is_one
    inc dword[cnt]
    dec ecx
    jmp .loop
    .is_one:    
        mov eax, ecx
        sub eax, ebx
        add eax, dword[cnt]; eax = len - (k - cnt) + 1
        inc eax
        mov edi, eax
        .c1:
            inc edi
            cmp edi, ecx; eax > len?
            jg .end_c1
            mul edi; eax *= edi
            jmp .c1
        
        .end_c1:
        ;eax = len * ... * (len -K + cnt)
        mov dword[tmp], eax
        mov eax, 1
        mov edi, eax
        .c2:
            inc edi
            cmp edi, ebx; 
            jg .end_c2
            mul edi; eax = *= edi
            jmp .c2
            
        .end_c2:
            mov dword[tmp2], eax
            mov eax, dword[tmp]
            xor edx, edx
            div dword[tmp2]
            ;eax = C(len, K - cnt)
            add dword[res], eax
            dec ecx
            inc dword[cnt]
            jmp .loop
    

.end_loop:
    cmp dword[cnt], ebx
    jne .not_equal
    inc dword[res]
    
    .not_equal:
    
    mov eax, dword[res]
    call io_print_dec
    
    xor eax, eax
    ret
