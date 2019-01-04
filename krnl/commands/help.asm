show_help_command:
    xor di, di
    mov si, str_help_1
    call teleprint
    call print_endl
    call print_endl
    mov si, str_help_2
    call teleprint
    call print_endl
    mov si, str_help_3
    call teleprint
    call print_endl
    mov si, str_help_4
    call teleprint
    call print_endl
    mov si, str_help_5
    call teleprint
    call print_endl
    mov si, str_help_6
    call teleprint
    call print_endl
    mov si, str_help_7
    call teleprint
    call print_endl
    mov si, str_help_8
    call teleprint
    call print_endl
    call print_endl
    call print_endl
    mov si, str_help_9
    call teleprint
    call print_endl

    jmp shell_master
