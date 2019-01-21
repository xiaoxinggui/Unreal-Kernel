use16
org 0x0000

cli
xor ax, ax
mov ss, ax
mov sp, 0xffff
cld
mov ax, 0x2000
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
sti

mov word[prints_already], 0x00

xor ax, ax
xor bx, bx
xor dx, dx
mov ah, 0x02
int 0x10

xor ax, ax
xor bx, bx
mov ah, 0x09
mov al, 0x00
mov cx, 0xffff
mov bl, 0x07
int 0x10

mov si, str_alive
call print

commence_stage_two:
    mov si, str_stage2
    call print

    mov ax, 0x01
    mov bx, 0x7e00
    mov cx, 0x03
    call read_sectors

    jc error
    jmp stage2

error:
    mov si, str_error
    call print

halt:
    hlt
    jmp halt

; Includes
%include "loadkrnl/etc/disk.asm"
%include "loadkrnl/etc/graphics.asm"
%include "data/krnl_loader.inc"
%include "data/bpb.inc"

stage2:
    mov si, str_a20
    call print

    call enable_a20
    jc error

enter_unreal:
    mov si, str_unreal
    call print

%include "loadkrnl/etc/unreal.asm"

    mov si, str_lkrnl
    call print

    mov ax, 0x2000
    mov es, ax
    mov ax, 0x04
    xor bx, bx
    mov cx, 0x40

%include "loadkrnl/etc/loader.asm"
%include "loadkrnl/etc/gdt.asm"
%include "loadkrnl/etc/a20.asm"

nop
