krnl_log:
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
    call print_hex

    ; Divider
    mov si, char_3
    xor bl, bl
    call teleprint

    ; Second time part
    mov edx, dword[temp_dword_buffer_2]
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

char_1:             db "[ ", 0x00
char_2:             db " ] ", 0x00
char_3:             db ":", 0x00
temp_dword_buffer_1:dd 0x00000000
temp_dword_buffer_2:dd 0x00000000
temp_word_buffer:   dw 0x0000
si_buffer:          dw 0x0000
