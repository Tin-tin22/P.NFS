#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#if defined(_WIN32)
#  ifdef DID_ACTORS_LIBRARY
#    define DID_ACTORS_EXPORT __declspec(dllexport)
#  else
#    define DID_ACTORS_EXPORT __declspec(dllimport)
#  endif
#else
// FIXME!
#  define DID_ACTORS_EXPORT
#endif
