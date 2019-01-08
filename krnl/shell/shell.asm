use16

shell_main:
    call print_endl

    mov si, str_welcome
    mov bl, 0x17
    call teleprint
    xor bl, bl
    call print_endl

    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    jmp shell_master
