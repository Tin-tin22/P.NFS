#ifndef _SIM_DB_CONST_H
#define	_SIM_DB_CONST_H

// Portable __FUNCTION__
#ifndef __FUNCTION__
 #ifdef __func__
   #define __FUNCTION__ __func__
 #else
   #define __FUNCTION__ "(function n/a)"
 #endif
#endif

#ifndef __LINE__
  #define __LINE__ "(line number n/a)"
#endif

#define DID_CONN_DB   "dbNSuFs"
#define DID_CONN_HOST "tcp://127.0.0.1:3306"
#define DID_CONN_USER "usrNSuFs"
#define DID_CONN_PASS "admin"

#endif	/* _SIM_DB_CONST_H */

