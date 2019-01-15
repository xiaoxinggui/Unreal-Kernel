#ifndef _ERRORS_H
#define _ERRORS_H

#ifdef __cplusplus
extern "C" {
#endif // ! __cplusplus

#define ERROR_REASON_UNKNOWN 0x05550000

typedef struct {
    UINT error_code;
    BYTE severity;
    LPCHAR custom_reason;
} ERROR_EXCEPTION;

#ifdef __cplusplus
};
#endif // ! __cplusplus

#endif // ! _ERRORS_H
