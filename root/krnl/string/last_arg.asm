last_arg:
    ; SUBROUTINE
    ; si = string to get last arg of
    ; di = pointer to result
    pusha

last_arg_loop:
    ; Get si value
    mov al, byte[si]
    add si, 0x01

    ; If it is space or a zero end string
    cmp al, 0x20
    je last_arg_done
    cmp al, 0x00
    je last_arg_done

    ; Else, add string to buffer
    mov byte[di], al
    add di, 0x01

    ; Loop
    jmp last_arg_loop

last_arg_done:
    popa
    retn
