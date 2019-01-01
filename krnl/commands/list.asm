
list_files:
    mov ax, file_cache
    call get_file_list

    jmp shell_master

file_cache:         times 0x800 db 0x00
