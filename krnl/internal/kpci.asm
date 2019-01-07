; KERNEL POWER CONTROL INTERFACE

; The shutdown routine
; If this guy is executed, unless there is
; an error while shutting down, there is no
; going back.
system_powerdown:
    mov ah, 0x01
    mov cx, 0x2007
    int 0x10

    call print_endl
    mov si, str_ok
    call teleprint

    call print_endl
    mov si, str_stage_1
    call teleprint
    ; Request global power off
    mov ah, 0x42
    mov al, 0x00
    int 0x15

    call print_endl
    mov si, str_stage_2
    call teleprint

    mov al, ']'
    mov ah, 0x09
    mov cx, 0x01
    xor bh, bh
    mov bl, 0x02
    int 0x10
    ; Wait some time
    ; (with a cool animation ;)
    mov cx, 0x05
wait_loop:
    mov ah, 0x86
    xor dx, dx
    int 0x15
    mov si, str_dot
    call teleprint
    push cx
    mov al, ']'
    mov ah, 0x09
    mov cx, 0x01
    xor bh, bh
    mov bl, 0x02
    int 0x10
    pop cx
    loop wait_loop

    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    ; Halt CPU
    call print_endl
    mov si, str_stage_3
    call teleprint
    mov ah, 0x53
    xor bx, bx
    int 0x15

    ; Power off
    mov ax, 0x530e
    xor bx, bx
    mov cx, 0x0102
    int 0x15

    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15

system_powerdown_halt:
    call print_endl
    mov si, str_error_s
    call teleprint
    call print_endl
    mov si, str_error_d
    call teleprint
    mov cx, 0x03

    jmp system_halt

system_reboot:
    ; Use BIOS to reboot the computer
    ; ax must be zero
    xor ax, ax
    ; i am too lazy to manually configure ACPI, so
    ; let the bios do that for us
    int 0x19
    ; in case reboot fails, it will continue down to the
    ; halt loop.

; Halt system forever...
system_halt:
    nop
halt_loop:
    cli
    hlt
    jmp halt_loop
