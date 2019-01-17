
; Wait for the a20 controller to be ready for a command...
a20_wait:
    pusha
a20_wait_loop:
    in al, 0x64
    test al, 0x02
    jnz a20_wait_loop

    popa
    retn
