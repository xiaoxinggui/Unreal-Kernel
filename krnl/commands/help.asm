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

; Help command strings
str_help_1:           db "Unreal OS, list of internal commands.", 0
str_help_2:           db "clear              - clear the screen.", 0
str_help_3:           db "help               - show this page.", 0
str_help_4:           db "print <txt>        - print the text specified as argument.", 0
str_help_5:           db "shutdown           - shutdown the computer.", 0
str_help_6:           db "reboot             - reset the computer.", 0
str_help_7:           db "ls                 - lists files in the current dir.", 0
str_help_8:           db "cd <subdir>        - change directory.", 0
str_help_9:           db "Type any filename starting with './' to execute it.", 0
