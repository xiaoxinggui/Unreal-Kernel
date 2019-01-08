show_help_command:
    xor di, di
    mov si, help_text
    call teleprint

    jmp shell_master
