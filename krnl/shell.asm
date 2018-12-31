use16

shell_main:
    mov ah, 0x09
    mov al, 0x00
    mov bl, 0x02
    mov cx, 0xfff
    xor bh, bh
    int 0x10

    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    mov ax, 0x1003
	mov bl, 0x00
	xor bh, bh
	int 0x10

    jmp shell_master

shell_master:
    ; Each time we hit enter
    call clear_buffer

    mov byte[cursor_right], 0x00
    call print_endl

    mov ah, 0x09
    mov al, 0x00
    mov bl, 0x02
    mov cx, 0xfff
    xor bh, bh
    int 0x10

    mov si, str_root_char
    call teleprint
    mov si, str_shell_cmd_pref
    call teleprint

    jmp command

command:
    ; Each time we hit a key
    mov ah, 0x00
    int 0x16

    cmp al, 0x0d
    je key_enter
    cmp al, 0x08
    je key_back

    mov ah, 0x0e
    int 0x10
    mov ch, byte[cursor_right]
    movzx edx, ch
    add edx, command_buffer
    mov byte[edx], al
    add byte[cursor_right], 0x01

    jmp command

key_enter:
    cmp byte [cursor_right], 0x00
    jle command

    ; Enter key ofc
    call print_endl

    ; Greenish green
    mov ah, 0x09
    mov al, 0x00
    mov bl, 0x02
    mov cx, 0xfff
    xor bh, bh
    int 0x10

    ; Mov our command to si
    mov si, command_buffer

    ; And... comapre it!

    ; First, easter eggs
    mov di, cmd_raphael
    call compare_strings
    jc near raphael_cmd

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

    ; If we got here, then the command is wrong
    mov si, str_thing_char
    call teleprint
    mov si, command_buffer
    call teleprint
    mov si, str_thing_char
    call teleprint
    mov si, str_bad_command
    call teleprint

    jmp shell_master

key_back:
    ; Backspace
    cmp byte[cursor_right], 0x00
    jle command

    mov ah, 0x0e
    mov al, 0x08
    int 0x10
    mov al, 0x00
    int 0x10
    mov al, 0x08
    int 0x10

    sub byte[cursor_right], 0x01

    movzx eax, byte[cursor_right]
    mov byte[command_buffer + eax], 0x00

    jmp command

clear_buffer:
    pusha
    mov cx, 0x200
clear_loop:
    mov eax, command_buffer
    add eax, 0x200
    movzx ecx, cx
    sub eax, ecx
    mov byte[eax], 0x00
    loop clear_loop
    popa
    retn

cursor_right:       db 0x00
command_buffer:     times 0x200 db 0x00

