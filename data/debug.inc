; the debug registers command data
str_dbg_title:      db "Welcome to the debug command! Type debug -h for a more detailed explanation about what it does...", 0x00
str_dbg_registers:  db "Current registers state: ", 0x00
                    ; A bit of padding for easier dissasembling
                    nop
                    dw 0xffff

                    ; Strings
str_dbg_ah:         db " ah: ", 0x00
str_dbg_ch:         db " ch: ", 0x00
str_dbg_dh:         db " dh: ", 0x00
str_dbg_bh:         db " bh: ", 0x00

str_dbg_al:         db " al: ", 0x00
str_dbg_cl:         db " cl: ", 0x00
str_dbg_dl:         db " dl: ", 0x00
str_dbg_bl:         db " bl: ", 0x00

str_dbg_ax:         db " ax: ", 0x00
str_dbg_cx:         db " cx: ", 0x00
str_dbg_dx:         db " dx: ", 0x00
str_dbg_bx:         db " bx: ", 0x00

str_dbg_sp:         db " sp: ", 0x00
str_dbg_bp:         db " bp: ", 0x00
str_dbg_si:         db " si: ", 0x00
str_dbg_di:         db " di: ", 0x00

str_dbg_cs:         db " cs: ", 0x00
str_dbg_ds:         db " ds: ", 0x00
str_dbg_es:         db " es: ", 0x00
str_dbg_fs:         db " fs: ", 0x00
str_dbg_gs:         db " gs: ", 0x00
str_dbg_ss:         db " ss: ", 0x00

str_dbg_eax:        db " eax: ", 0x00
str_dbg_ecx:        db " ecx: ", 0x00
str_dbg_edx:        db " edx: ", 0x00
str_dbg_ebx:        db " ebx: ", 0x00

str_dbg_esp:        db " esp: ", 0x00
str_dbg_ebp:        db " ebp: ", 0x00
str_dbg_esi:        db " esi: ", 0x00
str_dbg_edi:        db " edi: ", 0x00

                    ; A bit of padding for easier dissasembling
                    nop
                    dw 0xffff

                    ; The actual storage
dbg_dat_ah:         db 0x00
dbg_dat_ch:         db 0x00
dbg_dat_dh:         db 0x00
dbg_dat_bh:         db 0x00

dbg_dat_al:         db 0x00
dbg_dat_cl:         db 0x00
dbg_dat_dl:         db 0x00
dbg_dat_bl:         db 0x00

dbg_dat_ax:         dw 0x0000
dbg_dat_cx:         dw 0x0000
dbg_dat_dx:         dw 0x0000
dbg_dat_bx:         dw 0x0000

dbg_dat_sp:         dw 0x0000
dbg_dat_bp:         dw 0x0000
dbg_dat_si:         dw 0x0000
dbg_dat_di:         dw 0x0000

dbg_dat_cs:         dw 0x0000
dbg_dat_ds:         dw 0x0000
dbg_dat_es:         dw 0x0000
dbg_dat_fs:         dw 0x0000
dbg_dat_gs:         dw 0x0000
dbg_dat_ss:         dw 0x0000

dbg_dat_eax:        dd 0x00000000
dbg_dat_ecx:        dd 0x00000000
dbg_dat_edx:        dd 0x00000000
dbg_dat_ebx:        dd 0x00000000

dbg_dat_esp:        dd 0x00000000
dbg_dat_ebp:        dd 0x00000000
dbg_dat_esi:        dd 0x00000000
dbg_dat_edi:        dd 0x00000000
