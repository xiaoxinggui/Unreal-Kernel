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

; Far jump to protected mode
jmp 0x08:protected_mode

; Now in protected mode
protected_mode:

; Set all registers to a value (in this case 0x10, but it shouldn't really matter)
mov ax, 0x10
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax

; Exit protected mode.
mov eax, cr0
and eax, 11111110b
mov cr0, eax

; Now in unreal mode
; We exited protected mode, so we are on real mode
; but remember that we didn't unload the gdt
; noice :ok_hand:
jmp 0x0000:unreal_mode

unreal_mode:
; Now flush all registers
xor ax, ax
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax

; And set all the segments to were we loaded
mov ax, 0x1000
mov ss, ax
mov sp, 0xfff0

; Now we are officially in unreal mode, so we can reenable interrupts and continue in the main file
sti
