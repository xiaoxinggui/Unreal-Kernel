; Data
str_bootsector:             db "   [   KRNLLOAD.SYS ", 0x00
str_bootsector_2:           db " ] ", 0x00
str_alive:                  db "Alive signal.", 0x00
str_stage2:                 db "Commencing stage 2...", 0x00
str_a20:                    db "Enablig A20...", 0x00
str_unreal:                 db "Enabling unreal mode...", 0x00
str_lkrnl:                  db "Loading kernel...", 0x00
str_found:                  db "Kernel file found... loading it into memory now.", 0x00
str_error:                  db "ERROR: System halted.", 0x00
str_error_kernel_not_found: db "FATAL LOADER FAILIUER: ", 0x0a, 0x0d
                            times 0x15 db 0x20
                            db "Unable to find the KERNEL FILE. (KERNELOS.EXE)"
                            db 0x0d, 0x0a, 0x0a
                            db 0x00
                            nop

; Other stuff
prints_already:             dd 0x00000000
fat_entry:		        	dw 0x0000
fat_ptr:	        		dw 0x0000

bin_name:			        db "BIN        ", 0x00
kernel_filename:        	db "KERNELOSEXE", 0x00
empty_fat:		        	db "           ", 0x00

current_cluster:        	dw 0x0000
next_fat_loc:       		dw 0x0000

temp1:      				dw 0x0000

file_buffer:	        	times 0x1c00 db 0x00
