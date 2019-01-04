promp:
    ; SUBROUTINE
    ; al = default value
    ;    0x00 = yes
    ;    != 0x00 = no
    ; si = promp string pointer
    ; returns
    ; al = result

    pusha

    mov byte[promp_current_selection], al

    call print_endl
    call teleprint

    or al, al
    jz start_y
    jmp start_n

promp_wait_key:
    xor ah, ah
    int 0x16

    cmp al, 'y'
    je promp_key_y
    cmp al, 'Y'
    je promp_key_y
    cmp al, 'n'
    je promp_key_n
    cmp al, 'N'
    je promp_key_n
    cmp al, 0x0d
    je promp_key_enter

    jmp promp_wait_key

promp_key_y:
    mov byte[promp_current_selection], 0x00

    mov ah, 0x09
    mov bl, 0x20
    mov cx, 0x01
    mov al, 'y'
    int 0x10

    jmp promp_wait_key

promp_key_n:
    mov byte[promp_current_selection], 0xff

    mov ah, 0x09
    mov bl, 0x20
    mov cx, 0x01
    mov al, 'n'
    int 0x10

    jmp promp_wait_key

promp_key_enter:
    mov al, byte[promp_current_selection]
    call print_endl

    popa
    retn

start_y:
    mov si, str_p_y
    call teleprint
    mov si, str_promp
    call teleprint

    jmp promp_key_y

start_n:
    mov si, str_p_n
    call teleprint
    mov si, str_promp
    call teleprint

    jmp promp_key_n
