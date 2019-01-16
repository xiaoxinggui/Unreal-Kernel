read_sector:
    push ax
    push bx
    push cx
    push dx

    push dx

    xor dx, dx
    div word [bpbSectorsPerTrack]
    inc dl
    mov byte [.absolute_sector], dl
    xor dx, dx
    div word [bpbHeadsPerCylinder]
    mov byte [.absolute_head], dl
    mov byte [.absolute_track], al

    pop dx

    mov ah, 0x02
    mov al, 0x01
    mov ch, byte [.absolute_track]
    mov cl, byte [.absolute_sector]
    mov dh, byte [.absolute_head]

    clc

    int 0x13

.done:
    pop dx
    pop cx
    pop bx
    pop ax
    retn

.absolute_sector		db 0x00
.absolute_head			db 0x00
.absolute_track			db 0x00

read_sectors:
    push ax
    push bx
    push cx

.loop:
    call read_sector
    jc .done

    inc ax
    add bx, 0x200

    loop .loop

.done:
    pop cx
    pop bx
    pop ax
    retn
