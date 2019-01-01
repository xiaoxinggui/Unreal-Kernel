clear_screen:
    mov ah, 0x02
    xor bh, bh
    xor dh, dh
    xor dl, dl
    int 0x10

    mov ah, 0x09
    mov bl, 0x02
    mov cx, 0xffff
    int 0x10

    jmp shell_master
    