%include "io.inc"

section .data
    %include "input.inc"
    error_string db "Baza incorecta", 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp
    mov ecx, [nums]
elem_loop:
    mov ebx, [nums]
    sub ebx, ecx
    xor eax, eax
    mov eax, dword [nums_array + 4 * ebx]
    mov ebx, dword [base_array + 4 * ebx]
    cmp ebx, 1 ;baza nu poate fi mai mica decat 2
    je error
    cmp ebx, 16 ;baza nu poate fi mai mare decat 16
    jg error
divide:
    xor edx, edx
    div ebx
    push edx
    cmp eax, 0
    jg divide ;imparte catul din eax la baza pana devine 0
print:
    pop eax
    cmp eax, 10
    jge convert_af_to_ascii
    jl convert_numbers_to_ascii
convert_numbers_to_ascii:
    add eax, 48
    jmp print_char
convert_af_to_ascii:
    add eax, 87
print_char:
    PRINT_CHAR eax    
    cmp esp, ebp
    jl print
continue:
    cmp ecx, 1
    je skip_newline ;ultima linie din output nu trebuie sa fie goala
    NEWLINE
skip_newline:
    dec ecx
    jnz elem_loop
    jmp end
error:
    PRINT_STRING error_string
    jmp continue
end:
    xor eax, eax
    ret