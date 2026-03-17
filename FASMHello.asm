;Ограничение времени:	1 с
;Ограничение реального времени:	5 с
;Ограничение памяти:	64M
;Оставшиеся посылки:	24
;Задача 03-9: Прямоугольник
;В данной задаче вам необходимо проверить, лежит ли точка P внутри прямоугольника ABCD.

;На вход программе подаются 5 пар чисел: сначала координаты вершин прямоугольника, 
;а затем координаты точки P. 
;Все координаты целые и по модулю не превосходят 1000. 
;Вершины прямоугольника могут быть перечислены в произвольном порядке. 
;Гарантируется, что стороны прямоугольника параллельны осям координат.

;Программа должна вывести YES, если точка P лежит строго 
;внутри прямоугольника ABCD, и NO в противном случае.




extern io_get_dec, io_print_string

section .bss
    ;весде 1я координата - ось Ох, 2я - ось Оу
    array resd 10; array = [ax, ay, bx, by, ..., px, py]
    
section .data
    str_y: db 'YES', 0
    str_n: db 'NO', 0
    

section .text
global main
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    ;поиск минимума по x
    mov eax, dword[array]; x1 - минимум
    cmp eax, dword[array + 4*2]; x1 > x2?
    jg .update_x1; обновляем минимум 
    cmp eax, dword[array + 4*2]; x1 == x2?
    je .eq1
    mov edx, dword[array + 4*2]; x2 - максимум по х
.eq1:
    cmp eax, dword[array + 4*4]; x 1 > x3?
    jg .update_x2; обновляем минимум
    ; x1 < x3
    mov esi, eax; esi = x1
    mov edx, dword[array + 4*6]; edx = x4 
    jmp .end_find_x
    
.updata_x1:
    mov eax, dword[array + 4*2]; eax = x2
    mov edx, dword[array]; edx = x1 - максимум по x
    jmp .end_find_x

.update_x2:
    mov eax, dword[array + 4*4]; eax = x3
    jmp .end_find_x

.end_find_x:
    
    
    
    ;;;;;;;;;;;;;;;;;
    ;поиск минимума по y
    mov eax, dword[array]; x1 - минимум
    cmp eax, dword[array + 4*2]; x1 > x2?
    jg .update_x1; обновляем минимум 
    cmp eax, dword[array + 4*2]; x1 == x2?
    je .eq1
    mov edx, dword[array + 4*2]; x2 - максимум по х
.eq1:
    cmp eax, dword[array + 4*4]; x 1 > x3?
    jg .update_x2; обновляем минимум
    ; x1 < x3
    mov esi, eax; esi = x1
    mov edx, dword[array + 4*6]; edx = x4 
    jmp .end_find_x
    
.updata_x1:
    mov eax, dword[array + 4*2]; eax = x2
    mov edx, dword[array]; edx = x1 - максимум по x
    jmp .end_find_x

.update_x2:
    mov eax, dword[array + 4*4]; eax = x3
    jmp .end_find_x

.end_find_x:
    
    
    xor eax, eax
    ret
    
;1 2
;1 0
;3 2
;3 0
;2 3 - >NO

;1 2
;1 0
;3 2
;3 0
;2 1 - >YES

;1 2
;1 0
;3 2
;3 0
;2 0 -> NO
    
