#ifndef APP_EXPORT_H
#define APP_EXPORT_H

#ifdef USE_VLD
#include <vld.h>
#endif

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined( __BCPLUSPLUS__)  || defined( __MWERKS__)
#  ifdef GAME_SERVER_LIBRARY
#    define GAME_SERVER_EXPORT __declspec(dllexport)
#  else
#    define GAME_SERVER_EXPORT __declspec(dllimport)
#  endif
#else
#  define GAME_SERVER_EXPORT
#endif

#endif
