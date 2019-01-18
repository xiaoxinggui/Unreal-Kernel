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
