%define unreal_h
%ifdef unreal_h

%define null 0x00
%define nullword 0x0000
%define nullptr [null]

%define success 0x0000
%define failiure 0x0001
%define critical 0xffff

%define not_implemented 0x0700
%define bad_usage 0x0601
%define bad_syntax 0x0602

%define exit_success success
%define exit_failiure failiure
%define exit_critical critical
%define exit_abort 0x07ff

%define vid_memory 0xb8000
%define vid_ptr [vid_memory]

%define boot_memory 0x7c00
%define boot_ptr [boot_memory]

%define current_ptr $

%define current_ver "v0.01"
%define current_os_name "unreal"
%define current_title "Unreal OS"
%define current_api_version not_implemented

%macro retz 0
    jnz %%skip
    retn
    %%skip:
%endmacro

%macro retfr 0
    jc %%error
    retn
    %%error:
    push failiure
    clc
    retn
%endmacro

%macro flush_everyone 0
; 32 bit
xor eax, eax
xor ebx, ebx
xor ecx, ecx
and edx, 0x000000ff
xor esi, esi
xor edi, edi
xor ebp, ebp

; 16 bit
xor ax, ax
xor bx, bx
xor cx, cx
and dx, 0x000000ff
xor si, si
xor di, di
xor bp, bp
%endmacro

%else
%error "unreal_h not defined. Can't proceed with compilation. Halted."
%endif
