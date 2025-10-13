#ifndef APP_EXPORT_H
#define APP_EXPORT_H

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined( __BCPLUSPLUS__)  || defined( __MWERKS__)
#  ifdef PLATFORM_LIBRARY
#    define PLATFORM_EXPORT __declspec(dllexport)
#  else
#    define PLATFORM_EXPORT __declspec(dllimport)
#  endif
#else
#  define PLATFORM_EXPORT
#endif

#endif
