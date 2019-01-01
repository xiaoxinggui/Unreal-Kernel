
; ----------------------
bad_too_large:
    pusha
    call print_endl
    mov si, str_bad_large
    call teleprint
    call print_endl
    mov si, command_buffer
    call teleprint
    jmp command
    popa
    retn
