command:
    ; Each time we hit a key
    mov ah, 0x00
    int 0x16

    ; If null
    cmp al, 0x00
    je command
    cmp al, 0xff
    je command
    ; If enter
    cmp al, 0x0d
    je key_enter
    ; If backspace
    cmp al, 0x08
    je key_back

    ; Else, we got here
    ; so print it

    ; If string not too large ofc
    cmp byte[cursor_right], 0x40
    jge bad_too_large

    mov ah, 0x0e
    int 0x10
    mov ch, byte[cursor_right]
    movzx edx, ch
    add edx, command_buffer
    mov byte[edx], al
    add byte[cursor_right], 0x01

    jmp command
