reboot:
    ; This method of rebooting is kinda ugly, but it was the most efficient and compatible way i found to do it.
    ; We cause the CPU to triple fault, so it does reboot itself.
    jmp 0xffff:0x00
    ; If it is still running, jump to the halt loop
    jmp halt
