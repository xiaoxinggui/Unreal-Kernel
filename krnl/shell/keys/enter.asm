
key_enter:
    cmp byte [cursor_right], 0x00
    jle shell_master

    ; Enter key ofc
    call print_endl

    call clear_scnd_buffer

    ; Mov our command to si
    mov si, command_buffer
    mov di, scnd_buffer
    call last_arg

    mov si, scnd_buffer

    ; Then, actual commands.
    mov di, cmd_help
    call compare_strings
    jc near show_help_command

    mov di, cmd_reboot
    call compare_strings
    jc near reboot

    mov di, cmd_shutdown
    call compare_strings
    jc near shutdown_main

    mov di, cmd_clear
    call compare_strings
    jc near clear_screen

    mov di, cmd_list
    call compare_strings
    jc near list_files

    mov di, cmd_print
    call compare_strings
    jc near print_command_exec

    mov di, cmd_log
    call compare_strings
    jc near log_command

    ; If we got here, then the command is wrong
    call no_command

    jmp shell_master

db ":)"
