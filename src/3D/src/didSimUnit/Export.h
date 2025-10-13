#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || defined( __BCPLUSPLUS__)  || defined( __MWERKS__)
#  ifdef DID_SIM_UNIT_LIBRARY
#    define DID_DLL_EXPORT __declspec(dllexport)
#  else
#    define DID_DLL_EXPORT __declspec(dllimport)
#  endif
#else
#  define DID_DLL_EXPORT
#endif
