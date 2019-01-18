log_command:
    call clear_scnd_buffer

    mov si, command_buffer
    mov di, scnd_buffer
    call get_arg

    mov si, scnd_buffer
    call krnl_log

    jmp shell_master
