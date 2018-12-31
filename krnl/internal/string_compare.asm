compare_strings:
    pusha

compare_loop:
    mov al, [si]
	mov bl, [di]

    cmp al, bl
    jne compare_not_same

    or al, al
    jz compare_same

    add si, 0x01
    add di, 0x01

    jmp compare_loop

compare_not_same:
    popa
    clc
    retn

compare_same:
    popa
    stc
    retn
