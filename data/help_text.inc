; Help command strings
help_text:          db "Unreal OS, list of internal commands.", 0x0a, 0x0d
                    db 0x0a, 0x0d
                    db "clear              - clear the screen.", 0x0a, 0x0d
                    db "help               - show this page.", 0x0a, 0x0d
                    db "print <txt>        - log a text as the user.", 0x0a, 0x0d
                    db "log <txt>          - log a text as the kernel.", 0x0a, 0x0d
                    db "debug              - show the current state of ALL cpu registries.", 0x0a, 0x0d
                    db "shutdown           - shutdown the computer.", 0x0a, 0x0d
                    db "reboot             - reset the computer.", 0x0a, 0x0d
                    db "ls                 - lists files in the current dir.", 0x0a, 0x0d
                    db "cd <subdir>        - change directory.", 0x0a, 0x0d
                    db 0x0a, 0x0d
                    db "Type any filename starting with './' to execute it.", 0x0a, 0x0d
                    db 0x00
