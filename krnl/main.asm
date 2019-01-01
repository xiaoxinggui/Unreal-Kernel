use16

%include "krnl/system/flush.asm"
%include "krnl/system/setup.asm"

start:
    call print_endl

    mov si, str_alive
    call teleprint
    call print_endl

    call shell_main

    jmp $

; Data
str_alive:              db "Unreal OS shell. Welcome! Type 'help' for a list of commands.", 0
str_shell_cmd_pref:     db "# ", 0
str_shell_dir:          db "/", 0
str_root_char:          db "~", 0
str_thing_char:         db "'", 0
str_bad_command:        db " is not a recognized command or operation.", 0

; System(important internal) includes
%include "krnl/system/shell.asm"

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
%include "krnl/internal/commands.asm"
%include "krnl/internal/disk.asm"
%include "krnl/internal/get_arg.asm"
%include "krnl/internal/last_arg.asm"
