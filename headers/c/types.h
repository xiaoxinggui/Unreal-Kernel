#ifndef _TYPE_H
#define _TYPE_H

#ifdef __clpusplus
extern "C" {
#endif

// void
typedef void *PVOID, *LPVOID;
typedef const void *PCVOID, *LPCVOID;
typedef unsigned void *UPVOID, *ULPVOID;
typedef unsigned const void *UPCVOID, *ULPCVOID;

// char
typedef char CHAR, *PCHAR, *LPCHAR;
typedef const char CCHAR, *PCCHAR, *LPCCHAR;
typedef unsigned char UCHAR, *UPCHAR, *ULPCHAR;
typedef unsigned const char UCCHAR, *UPCCHAR, *ULPCCHAR;

// short
typedef short SHORT, *PSHORT, *LPSHORT;
typedef const short CSHORT, *PCSHORT, *LPCSHORT;
typedef unsigned short USHORT, *UPSHORT, *ULPSHORT;
typedef unsigned const short UCSHORT, *UPCSHORT, *ULPCSHORT;

// int
typedef int INT, *PINT, *LPINT;
typedef const int CINT, *PCINT, *LPCINT;
typedef unsigned int UINT, *UPINT, *ULPINT;
typedef unsigned const int UCINT, *UPCINT, *ULPCINT;

// long
typedef long LONG, *PLONG, *LPLONG;
typedef const long CLONG, *PCLONG, *LPCLONG;
typedef unsigned long ULONG, *UPLONG, *ULPLONG;
typedef unsigned const long UCLONG, *UPCLONG, *ULPCLONG;

// long long
typedef long long LONG64, *PLONG64, *LPLONG64;
typedef const long long CLONG64, *PLONG64, *LPCLONG64;
typedef unsigned long long ULONG64, *UPLONG64, *ULPLONG64;
typedef unsigned const long long UCLONG64, *UPCLONG64, *ULPCLONG64;

// other naming for them
#define BYTE UCHAR
#define WORD USHORT
#define DWORD UINT
#define QWORD ULONG
#define EWORD ULONG64

#define PBYTE UPCHAR
#define PWORD UPSHORT
#define PDWORD UPINT
#define PQWORD UPLONG
#define PEWORD UPLONG64

#define LPBYTE ULPCHAR
#define LPWORD ULPSHORT
#define LPDWORD ULPINT
#define LPQWORD ULPLONG
#define LPEWORD ULPLONG64

typedef unsigned int UINT24:24;

typedef struct {
    UINT x;
    UINT y;
} RECT;

typedef struct {
    unsigned char b:4;
    unsigned char f:4;
} COLOR_REF_8;

typedef struct {
    BYTE r;
    BYTE g;
    BYTE b;
} COLOR_REF_24;

typedef struct {
    BYTE r;
    BYTE g;
    BYTE b;
    BYTE a;
} COLOR_REF_32;

#ifdef _MODE_DOS
#define COLOR_REF COLOR_REF_8
#elif _MODE_GRAPHIC
#define COLOR_REF COLOR_REF_24
#else
#error "NO COLOR MODE DEFINED"
#endif

typedef RECT *PRECT, *LPRECT;
typedef COLOR_REF_8 *PCOLOR_REF_8, *LPCOLOR_REF_8;
typedef COLOR_REF_24 *PCOLOR_REF_24, *LPCOLOR_REF_24;
typedef COLOR_REF_32 *PCOLOR_REF_32, *LPCOLOR_REF_32;

typedef BYTE COLOR8;
typedef WORD COLOR16;
typedef UINT24 COLOR24;
typedef DWORD COLOR32;

#define RGB(r, g, b) (UINT24)((DWORD)(b | (g << 8) | (r << 16)))

#ifdef __clpusplus
};
#endif

#else
#error "UNABLE TO DEFINE UNREAL BASIC TYPES"
#endif // ! _TYPE_H
