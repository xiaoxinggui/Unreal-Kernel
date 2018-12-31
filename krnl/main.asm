use16

flush:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    and edx, 0x000000ff
    xor esi, esi
    xor edi, edi
    xor ebp, ebp

setup:
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

    xor ah, ah	    ; ah must be zero for video mode
    xor bx, bx
    mov ax, 0x1003  ; text mode with some attributes
	int 0x10

    mov ah, 0x02
    xor bh, bh
    xor dh, dh
    xor dl, dl
    int 0x10

    mov ah, 0x09
    mov al, 0x00
    mov bl, 0x02
    mov cx, 0xfff
    xor bh, bh
    int 0x10

start:
    mov cx, 0x03
print_endlines_start:
    call print_endl
    loop print_endlines_start

    mov si, str_alive
    call teleprint
    call print_endl

    call shell_main

    jmp $

; Data
str_alive:              db "Unreal OS shell. Welcome! Type 'help' for a list of commands.", 0
str_shell_cmd_pref:     db "# ", 0
str_shell_dir:          db "/", 0
str_root_char:          db "~", 0
str_thing_char:         db "'", 0
str_bad_command:        db " is not a recognized command or operation.", 0

; Special includes
%include "krnl/shell.asm"

; Internal kernel includes
%include "krnl/internal/endl.asm"
%include "krnl/internal/print.asm"
%include "krnl/internal/string_compare.asm"
%include "krnl/internal/commands.asm"
%include "krnl/internal/disk.asm"

; Align to sectors
times 0x8000 - ($ - $$) db 0x00
