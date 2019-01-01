get_arg:
    ; SUBROUTINE
    ; si = buffer where to get arg from
    ; di = buffer where to store arg to
    pusha
    mov byte[allowed_to_start], 0x00

arg_loop:
    ; Load the char itself
    mov al, byte [si]
    add si, 0x01

    ; Maybe it is a zero
    cmp al, 0x00
    je arg_zero

    ; Else, we have a char
    ; If we're allowed to buffer
    cmp byte[allowed_to_start], 0x01
    je arg_set_buffer

    ; Else
    ; Maybe it is a space
    cmp al, 0x20
    je arg_space

    ; Loop
    jmp arg_loop

arg_zero:
    ; If it is a zero, it has to end
    jmp arg_done

arg_space:
    ; If it is a space, and we 
    mov byte[allowed_to_start], 0x01
    jmp arg_loop

arg_set_buffer:
    mov byte[di], al
    add di, 0x01
    jmp arg_loop

arg_done:
    popa
    retn

allowed_to_start:   db 0x00
