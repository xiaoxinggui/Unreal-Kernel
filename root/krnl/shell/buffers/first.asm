; ----------------------
clear_buffer:
    pusha
    mov cx, 0x200
clear_loop:
    mov eax, command_buffer
    add eax, 0x200
    movzx ecx, cx
    sub eax, ecx
    mov byte[eax], 0x00
    loop clear_loop
    popa
    retn
