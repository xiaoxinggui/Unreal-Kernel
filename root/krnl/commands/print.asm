print_command_exec:
    call clear_scnd_buffer

    mov si, command_buffer
    mov di, scnd_buffer
    call get_arg

    mov si, scnd_buffer
    call teleprint

    call print_endl

    jmp shell_master
