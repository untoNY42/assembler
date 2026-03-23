extern io_get_dec, io_print_dec

section .bss
    n resd 1
    k resd 1
    m resd 1
    ;m_1 resd 1

section .data
    res dd 0

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    ;
    call io_get_dec
    mov dword[n], eax
    call io_get_dec
    mov dword[k], eax
    ;
    xor ecx, ecx
    ;ищем позицию старшего бита в числе n (m)
.loop1:
    shr dword[n], 1
    cmp dword[n], 0
    je .find_m
    inc ecx
    jmp .loop1
    
    
.find_m:
    ;считаем сочетания
    ;for(i = k; i < M; ++i){res += С из i по k}
    mov dword[m], ecx
    mov ecx, dword[k]
    ;mov eax, dword[m]
    ;dec eax; eax = m - 1
    ;mov dword[m_1], eax
    
.loop2:
    cmp ecx, dword[m]
    ja .q2; i > m - 1
    
    mov eax, ecx;eax = i
    mov ebx, eax
    sub ebx, dword[k]
    inc ebx; ebx = n - k + 1
.i_fac:
    cmp eax, ebx
    jle .end_i_fac
    mul eax - 1
    dec eax
    jmp .i_fac
.end_i_fac:
    mov esi, eax; esi = n*...*(n-k+1)
    ;k!
    mov eax, dword[k]
.k_fac:
    cmp eax, 1
    jle .end_k_fac

    mul eax - 1
    dec eax
    jmp .k_fac
    
            
.end_k_fac:
    mov edi, eax; edi = k!
    mov eax, esi
    xor edx, edx
    div edi
    add dword[res], eax
    

.q2:

    
    
    
    xor eax, eax
    ret
