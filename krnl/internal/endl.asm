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
