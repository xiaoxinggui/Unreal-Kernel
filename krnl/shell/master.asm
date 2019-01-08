
; ----------------------
shell_master:
    ; Each time we hit enter
    call clear_buffer

    mov byte[cursor_right], 0x00
    call print_endl

    mov si, str_root_char
    call teleprint
    mov si, str_shell_cmd_pref
    call teleprint

    jmp command

