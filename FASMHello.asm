extern io_get_dec, io_print_dec

section .bss
    n resd 1
    k resd 1
    m resd 1
    tmp resd 1
    

section .data
    res dd 0

section .text
global main
main:
    mov ebp, esp
    call io_get_dec
    mov dword[n], eax
    call io_get_dec
    mov dword[k], eax
    
    ;Поиск позиции старшего бита (m) 
    xor ecx, ecx
.loop1:
    shr dword[n], 1
    cmp dword[n], 0
    je .find_m
    inc ecx
    jmp .loop1
    
.find_m:
    ;m = ecx (номер старшего бита)
    mov eax, ecx
    mov dword[m], eax
   
    ;Подготовка к вычислению числителя: i * (i-1) * ... * (i-k+1)
    ;где i = m - 1
    dec eax             ; eax = m - 1
    mov edi, dword[m]
    sub edi, dword[k]
    inc edi             ; edi = m - k + 1 (нижняя граница множителя)
    
    mov dword[tmp], eax ; tmp = i (текущий множитель)
    mov ebx, 1          ; ebx = 1 (аккумулятор результата)
    
.loop2:
    ; Сначала проверяем условие, потом умножаем
    cmp dword[tmp], edi
    jl .end_loop2       ; если tmp < edi, выходим
    
    mov eax, ebx        ; eax = текущий накопленный результат
    mul dword[tmp]      ; eax = eax * tmp (результат в EDX:EAX)
    mov ebx, eax        ; сохраняем младшую часть результата в ebx
    
    dec dword[tmp]      ; уменьшаем множитель
    jmp .loop2
    
.end_loop2:
    ; В ebx теперь находится числитель: i*(i-1)*...*(i-k+1) 
.q2:
    ; Здесь будет вычисление знаменателя k! и деление
    
    
    xor eax, eax
    ret
