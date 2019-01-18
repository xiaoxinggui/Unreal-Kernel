; ----------------
no_command:
    pusha

    mov si, str_thing_char
    call teleprint
    mov si, scnd_buffer
    call teleprint
    mov si, str_thing_char
    call teleprint
    mov si, str_bad_command
    call teleprint

    popa
    retn


