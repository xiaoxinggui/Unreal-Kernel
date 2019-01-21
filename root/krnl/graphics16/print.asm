; This are the printing routines for my os to work and output stuff.

teleprint:
    ; SUBTOURINE
    ; Teleprint
    ;   si = address of the string to print
    ; returns nothing
    mov byte[last_color], bl

    or bl, bl
    jnz start_teleprint

    mov byte[last_color], 0x07
start_teleprint:
    pusha
teleprint_loop:
    ; Color
    mov ah, 0x09
    mov al, 0x00
    mov bl, byte[last_color]
    mov cx, 0x01
    xor bh, bh
    int 0x10
    ; Custom lodsb. It takes more space, but it does the same job
    ; and i feel more confortable using this than lodsb.
    ; idk, i just like it
    mov al, byte[si]
    add si, 0x01
    ; Check if we are at the end of the string
    or al, al
    jz teleprint_done
    ; Else, print the char itself
    mov ah, 0x0e
    int 0x10
    ; Loop
    jmp teleprint_loop
teleprint_done:
    popa
    retn

last_color:     db 0x00
