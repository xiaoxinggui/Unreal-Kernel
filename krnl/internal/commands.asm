cmd_shutdown:       db "shutdown", 0
cmd_help:           db "help", 0
cmd_reboot:         db "reboot", 0
cmd_clear:          db "clear", 0
cmd_list:           db "ls", 0
cmd_print:          db "print", 0

print_command_exec:
    call clear_scnd_buffer

    mov si, command_buffer
    mov di, scnd_buffer
    call get_arg

    mov si, scnd_buffer
    call teleprint

    call print_endl

    jmp shell_master

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


shutdown_main:
    mov ah, 0x01
    mov cx, 0x2007
    int 0x10

    call print_endl
    mov si, str_ok
    call teleprint

    call print_endl
    mov si, str_stage_1
    call teleprint
    ; Request global power off
    mov ah, 0x42
    mov al, 0x00
    int 0x15

    call print_endl
    mov si, str_stage_2
    call teleprint

    mov al, ']'
    mov ah, 0x09
    mov cx, 0x01
    xor bh, bh
    mov bl, 0x02
    int 0x10
    ; Wait some time
    ; (with a cool animation ;)
    mov cx, 0x05
wait_loop:
    mov ah, 0x86
    xor dx, dx
    int 0x15
    mov si, str_dot
    call teleprint
    push cx
    mov al, ']'
    mov ah, 0x09
    mov cx, 0x01
    xor bh, bh
    mov bl, 0x02
    int 0x10
    pop cx
    loop wait_loop

    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    ; Halt CPU
    call print_endl
    mov si, str_stage_3
    call teleprint
    mov ah, 0x53
    xor bx, bx
    int 0x15

    ; Power off
    mov ax, 0x530e
    xor bx, bx
    mov cx, 0x0102
    int 0x15

    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15

; Halt (hang forever in an infinite loop)
halt:
    call print_endl
    mov si, str_error_s
    call teleprint
    call print_endl
    mov si, str_error_d
    call teleprint
    mov cx, 0x03

endl_loop:
    call print_endl
    loop endl_loop

    cli
halt_loop:
    hlt
    jmp halt_loop

; Shutdown strings
str_ok:     db "Shutting down computer...", 0
str_stage_1:db "Requesting global power off...", 0
str_stage_2:db "Giving BIOS some time... [", 0
str_dot:    db "*", 0
str_stage_3:db "Halting CPU...", 0
str_error_s:db "CPU halted, but error powering off... must be shut down manually.", 0
str_error_d:db "Now it is safe to turn off your computer...", 0

reboot:
    ; This method of rebooting is kinda ugly, but it was the most efficient and compatible way i found to do it.
    ; We cause the CPU to triple fault, so it does reboot itself.
    jmp 0xffff:0x00
    ; If it is still running, jump to the halt loop
    jmp halt
