; Set all segments to were we loaded
cli
mov ax, 0xffff
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
mov sp, 0x7ff0
push ds
xor ax, ax
mov ds, ax
pop ds
sti

; Init graphics
xor ah, ah	    ; ah must be zero for video mode
xor bx, bx
mov ax, 0x1003  ; text mode with some attributes
int 0x10

; Clear screen
mov ah, 0x02
xor bh, bh
xor dh, dh
xor dl, dl
int 0x10

mov ah, 0x09
mov al, 0x00
mov bl, 0x02
mov cx, 0xffff
xor bh, bh
int 0x10
