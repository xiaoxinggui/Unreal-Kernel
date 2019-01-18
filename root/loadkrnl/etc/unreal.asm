; WARNING:
; Most code here is not mine, but from https://github.com/Druaga1/DankOS/
; Huge credit to the echidna development team (now, the people who *worked* on dank os)

; First of all, disable interrupts, just so default interrupts
; set by BIOS don't interfer while loading unreal.
cli

; Load the global desctriptor table
; then we will unload pm, without unloading this guy,
; so we'll be in "unreal" mode.
lgdt [global_descriptor_table]

; Enter protected mode
mov eax, cr0
or eax, 00000001b
mov cr0, eax

; Now in protected mode
protected_mode:

; Exit protected mode.
mov eax, cr0
and eax, 11111110b
mov cr0, eax

; Now in unreal mode
; We exited protected mode, so we are on real mode
; but remember that we didn't unload the gdt
; that means we are, in fact, in unreal mode
unreal_mode:

; And set all the segments to were we loaded
mov ax, 0x1000
mov ss, ax
mov sp, 0xfff0

; Now we are officially in unreal mode, so we can reenable interrupts and continue in the main file
sti
