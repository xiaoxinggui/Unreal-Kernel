use16

shell_main:
    mov ah, 0x09
    mov al, 0x00
    mov bl, 0x02
    mov cx, 0xfff
    xor bh, bh
    int 0x10

    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    mov ax, 0x1003
	mov bl, 0x00
	xor bh, bh
	int 0x10

    jmp shell_master
