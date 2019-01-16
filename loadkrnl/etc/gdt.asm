global_descriptor_table:
    dw gdt_end - gdt_start - 1	; GDT size
    dd gdt_start		        ; GDT start

gdt_start:

null_descr:
    dw 0x0000			; Limit
    dw 0x0000			; Base (low 16 bits)
    db 0x00			    ; Base (mid 8 bits)
    db 00000000b		; Access
    db 00000000b		; Granularity
    db 0x00			    ; Base (high 8 bits)

unreal_code:
    dw 0xffff			; Limit
    dw 0x0000			; Base (low 16 bits)
    db 0x00			    ; Base (mid 8 bits)
    db 10011010b		; Access
    db 10001111b		; Granularity
    db 0x00			    ; Base (high 8 bits)

unreal_data:
    dw 0xffff			; Limit
    dw 0x0000			; Base (low 16 bits)
    db 0x00			    ; Base (mid 8 bits)
    db 10010010b		; Access
    db 10001111b		; Granularity
    db 0x00			    ; Base (high 8 bits)

gdt_end:
