; WARNING
; when i did this bootloader, i had no idea about fat or anything, so
; this is almost the exact bootsector mikeos has.
; i say almost because in my try to understand it, i chenged some things like names...
; anyways, if someone wants to improve it, do it, but the part
; that i 100% wrote by myself is the kernel loader.


use16
org 0x7c00

	jmp short bootloader_start
	nop

; Make sure we are at BPB's start
times 0x03 - ($ - $$) db 0x00

%include "data/bpb.inc"

bootloader_start:
	cli
	jmp 0x0000:fix_cs		; Set CS to 0x0000 with a long jump
	fix_cs:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ax, 0x1000
	mov ss, ax
	mov sp, 0xfff0
	sti

	cmp dl, 0x00
	je no_change
	mov [dat_bootdev], dl
	mov ah, 0x08
	int 0x13
	jc fatal_str_disk_error
	and cx, 0x3f
	mov [bpbSectorsPerTrack], cx
	movzx dx, dh
	add dx, 0x01
	mov [bpbHeadsPerCylinder], dx

no_change:
	mov eax, 0x00

floppy_ok:
	mov ax, 0x13
	call l2hts

	mov si, disk_buffer
	mov bx, ds
	mov es, bx
	mov bx, si

	mov ah, 0x02
	mov al, 0x0e

	pusha

read_root_dir:
	popa
	pusha

	stc
	int 0x13

	jnc search_dir
	call reset_floppy
	jnc read_root_dir

	jmp reboot

search_dir:
	popa

	mov ax, ds
	mov es, ax
	mov di, disk_buffer

	mov cx, word[bpbRootEntries]
	xor ax, ax


next_root_entry:
	xchg cx, dx

	mov si, kernel_loader
	mov cx, 0x0b
	rep cmpsb
	je found_file_to_load

	add ax, 0x20

	mov di, disk_buffer
	add di, ax

	xchg dx, cx
	loop next_root_entry

	mov si, str_not_found
	call print

	jmp reboot

found_file_to_load:
	mov ax, word[es:di + 0x0f]
	mov word[dat_cluster], ax

	mov ax, 0x01
	call l2hts

	mov di, disk_buffer
	mov bx, di

	mov ah, 0x02
	mov al, 0x09

	pusha


read_fat:
	popa
	pusha

	stc
	int 0x13

	jnc read_fat_ok
	call reset_floppy
	jnc read_fat

fatal_str_disk_error:
	mov si, str_disk_error
	call print

	jmp reboot

read_fat_ok:
	popa

	mov ax, 0x2000
	mov es, ax
	xor bx, bx

	mov ah, 0x02
	mov al, 0x01

	push ax

load_file_sector:
	mov ax, word[dat_cluster]
	add ax, 0x1f

	call l2hts

	mov ax, 0x2000
	mov es, ax
	mov bx, word[dat_pointer]

	pop ax
	push ax

	stc
	int 0x13

	jnc calculate_next_cluster

	call reset_floppy
	jmp load_file_sector

calculate_next_cluster:
	mov ax, [dat_cluster]
	xor dx, dx
	mov bx, 0x03
	mul bx
	mov bx, 0x02
	div bx
	mov si, disk_buffer
	add si, ax
	mov ax, word[ds:si]

	or dx, dx

	jz even

odd:
	shr ax, 0x04
	jmp short next_cluster_cont

even:
	and ax, 0x0fff


next_cluster_cont:
	mov word[dat_cluster], ax

	cmp ax, 0x0ff8
	jae end

	add word [dat_pointer], 0x200
	jmp load_file_sector


end:
	pop ax
	mov dl, byte [dat_bootdev]

	jmp 0x2000:0x0000

reboot:
	xor ax, ax
	int 0x16
	xor ax, ax
	int 0x19

print:
	pusha
	mov ah, 0x0e
print_loop:
	lodsb
	or al, al
	jz print_done
	int 0x10
	jmp short print_loop
print_done:
	popa
	retn

reset_floppy:
	push ax
	push dx
	xor ax, ax
	mov dl, byte[dat_bootdev]
	stc
	int 0x13
	pop dx
	pop ax
	retn

l2hts:
	push bx
	push ax

	mov bx, ax

	xor dx, dx
	div word [bpbSectorsPerTrack]
	add dl, 0x01
	mov cl, dl
	mov ax, bx

	xor dx, dx
	div word[bpbSectorsPerTrack]
	xor dx, dx
	div word[bpbHeadsPerCylinder]
	mov dh, dl
	mov ch, al

	pop ax
	pop bx

	mov dl, byte[dat_bootdev]
	retn

	kernel_loader:		db "LOADKRNLSYS"

	str_disk_error:		db "Floppy error. Press any key.", 0x00
	str_not_found:		db "Kernel loader not found.", 0x00

	dat_bootdev:		db 0x00
	dat_cluster:		dw 0x0000
	dat_pointer:		dw 0x0000

	times 0x1fb - ($ - $$) db 0x00
	db 0xac, 0xc0, 0xd1, 0x55, 0xaa

disk_buffer:
