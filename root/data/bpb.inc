; The BPB starts here
bpbOEM:				    	db "UNREAL  "
bpbBytesPerSector:			dw 0x200
bpbSectorsPerCluster:		db 0x01
bpbReservedSectors:			dw 0x44
bpbNumberOfFATs:			db 0x02
bpbRootEntries:				dw 0xe0
bpbTotalSectors:			dw 0xb40
bpbMedia:			    	db 0xf8
bpbSectorsPerFAT:			dw 0x09
bpbSectorsPerTrack:			dw 0x12
bpbHeadsPerCylinder:		dw 0x02
bpbHiddenSectors:			dd 0x00
bpbTotalSectorsBig:			dd 0x00
bsDriveNumber:				db 0x00
bsUnused:			    	db 0x00
bsExtBootSignature:			db 0x29
bsSerialNumber:				db 0xde, 0xad, 0xbe, 0xef
bsVolumeLabel:				db "UNREAL KRNL"
bsFileSystem:				db "FAT12   "
