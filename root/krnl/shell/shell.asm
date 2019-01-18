use16

shell_main:
    call print_endl

    mov si, str_welcome
    mov bl, 0x17
    call teleprint
    xor bl, bl
    call print_endl

    jmp shell_master
