; We'll work in 16 bits, unreal mode
use16
org 0x0000

jmp 0x0000:krnl_main
nop

db "UNREAL KERNEL   "
db "v0.01           "

; Headers
%include "headers/unreal.inc"

krnl_main:

; Setup kernel and registries
%include "krnl/system/flush.asm"
%include "krnl/system/setup.asm"

; Everything should be already setup, so we
; only have to start doing things
start:
    call print_endl

    mov si, str_alive
    call teleprint
    call print_endl

    call shell_main

halt_cpu:
    hlt
    jmp halt_cpu

; Code goes here
; System Shell
%include "krnl/shell/shell.asm"
%include "krnl/shell/master.asm"
%include "krnl/shell/command.asm"
%include "krnl/shell/buffers/first.asm"
%include "krnl/shell/buffers/second.asm"
%include "krnl/shell/errors/long.asm"
%include "krnl/shell/errors/no_command.asm"
%include "krnl/shell/keys/enter.asm"
%include "krnl/shell/keys/backspace.asm"

; Include internal shell commands
%include "krnl/commands/clear.asm"
%include "krnl/commands/help.asm"
%include "krnl/commands/list.asm"
%include "krnl/commands/print.asm"
%include "krnl/commands/reboot.asm"
%include "krnl/commands/shutdown.asm"

; Internal kernel includes
%include "krnl/internal/endl.asm"
%include "krnl/internal/print.asm"
%include "krnl/internal/string_compare.asm"
%include "krnl/internal/disk.asm"
%include "krnl/internal/get_arg.asm"
%include "krnl/internal/last_arg.asm"
%include "krnl/internal/kpci.asm"
%include "krnl/internal/promp.asm"

; Data
%include "data/kpci_data.inc"
%include "data/shell_data.inc"
%include "data/commands.inc"
%include "data/help_text.inc"
%include "data/promp.inc"

; idk
nop
