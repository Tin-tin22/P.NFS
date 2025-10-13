#include "simlogin.h"

Login::Login( std::string cLoginName , int cParams1  ,int cParams2  ,int cParams3  , 
			 std::string cMachineName , std::string cIPAddress ) 
{

	mLoginName		= cLoginName;
	mParams1		= cParams1 ;
	mParams2		= cParams2 ;
	mParams3		= cParams3 ; 
	mMachineName	= cMachineName;
	mIPAddress		= cIPAddress;

	isApplied = false;
}