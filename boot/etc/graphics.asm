teleprint:
    ; SUBTOURINE
    ; Teleprint
    ;   si = address of the string to print
    ; reutrns nothing
    
start_teleprint:
    pusha
teleprint_loop:
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

print_endl: 
    ; SUBROUTINE
    ; Print endline
    ; Returns nothing and takes nothing as argment

    pusha

    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10

    popa
    retn

