key_back:
    ; Backspace
    cmp byte[cursor_right], 0x00
    jle command

    mov ah, 0x0e
    mov al, 0x08
    int 0x10
    mov al, 0x00
    int 0x10
    mov al, 0x08
    int 0x10

    sub byte[cursor_right], 0x01

    movzx eax, byte[cursor_right]
    mov byte[command_buffer + eax], 0x00

    jmp command
