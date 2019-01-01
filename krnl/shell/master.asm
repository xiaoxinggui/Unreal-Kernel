
; ----------------------
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

