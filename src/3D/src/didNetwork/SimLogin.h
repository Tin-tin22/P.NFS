#pragma once

#ifdef USE_VLD
#include <vld.h>
#endif

#include <dtUtil\Enumeration.h>
#include <dtCore\UniqueID.h>

class Login
{
	public:
		std::string			mLoginName;
		std::string			mMachineName;
		std::string			mIPAddress;
		
		int					mParams1;
		int					mParams2;
		int					mParams3;

		dtCore::UniqueId	mUniqueId;

		bool isApplied;

		/**
		
		* @ cLoginName = ANJUNGAN / OBSERVER / TDS
		* @ ANJUNGAN   = ( params1 = vehicleID	)
		* @ OBSERVER   = ( params1 = vehicleID , params2 = observerID )
		* @ TDS        = ( params1 = vehicleID , params2 = weaponID, params3 = launcherID )
		*/
		Login( std::string cLoginName , int cParams1 = 0 ,int cParams2 = 0 ,int cParams3 = 0, 
			   std::string cMachineName = "", std::string cIPAddress = "" );

		~Login() { } ;

		void SetUIDObjectHandled(dtCore::UniqueId& UID) 
			{mUniqueId = UID;}

		const dtCore::UniqueId GetUIDObjectHandled() 
			{return mUniqueId;}

	private :

		dtCore::UniqueId mObjectHandledID;

};
