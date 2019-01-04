use16
org 0x7c00

; TODO: Comment all this file

jmp short bootsector_start
nop

; Make sure we are at the proper byte to start the BPB
times 0x03 - ($ - $$) db 0x00

; The BPB starts here
bpbOEM:				    	db "UNREALOS"
bpbBytesPerSector:			dw 0x200
bpbSectorsPerCluster:		db 0x01
bpbReservedSectors:			dw 0x44
bpbNumberOfFATs:			db 0x02
bpbRootEntries:				dw 0xe0
bpbTotalSectors:			dw 0xb40
bpbMedia:			    	db 0xf8
bpbSectorsPerFAT:			dw 0x09
bpbSectorsPerTrack:			dw 0x12
bpbHeadsPerCylinder:		dw 0x02
bpbHiddenSectors:			dd 0x00
bpbTotalSectorsBig:			dd 0x00
bsDriveNumber:				db 0x00
bsUnused:			    	db 0x00
bsExtBootSignature:			db 0x29
bsSerialNumber:				dd 0x12345678
bsVolumeLabel:				db "UNREAL OS  "
bsFileSystem:				db "FAT12   "

bootsector_start:
    cli
    jmp 0x0000:fix_cs
    fix_cs:
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ax, 0x1000
    mov ss, ax
    mov sp, 0xfff0
    sti

    mov si, str_bootsector
    call teleprint
    mov si, str_alive
    call teleprint
    call print_endl

commence_stage_two:
    mov si, str_bootsector
    call teleprint
    mov si, str_stage2
    call teleprint
    call print_endl

    mov ax, 0x01
    mov bx, 0x7e00
    mov cx, 0x03
    call read_sectors

    jc error
    jmp stage2

error:
    mov si, str_error
    call teleprint

halt:
    hlt
    jmp halt

; Includes
%include "boot/etc/disk.asm"
%include "boot/etc/graphics.asm"
%include "data/bootsector.inc"

; Padding and magic numbers
times 0x1fe - ($ - $$) db 0x00
magicnums:
push bp
stosb

stage2:
    mov si, str_bootsector
    call teleprint
    mov si, str_a20
    call teleprint
    call print_endl

    call enable_a20
    jc error

enter_unreal:
    mov si, str_bootsector
    call teleprint
    mov si, str_unreal
    call teleprint
    call print_endl

    %include "boot/etc/unreal.asm"

    mov si, str_bootsector
    call teleprint
    mov si, str_lkrnl
    call teleprint
    call print_endl

    mov ax, 0x2000
    mov es, ax
    mov ax, 0x04
    mov bx, 0x0000
    mov cx, 0x40

    call read_sectors
    jc error

    mov ax, es
    mov ds, ax
    xor ax, ax
    not ax
    mov es, ax

    xor si, si
    xor di, di

    xor cx, cx
    not cx

    rep movsb

    ; The far jump to the kernel
    jmp 0xffff:0x0010


%include "boot/etc/gdt.asm"
%include "boot/etc/a20.asm"

nop
; Alignement
times 0x800-($-$$) db 0x00
