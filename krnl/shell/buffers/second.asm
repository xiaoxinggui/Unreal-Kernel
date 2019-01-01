
; ----------------------
clear_scnd_buffer:
    pusha
    mov eax, scnd_buffer
    mov cx, 0x200
clear_scnd_loop:
    add eax, 0x01
    mov byte[eax], 0x00
    loop clear_scnd_loop
    popa
    retn
