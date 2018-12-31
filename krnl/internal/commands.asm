cmd_shutdown:       db "shutdown", 0
cmd_help:           db "help", 0
cmd_reboot:         db "reboot", 0
cmd_clear:          db "clear", 0
cmd_list:           db "ls", 0

list_files:
    mov ax, file_cache
    call get_file_list

    jmp shell_master

file_cache:         times 0x800 db 0x00

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
    call print_endl
    call print_endl
    mov si, str_help_8
    call teleprint
    call print_endl

    jmp shell_master

str_help_1:           db "Unreal OS, list of internal commands.", 0
str_help_2:           db "clear              - clear the screen.", 0
str_help_3:           db "help               - show this page.", 0
str_help_4:           db "shutdown           - shutdown the computer.", 0
str_help_5:           db "reboot             - reset the computer.", 0
str_help_6:           db "ls                 - lists files in the current dir.", 0
str_help_7:           db "cd                 - change directory.", 0
str_help_8:           db "Type any filename starting with './' to execute it.", 0


shutdown_main:
    call print_endl
    mov si, str_ok
    call teleprint

    mov     ah, 0x5301
    xor     bx, bx
    int     0x15

    mov     ax, 0x530e
    xor     bx, bx
    mov     cx, 0x0102
    int     0x15

    mov     ax, 0x5307
    mov     bx, 0x0001
    mov     cx, 0x0003
    int     0x15

halt:
    hlt
    jmp halt

str_ok:     db "Shutting down computer...", 0

reboot:
    jmp 0xffff:0x00
    jmp halt
