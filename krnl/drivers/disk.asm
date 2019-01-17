get_file_list:
	mov si, str_not_implemented
	call teleprint

	retn

str_not_implemented:		db "Not implemented exception.", 0
