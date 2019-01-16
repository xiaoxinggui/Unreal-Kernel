; WARNING:
; Most code here is not mine, but from https://github.com/Druaga1/DankOS/
; Huge credit to the echidna development team (now, the people who *worked* on dank os)

; TODO: Comment this code properly

; Switch to a20
a20_check:
    push ax
    push bx
    push es
    push fs

    xor ax, ax
    mov es, ax
    not ax
    mov fs, ax

    mov ax, word [es:0x7dfe]
    cmp word [fs:0x7e0e], ax
    je .change_values

.enabled:
    clc
    jmp .done

.change_values:
    mov word [es:0x7dfe], 0x1234
    cmp word [fs:0x7e0e], 0x1234
    jne .enabled

    stc

.done:
    mov word [es:0x7dfe], ax
    pop fs
    pop es
    pop bx
    pop ax
    retn

enable_a20:
    push eax

    call a20_check
    jnc .done

    mov ax, 0x2401
    int 0x15

    call a20_check
    jnc .done

.keyboard_method:
    cli

    call .a20wait
    mov al, 0xad
    out 0x64, al

    call .a20wait
    mov al, 0xd0
    out 0x64, al

    call .a20wait2
    in al, 0x60
    push eax

    call .a20wait
    mov al, 0xd1
    out 0x64, al

    call .a20wait
    pop eax
    or al, 2
    out 0x60, al

    call .a20wait
    mov al, 0xae
    out 0x64, al

    call .a20wait
    sti

    jmp .keyboard_done

.a20wait:
    in al, 0x64
    test al, 2
    jnz .a20wait
    retn

.a20wait2:
    in al, 0x64
    test al, 1
    jz .a20wait2
    retn

.keyboard_done:
    call a20_check

.done:
    pop eax
    retn
