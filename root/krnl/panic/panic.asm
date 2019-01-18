panic:
    ; Save CPU state
    mov byte[dbg_dat_ah], ah
    mov byte[dbg_dat_ch], ch
    mov byte[dbg_dat_dh], dh
    mov byte[dbg_dat_bh], bh

    mov byte[dbg_dat_al], al
    mov byte[dbg_dat_cl], cl
    mov byte[dbg_dat_dl], dl
    mov byte[dbg_dat_bl], bl

    mov word[dbg_dat_ax], ax
    mov word[dbg_dat_cx], cx
    mov word[dbg_dat_dx], dx
    mov word[dbg_dat_bx], bx

    mov word[dbg_dat_sp], ax
    mov word[dbg_dat_bp], cx
    mov word[dbg_dat_si], dx
    mov word[dbg_dat_di], bx

    mov word[dbg_dat_cs], cs
    mov word[dbg_dat_ds], ds
    mov word[dbg_dat_es], es
    mov word[dbg_dat_fs], fs
    mov word[dbg_dat_gs], gs
    mov word[dbg_dat_ss], ss

    mov dword[dbg_dat_eax], eax
    mov dword[dbg_dat_ecx], ecx
    mov dword[dbg_dat_edx], edx
    mov dword[dbg_dat_ebx], ebx

    mov dword[dbg_dat_esp], esp
    mov dword[dbg_dat_ebp], ebp
    mov dword[dbg_dat_esi], esi
    mov dword[dbg_dat_edi], edi

    ; Save error code
    pop ax
    mov word[panic_error_code], ax

    ; Flush everything
    cli
    xor ax, ax
    xor cx, cx
    xor dx, dx
    xor bx, bx
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    xor ebx, ebx
    sti

    ; Graphical UI
    mov ah, 0x02
    int 0x10

    mov ah, 0x09
    mov bl, 0x17
    mov cx, 0xffff
    int 0x10

    mov si, str_panic_fatal
    mov bl, 0x17
    call teleprint

    mov si, str_panic_error_code
    call teleprint
    mov ax, word[panic_error_code]
    movzx edx, ax
    call print_hex

    call print_endl

    xor bx, bx

    mov bl, 0x17
    mov si, str_dbg_ah
    call teleprint
    movzx edx, byte[dbg_dat_ah]
    call print_hex
    mov si, str_dbg_ch
    call teleprint
    movzx edx, byte[dbg_dat_ch]
    call print_hex
    mov si, str_dbg_dh
    call teleprint
    movzx edx, byte[dbg_dat_dh]
    call print_hex
    mov si, str_dbg_bh
    call teleprint
    movzx edx, byte[dbg_dat_bh]
    call print_hex

    mov si, str_dbg_al
    call teleprint
    movzx edx, byte[dbg_dat_al]
    call print_hex
    mov si, str_dbg_cl
    call teleprint
    movzx edx, byte[dbg_dat_cl]
    call print_hex
    mov si, str_dbg_dl
    call teleprint
    movzx edx, byte[dbg_dat_dl]
    call print_hex
    mov si, str_dbg_bl
    call teleprint
    movzx edx, byte[dbg_dat_bl]
    call print_hex

    mov si, str_dbg_ax
    call teleprint
    movzx edx, word[dbg_dat_ax]
    call print_hex
    mov si, str_dbg_cx
    call teleprint
    movzx edx, word[dbg_dat_cx]
    call print_hex
    mov si, str_dbg_dx
    call teleprint
    movzx edx, word[dbg_dat_dx]
    call print_hex
    mov si, str_dbg_bx
    call teleprint
    movzx edx, word[dbg_dat_bx]
    call print_hex

    mov si, str_dbg_sp
    call teleprint
    movzx edx, word[dbg_dat_sp]
    call print_hex
    mov si, str_dbg_bp
    call teleprint
    movzx edx, word[dbg_dat_bp]
    call print_hex
    mov si, str_dbg_si
    call teleprint
    movzx edx, word[dbg_dat_si]
    call print_hex
    mov si, str_dbg_di
    call teleprint
    movzx edx, word[dbg_dat_di]
    call print_hex

    mov si, str_dbg_cs
    call teleprint
    movzx edx, word[dbg_dat_cs]
    call print_hex
    mov si, str_dbg_ds
    call teleprint
    movzx edx, word[dbg_dat_ds]
    call print_hex
    mov si, str_dbg_es
    call teleprint
    movzx edx, word[dbg_dat_es]
    call print_hex
    mov si, str_dbg_fs
    call teleprint
    movzx edx, word[dbg_dat_fs]
    call print_hex
    mov si, str_dbg_gs
    call teleprint
    movzx edx, word[dbg_dat_gs]
    call print_hex
    mov si, str_dbg_ss
    call teleprint
    movzx edx, word[dbg_dat_ss]
    call print_hex

    mov si, str_dbg_eax
    call teleprint
    movzx edx, word[dbg_dat_eax]
    call print_hex
    mov si, str_dbg_ecx
    call teleprint
    movzx edx, word[dbg_dat_ecx]
    call print_hex
    mov si, str_dbg_edx
    call teleprint
    movzx edx, word[dbg_dat_edx]
    call print_hex
    mov si, str_dbg_ebx
    call teleprint
    movzx edx, word[dbg_dat_ebx]
    call print_hex

    mov si, str_dbg_esp
    call teleprint
    movzx edx, word[dbg_dat_esp]
    call print_hex
    mov si, str_dbg_ebp
    call teleprint
    movzx edx, word[dbg_dat_ebp]
    call print_hex
    mov si, str_dbg_esi
    call teleprint
    movzx edx, word[dbg_dat_esi]
    call print_hex
    mov si, str_dbg_edi
    call teleprint
    movzx edx, word[dbg_dat_edi]
    call print_hex

    call print_endl
    call print_endl

    mov si, str_dump_promp
    mov al, 0xff
    call promp
    
    cmp al, 0xff
    je start_panic_halt

panic_dump_yes:
    mov si, str_dump_ok
    call teleprint
    mov si, 0x0000
    mov cx, 0xffff
dump_current_segment:
    mov al, byte[si]
    add si, 0x01
    mov ah, 0x0e
    mov bl, 0x17
    push cx
    mov cx, 0x01
    int 0x10
    pop cx
    loop dump_current_segment

start_panic_halt:
    mov si, str_halt_panic
    mov bl, 0x17
    call teleprint
    cli
panic_halt_loop:
    hlt
    jmp panic_halt_loop
    
str_panic_fatal:            db "A fatal error occurred during the execution of the KERNEL,", 0x0a, 0x0d, "and it must be shutdown.", 0x0d, 0x0a, 0x0a, 0x00
str_dump_promp:             db "Dump all data in the current segment? ", 0x00
str_dump_ok:                db "Dumping current segment...", 0x00
str_halt_panic:             db "PANIC: Halting.", 0x00
str_panic_error_code:       db "Error code: ", 0x00
panic_error_code:           dw 0x0000
