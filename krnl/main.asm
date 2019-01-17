; We'll work in 16 bits, unreal mode
use16
org 0x0010

jmp krnl_main
nop

db "UNREAL KERNEL   "
db "v0.01           "

; Headers
%include "headers/asm/unreal.inc"

krnl_main:

; Setup kernel and registries
%include "krnl/system/flush.asm"
%include "krnl/system/setup.asm"

; Everything should be already setup, so we
; only have to start doing things
start:
    call print_endl
    call print_endl

    mov si, str_loaded
    call krnl_log

    call shell_main

halt_cpu:
    hlt
    jmp halt_cpu

; Code goes here
; System
%include "krnl/system/log.asm"
%include "krnl/system/flush.asm"        ; Reincluded
%include "krnl/system/setup.asm"        ; Reincluded

; Include internal shell commands
%include "krnl/commands/clear.asm"
%include "krnl/commands/help.asm"
%include "krnl/commands/list.asm"
%include "krnl/commands/print.asm"
%include "krnl/commands/reboot.asm"
%include "krnl/commands/shutdown.asm"
%include "krnl/commands/log.asm"
%include "krnl/commands/debug.asm"

; Drivers
%include "krnl/drivers/clock.asm"
%include "krnl/drivers/disk.asm"
%include "krnl/drivers/kpci.asm"

; 16 bit graphics
%include "krnl/graphics16/endl.asm"
%include "krnl/graphics16/print.asm"
%include "krnl/graphics16/print_hex.asm"
%include "krnl/graphics16/promp.asm"

; IO
%include "krnl/io/ports"

; String lib
%include "krnl/string/get_arg.asm"
%include "krnl/string/get_last_arg.asm"
%include "krnl/string/string_compare.asm"

; Data
%include "data/kpci_data.inc"
%include "data/shell_data.inc"
%include "data/commands.inc"
%include "data/help_text.inc"
%include "data/promp.inc"
%include "data/kernel_data.inc"
%include "data/log.inc"
%include "data/debug.inc"

; Shell
%include "krnl/shell/shell.asm"
%include "krnl/shell/master.asm"
%include "krnl/shell/command.asm"
%include "krnl/shell/buffers/first.asm"
%include "krnl/shell/buffers/second.asm"
%include "krnl/shell/errors/long.asm"
%include "krnl/shell/errors/no_command.asm"
%include "krnl/shell/keys/enter.asm"
%include "krnl/shell/keys/backspace.asm"

; idk
nop
