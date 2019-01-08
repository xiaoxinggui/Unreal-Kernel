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

