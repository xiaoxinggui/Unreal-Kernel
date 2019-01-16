
; TODO: (i am too lazy to do that)
;			make this file make sense (it doesn't)
; 			i will probably do that soon(which probably means never)

	mov cl, 0x13
	mov ah, 0x02
	mov al, 0x0e

	mov ax, 0x13
	mov dl, 0x00
	mov bx, file_buffer
	mov cx, 0x0e
	call read_sectors

	mov si, file_buffer
	mov word[current_cluster], 0x00
read_next_fat:
	cmp byte[si], 0x00
	je no_bin

	;movzx edx, si
	;call print_hex

	mov di, bin_name
	call compare_fat_strings
	jc prepare_next

yes_bin:
	mov ax, 0x21
	add ax, word[current_cluster]
	mov word[next_fat_loc], ax

	; Now we have the location of the cluster in wich out
	; bin directory contents are located.

	; and so we load them
	mov ax, word[next_fat_loc]
	mov dl, 0x00
	mov bx, file_buffer
	mov cx, 0x02
	call read_sectors

	; we read it
	jmp second_step

prepare_next:
	add si, 0x20
	add word[current_cluster], 0x01
	jmp read_next_fat

no_bin:
	mov si, str_error_kernel_not_found
	call print

	jmp $

next_fat_entry:
	add word[fat_entry], 0x0001
	add word[fat_ptr], 0x0020

	jmp $

second_step:
	mov si, file_buffer
	mov word[current_cluster], 0x00
second_read_next_fat:
	cmp byte[si], 0x00
	je kernel_not_found

	mov di, kernel_filename
	call compare_fat_strings
	jc prepare_next_kernel

yes_kernel:
	mov si, str_found
	call print

	; please don't laugh at me for this way of
	; getting the kernel location...
	; i am very noob with this ok?
	mov ax, 0x21
	add ax, word[current_cluster]
	add ax, 0x13
	mov word[next_fat_loc], ax

	mov ax, 0xffff
	mov es, ax
	mov ax, word[next_fat_loc]
	xor dl, dl
	mov bx, 0x0010					; Load to offset 0x0010
	mov cx, 64						; Load 64 sectors (32 KB)
	call read_sectors

	jmp 0xffff:0x0010

kernel_not_found:
	mov si, str_error_kernel_not_found
	call print

	jmp $

prepare_next_kernel:
	add si, 0x20
	add word[current_cluster], 0x01
	jmp second_read_next_fat

compare_fat_strings:
	; SUBROUTINE
	;   si = string to compare
	;   di = name it should have
	; returns
	;	cf = set if not found

	pusha
	mov word[temp1], 0x00

compare_fat_strings_loop:
	mov al, byte[si]
	mov bl, byte[di]

	cmp al, bl
	jne compare_fat_strings_not_same

	add si, 0x01
	add di, 0x01

	add word[temp1], 0x01
	cmp word[temp1], 0x08
	jge compare_fat_strings_same

	jmp compare_fat_strings_loop

compare_fat_strings_same:
	popa
	clc
	retn

compare_fat_strings_not_same:
	popa
	stc
	retn
