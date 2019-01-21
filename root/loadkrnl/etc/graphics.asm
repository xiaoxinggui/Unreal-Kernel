
print:
    ; SUBTOURINE
    ; Teleprint
    ;   si = address of the string to print
    ; reutrns nothing
    pusha

    push si
    mov si, str_bootsector
    call teleprint
    mov si, str_bootsector_2
    call teleprint
    pop si
    
    call teleprint
    call print_endl

    ;add word[prints_already], 0x0064
    
    popa
    retn

teleprint:
    ; SUBTOURINE
    ; Teleprint
    ;   si = address of the string to print
    ; reutrns nothing
    
start_teleprint:
    pusha
teleprint_loop:
    ; Custom lodsb. It takes more space, but it does the same job
    ; and i feel more confortable using this than lodsb.
    ; idk, i just like it
    mov al, byte[si]
    add si, 0x01
    ; Check if we are at the end of the string
    or al, al
    jz teleprint_done
    ; Else, print the char itself
    add word[prints_already], 0x0002
    mov ah, 0x0e
    int 0x10
    ; Loop
    jmp teleprint_loop
teleprint_done:
    popa
    retn

print_endl: 
    ; SUBROUTINE
    ; Print endline
    ; Returns nothing and takes nothing as argment

    pusha

    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    popa
    retn

; TODO: Comment this little guy
print_hex:
    pusha

    mov eax, buffer_output
    mov cx, 0x08
clear_hex_out:
    mov byte[eax], 0x30
    add eax, 0x01
    
    loop clear_hex_out

    mov ecx, 0x08

char_loop:
    sub ecx, 0x01

    mov eax, edx
    shr edx, 0x04
    and eax, 0x0f

    mov ebx, buffer_output
    add ebx, ecx

    cmp ax, 0x0a
    jl set_letter
    add byte[ebx], 0x07

set_letter:
    add byte[ebx], al

    cmp ecx, 0x00
    je print_hex_done
    jmp char_loop

print_hex_done:
    mov esi, buffer_output
    xor bl, bl
    call teleprint

    popa
    retn

buffer_output:      db "00000000", 0x00
                    nop

