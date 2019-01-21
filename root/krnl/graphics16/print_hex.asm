; TODO: Comment this little guy
print_hex:
    ;   SUBROUTINE
    ;   edx = number to print
    ;   al = mode to print
    ;        0x00 = normal		(ex: [ 000e082a ])
    ;        0x01 = less zeros	(ex: [ e082a ])
    ;        0x02 = linux like	(ex: [    e082a])
    ;        0x03-0xff = error
    ; prints nothing

    pusha
    xor ah, ah
    push ax

    mov eax, buffer_output
    mov cx, 0x08
clear_hex_out:
    mov byte[eax], 0x30
    add eax, 0x01
    
    loop clear_hex_out

    mov ecx, 0x08

char_loop:
    sub ecx, 0x01

    mov eax, edx
    shr edx, 0x04
    and eax, 0x0f

    mov ebx, buffer_output
    add ebx, ecx

    cmp ax, 0x0a
    jl set_letter
    add byte[ebx], 0x07

set_letter:
    add byte[ebx], al

    cmp ecx, 0x00
    je print_hex_done
    jmp char_loop

print_hex_done:
    ; post process the thing
    pop ax
    mov si, buffer_output

    cmp al, 0x03
    jge print_hex_error

    cmp al, 0x01
    je print_hex_post_less

    cmp al, 0x02
    je print_hex_post_linux

print_hex_done_final:
    cmp byte[buffer_output + 7], 0x20
    je print_hex_set_last_zero_normal

    xor bx, bx
    call teleprint

    jmp print_hex_end

print_hex_set_last_zero_normal:
    mov byte[buffer_output + 7], '0'
    mov si, buffer_output + 6
    xor bx, bx
    call teleprint

    jmp print_hex_end

print_hex_post_less:
    mov si, buffer_output
print_hex_post_less_loop:
    mov al, byte[si]
    cmp al, '0'
    jne print_hex_done_final

    add si, 0x01
    jmp print_hex_post_less_loop

print_hex_post_linux:
    mov si, buffer_output
print_hex_post_linux_loop:
    mov al, byte[si]
    cmp al, '0'
    jne print_hex_post_linux_done

    mov byte[si], 0x20
    add si, 0x01

    jmp print_hex_post_linux_loop
print_hex_post_linux_done:
    cmp byte[buffer_output + 7], 0x20
    je print_hex_set_last_zero

print_hex_post_linux_done_done:
    mov si, buffer_output
    jmp print_hex_done_final

print_hex_set_last_zero:
    mov byte[buffer_output + 7], '0'
    jmp print_hex_post_linux_done_done

print_hex_error:
    mov si, print_hex_error_str
    mov bl, 0x47
    call teleprint

print_hex_end:
    popa
    retn

buffer_output:      db "00000000", 0x00
print_hex_error_str:db "[ Error printing hex number ]", 0x00
                    nop
