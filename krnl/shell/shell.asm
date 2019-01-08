use16

shell_main:
    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    jmp shell_master
