#ifndef UNREAL
#define UNREAL

#ifdef __cplusplus
extern "C" {
#endif // ! __cplusplus

#ifndef NO_STRICT
#ifndef STRICT
#define STRICT
#endif // ! STRICT
#endif // ! NO_STRICT

#ifndef UNICODE
#define UNICODE

#endif // ! UNICODE

#if (!defined(__UNREAL) || !defined(_UNREAL))
#define __UNREAL
#define _UNREAL
#else
#endif // ! (!__UNREAL) || (!_UNREAL)

#ifndef _UNREAL_INC_
#define _UNREAL_INC_

#include "unrealdef.h"
#include "types.h"
#include "errors.h"

#endif // ! _UNREAL_INC_

#ifdef __cplusplus
};
#endif // ! __cplusplus

#endif // ! UNREAL
