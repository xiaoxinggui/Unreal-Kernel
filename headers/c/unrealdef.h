#ifndef _UNREALDEF_
#define _UNREALDEF_

#ifdef __cplusplus
extern "C" {
#endif

#define UNREAL_VERSION 0x0500
#define _UNREAL_VERSION UNREAL_VERSION

#define NULL (0x00)
#define null NULL

#define INFINITY 0xFFFFFFFF

#ifdef __cplusplus
#define NULLPTR nullptr
#else
#define NULLPTR (*0x00)
#endif // ! __cplusplus

#define SUCCESS 0x00000000
#define FAILIURE 0xFFFFFFFF
#define ABORT 0x0000FFFF
#define CRITICAL 0xFFFF0000

#define EXIT_SUCCESS SUCCESS
#define EXIT_FAILIURE FAILIURE
#define EXIT_ABORT ABORT
#define EXIT_CRITICAL CRITICAL

#ifdef MAX_PATH
#undef MAX_PATH
#endif // ! MAX_PATH

#define MAX_PATH 0xFF

#define MAX(a, b) (((a)>(b))?(a):(b))
#define MIN(a, b) (((a)<(b))?(a):(b))

#define LOBYTE(w) ((BYTE)((DWORD_PTR)(w) & 0xFF))
#define HIBYTE(w) ((BYTE)((DWORD_PTR)(w) >> 0x08))

#define LOWORD(l) ((WORD)((DWORD_PTR)(l) & 0xFFFF))
#define HIWORD(l) ((WORD)((DWORD_PTR)(l) >> 0x0F))

#define MAKEWORD(low, high) ((WORD)(((BYTE)((DWORD_PTR)(low) & 0xFF)) | ((WORD)((BYTE)((DWORD_PTR)(high) & 0xFF))) << 0x08))
#define MAKELONG(low, high) ((LONG)(((WORD)((DWORD_PTR)(low) & 0xFFFF)) | ((DWORD)((WORD)((DWORD_PTR)(high) & 0xFFFF))) << 0x0F))

#define NOP asm volatile("nop")

#define DEFINE_ELEMENT(name, something) #define name something

#ifndef __PRIVILEGIES
#define __PRIVILEGIES

typedef enum {
    KRNL_MANAGER,
    DRIVER_THREAD_LOW,
    DRIVER_THREAD_HIGH,
    DRIVER_THREAD_GENERIC,
    USER_GENERIC,
    USER_HIGH,
    USER_SAFE,
    USER_SAND,
    USER_ADMIN
} THREAD_LEVELS;

#endif // ! __PRIVILEGIES

#ifdef __cplusplus
};
#endif

#endif // ! _UNREALDEF_
