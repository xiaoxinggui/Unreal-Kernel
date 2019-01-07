; KERNEL POWER CONTROL INTERFACE

; The shutdown routine
; If this guy is executed, unless there is
; an error while shutting down, there is no
; going back.
system_powerdown:
    ; No need to comment this first
    ; label of the subroutine, as it is mostly
    ; grahpical support for the shutdown
    ; (this way it is less boring for the user)

inform_user_shutdown_request_send:
    ; Hide cursor
    mov ah, 0x01
    mov cx, 0x2007
    int 0x10

    ; Ugly formatted printing
    call print_endl
    mov si, str_ok
    call teleprint
    call print_endl
    mov si, str_stage_1
    call teleprint

request_bios_poweroff:
    ; Request global power off
    ; to the BIOS
    mov ah, 0x42
    mov al, 0x00
    int 0x15

shutdown_animation_wait_loop:
    ; And give it some time
    ; with a cool animation
    call print_endl
    mov si, str_stage_2
    call teleprint

    ; Some cool animation
    mov al, ']'
    mov ah, 0x09
    mov cx, 0x01
    xor bh, bh
    mov bl, 0x02
    int 0x10
    ; Wait some time
    ; (with a cool animation ;)
    mov cx, 0x05
shutdown_wait_loop:
    ; Again graphical
    ; "progress bar"
    ; as we wait for the bios, in case
    ; something went wrong
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
    loop shutdown_wait_loop

    ; Restore cursor
    mov ah, 0x01
    mov cx, 0x0007
    int 0x10

    ; Print final things
    call print_endl
    mov si, str_stage_3
    call teleprint

    ; GRAHICAL SHUTDOWN ENDS HERE. STARTING ACTUAL SHUTDOWN ROUTINE
power_off_computer_via_bios:
    ; We won't need to print anything again,
    ; so disable interrupts
    cli

    mov ah, 0x53
    xor bx, bx
    int 0x15

    ; Power off
    ; let the bios do the hard work for us,
    ; as we aren't in unreal mode for any reason...
    mov ax, 0x530e
    xor bx, bx
    mov cx, 0x0102
    int 0x15

    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15

system_powerdown_halt:
    ; Ok, it failed...
    ; Reenable interrupts to let the use know
    ; that the shutdown failed (we need interrupts
    ; to print stuff)
    sti

    ; The actual ugly formatted prints
    call print_endl
    mov si, str_error_s
    call teleprint
    call print_endl
    mov si, str_error_d
    call teleprint

    ; Halt the computer forever
    ; until use manually hard-powers-off the computer.
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
    ; Halt until next interrupt
    ; having interrupts disabled...
    ; this sounds to me like an
    ; infinite loop......
    cli
    hlt
    ; If for any weird reason, we get here(we shouldn't
    ; because interrupts are disabled and they can't
    ; call to continue execution), whatever,
    ; if we get here for any reason,
    ; loop back again
    jmp halt_loop
