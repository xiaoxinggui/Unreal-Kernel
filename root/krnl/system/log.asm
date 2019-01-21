krnl_log:
    ; SUBROUTINE
    ;   si = pointer to null terminated
    ;        string to print
    ;   returns nothing

    pusha
    mov word[si_buffer], si

    mov si, char_1
    xor bl, bl
    call teleprint

    ; Print current time
    rdtsc

    mov dword[temp_dword_buffer_1], edx
    mov dword[temp_dword_buffer_2], eax

    ; First time part
    mov edx, dword[temp_dword_buffer_1]
    mov al, 0x02
    call print_hex

    ; Divider
    mov si, char_3
    xor bl, bl
    call teleprint

    ; Second time part
    mov edx, dword[temp_dword_buffer_2]
    mov al, 0x02
    call print_hex

    mov si, char_2
    xor bl, bl
    call teleprint

    mov si, word[si_buffer]
    xor bl, bl
    call teleprint

    call print_endl

    popa
    retn
