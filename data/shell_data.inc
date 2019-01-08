; Shell data
str_welcome:            db "Unreal OS shell. Welcome! Type 'help' for a list of commands.", 0
str_shell_cmd_pref:     db "# ", 0
str_shell_dir:          db "/", 0
str_root_char:          db "~", 0
str_thing_char:         db "'", 0
str_bad_command:        db " is not a recognized command or operation.", 0


str_bad_large:          db "Command must be less than 64 characters long.", 0

cursor_right:           db 0x00
command_buffer:         times 0x200 db 0x00
                        nop
                        db 0xff
scnd_buffer:	        times 0x200 db 0x00
                        nop
                        db 0xff
                        db 0xff
                        db 0xff



