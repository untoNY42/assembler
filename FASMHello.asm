extern io_get_dec, io_print_dec

section .bss
    array resd 1000000
    tmp resd 3
    n resd 1


    
section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    call io_get_dec
    mov dword[n], eax
    xor esi, esi
    xor ebx, ebx; текущийиндес в tmp
    
    ;esi = i = 0
.loop:
    cmp esi, dword[n]
    jge .loop_end; если i >= n выходим
    call io_get_dec
    mov dword[array + esi*4], eax
    
    
    cmp esi, 3; заполняем tmp первыми тремя элементами
    jl .tmp_append
  

    .tmp_append:
        mov dword[tmp + esi*4], eax
        inc esi; ++i
        jmp .loop
    
    mov eax, dword[tmp + ebx*4]; eax = текущий минимальный
    cmp dword[array + esi*4], eax
    jg .replace
    .replace:
        ;обновили tmp и вошли в цикл
        mov eax, dword[array + esi*4]
        mov dword[tmp + ebx*4], eax
        inc esi; ++i
        jmp .loop
        
    
    
    inc esi; ++i
    jmp .loop
   
   
   
.find_min:
    mov eax, dword[tmp]
    cmp eax, dword[tmp + 4]; a | b
    ;eax = a
    jle .ac
    
    ;a > b
    mov eax, dword[tmp + 4]
    cmp eax, dword[tmp + 8]; b | c
    jle .init_b
    
    mov ebx, 2
    jmp .end
    .init_b:
        mov ebx, 1
        jmp .end
        
        
    .ac:
        cmp eax, dword[tmp + 8]
        jle .init_a
        .init_a:
            xor ebx, ebx
            jmp .end
    

    
    
    
            
        
    
.loop_end:  ;значения записаны в массив
    jmp .find_min
    
    
    .end:
        mov eax, dword[tmp + ebx*4]
        call io_print_dec
    
    
    xor eax, eax
    ret
