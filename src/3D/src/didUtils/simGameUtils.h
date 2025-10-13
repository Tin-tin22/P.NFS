#ifndef DID_GAME_UTILITY_FUNCTIONS
#define DID_GAME_UTILITY_FUNCTIONS

#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/simActorControl.h"
#include "../didUtils/utilityfunctions.h"

#include <dtGame/gamemanager.h>
#include <dtGame/defaultmessageprocessor.h>
#include <dtGame/gameapplication.h>
#include <dtGame/exceptionenum.h>

#include <osg/Math>
#include <osg/MatrixTransform>
#include <osgSim/DOFTransform>

#include <dtCore/particlesystem.h>
#include <dtCore/transform.h>
#include <dtCore/refptr.h>
#include <dtCore/system.h>

#include <dtABC/application.h>

#include <osg/ArgumentParser>
#include <osg/ApplicationUsage>

#include <dtDAL/actortype.h>
#include <dtDAL/Actorproperty.h>
#include <dtDal/enginepropertytypes.h>

#include <osgDB/readfile>

#include <dtUtil/fileutils.h>

#include <dtUtil/mswin.h>


//////////////////////////////////////////////////////////////////////////
inline bool ExplodeGameEffects( dtGame::GameManager &gameManager, 
							   const int weaponID, const float posx, const float posy, const float posz,
							   const bool setCameraOnPos )
{
	bool success = false ;

	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	mExplosion->LoadFile("testExp.osg",true);
	std::vector<dtDAL::ActorProxy *> ap;
	gameManager.FindActorsByName(C_CN_OCEAN, ap);
	if (ap[0]!= NULL) 
	{
		//static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddChild(mExplosion.get());

		dtCore::Transform tmpTrans;
		tmpTrans.Set(posx,posy,posz,0,0,0);
		mExplosion->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
		mExplosion->SetEnabled(true);
		
		if ( setCameraOnPos )
		{
			dtCore::RefPtr<dtCore::Camera> mCam = gameManager.GetApplication().GetCamera();

			if ( mCam->GetParent() != NULL )
				 mCam->GetParent()->RemoveChild(mCam);

			dtCore::Transform camPos;
			camPos.Set(posx,posy-10,posz,0,0,0);
			mCam->SetTransform(camPos,dtCore::Transformable::ABS_CS);
		}

		success = true ;
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;
	

	return success ;
}

inline bool SetCameraObserver(dtGame::GameManager& gameManager, const int shipID, const int weaponID, const int launcherID, const int missileID, const int missileNum,  const int orderID)
{
	bool success ;

	std::string weaponName = GetActorWeaponTypeName(weaponID, C_WEAPON_TYPE_MISSILE ) ;

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;
	SimActorControl* simCtrl = static_cast<SimActorControl*> (gameManager.GetComponentByName(C_COMP_ACTOR_CONTROLLER));

	bool actorFound = false;
	if (( weaponID > 0 ) && ( launcherID > 0 ) && ( missileID > 0)) //Search missiles
	{
		if ( simCtrl != NULL )
			proxy = simCtrl->GetMissileActors( shipID, weaponID, launcherID, missileID, missileNum);

		if( proxy.valid())
		{  
			actorFound = true;
		}

	}
	else //Search ship / sub / heli
	{               
		if ( simCtrl != NULL )
			proxy = simCtrl->GetShipActorByID( shipID );
		if( proxy.valid())
		{  
			actorFound = true;
		}
	}

	if (!actorFound)
	{
		std::cout << "Set Camera Observer. Cannot find Actor :: :: shipID = "<< shipID 
			<<" weapon = "<< weaponName <<" launcherID = "<< launcherID 
			<<" missileID = "<< missileID << std::endl;

		success = false ;
	}
	else
	{
		bool bRemoveChild = true ;
		float x, y, z, h, p, r;
		dtCore::Transform tmpTrans;
		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());
		dtCore::RefPtr<dtCore::Camera> mCam = gameManager.GetApplication().GetCamera();

		if (  orderID == ORD_UTIL_CAMOBS_UP || orderID == ORD_UTIL_CAMOBS_FR ||
			orderID == ORD_UTIL_CAMOBS_BK || orderID == ORD_UTIL_CAMOBS_LF ||
			orderID == ORD_UTIL_CAMOBS_RG )
		{
			if ( mCam->GetParent() != NULL )
			{
				if (  mCam->GetParent()->GetUniqueId() == mCurrentTargetId )
				{
					bRemoveChild = false ;
					std::cout<<"Camera already set on "<<proxy->GetActor()->GetName()<<std::endl;
				} 
				else
				{
					bRemoveChild = true ;
					mCam->GetParent()->RemoveChild(gameManager.GetApplication().GetCamera());
					proxy->GetActor()->AddChild(mCam);
				}
			}
			else
			{
				bRemoveChild = true ;
				proxy->GetActor()->AddChild(mCam);
			}

			switch (orderID)
			{
			case ORD_UTIL_CAMOBS_UP: 
				tmpTrans.Set(0,-100.0f,500.0f,0,-75.0f,0);
				break;
			case ORD_UTIL_CAMOBS_FR : 
				tmpTrans.Set(0,+150.0f,15.0f,180.0f,0,0);
				break;
			case ORD_UTIL_CAMOBS_BK : 
				tmpTrans.Set(0,-150.0f,15.0f,0,0,0);
				break;
			case ORD_UTIL_CAMOBS_LF : 
				tmpTrans.Set(-150,0,15.0f,-90.0f,0,0);
				break;
			case ORD_UTIL_CAMOBS_RG : 
				tmpTrans.Set(150,0,15.0f,90.0f,0,0);
				break;
			}

			mCam->SetTransform(tmpTrans,dtCore::Transformable::REL_CS);

			if ( bRemoveChild )
			{
				mCam->GetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
				if ( mCam->GetParent() != NULL )
					mCam->GetParent()->RemoveChild(mCam);				
				mCam->SetTransform(tmpTrans,dtCore::Transformable::ABS_CS);
			}

		}
		else if ( orderID == ORD_UTIL_CAMOBS_MOVE_UP || orderID == ORD_UTIL_CAMOBS_MOVE_DW ||
			orderID == ORD_UTIL_CAMOBS_MOVE_RG || orderID == ORD_UTIL_CAMOBS_MOVE_LF ||
			orderID == ORD_UTIL_CAMOBS_MOVE_FR  || orderID == ORD_UTIL_CAMOBS_MOVE_BK )
		{
			osg::Matrix mat;
			osg::Quat q;
			osg::Vec3 viewDir;
			osg::Vec3 pos;

			mCam->GetTransform(tmpTrans);
			tmpTrans.GetRotation(mat);
			mat.get(q);

			switch (orderID)
			{
			case ORD_UTIL_CAMOBS_MOVE_UP: 
				{
					viewDir = q * osg::Vec3(0,0,5);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

			case ORD_UTIL_CAMOBS_MOVE_DW: 
				{
					viewDir = q * osg::Vec3(0,0,-5);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

			case ORD_UTIL_CAMOBS_MOVE_RG: 
				{
					viewDir = q * osg::Vec3(+5,0,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Right. "<<std::endl;
				}
				break;

			case ORD_UTIL_CAMOBS_MOVE_LF: 
				{
					viewDir = q * osg::Vec3(-5,0,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Left. "<<std::endl;
				}
				break;

			case ORD_UTIL_CAMOBS_MOVE_FR: 
				{
					viewDir = q * osg::Vec3(0,5,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Forward. "<<std::endl;
				}
				break;

			case ORD_UTIL_CAMOBS_MOVE_BK: 
				{
					viewDir = q * osg::Vec3(0,-5,0);
					tmpTrans.GetTranslation(pos);
					pos = pos + viewDir;
					tmpTrans.SetTranslation(pos);
					mCam->SetTransform(tmpTrans);
					//std::cout<<"Camera Move Back. "<<std::endl;
				}
				break;
			}
		}
		else if ( orderID == ORD_UTIL_CAMOBS_ROT_UP || orderID == ORD_UTIL_CAMOBS_ROT_DW ||
			orderID == ORD_UTIL_CAMOBS_ROT_RG || orderID == ORD_UTIL_CAMOBS_ROT_LF )
		{
			switch (orderID)
			{
			case ORD_UTIL_CAMOBS_ROT_UP: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h,p+1.0f,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

			case ORD_UTIL_CAMOBS_ROT_DW: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h,p-1.0f,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

			case ORD_UTIL_CAMOBS_ROT_LF: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h-1.0f,p,r);
					mCam->SetTransform(tmpTrans);
				}
				break;

			case ORD_UTIL_CAMOBS_ROT_RG: 
				{
					mCam->GetTransform(tmpTrans);
					tmpTrans.GetTranslation(x, y, z);
					tmpTrans.GetRotation(h, p, r);
					tmpTrans.Set(x,y,z,h+1.0f,p,r);
					mCam->SetTransform(tmpTrans);
				}
				break;
			}
		}
		else if ( orderID == ORD_UTIL_CAMOBS_LOCK || orderID == ORD_UTIL_CAMOBS_ULOCK  )
		{
			switch (orderID)
			{
			case ORD_UTIL_CAMOBS_LOCK: 
				{
					mCam->GetTransform(tmpTrans);
					if ( mCam->GetParent() != NULL )
						mCam->GetParent()->RemoveChild(mCam);
					proxy->GetActor()->AddChild(mCam);
					mCam->SetTransform(tmpTrans);
					std::cout<<"Lock Camera on "<<proxy->GetActor()->GetName()<<std::endl;
				}
				break;
			case ORD_UTIL_CAMOBS_ULOCK: 
				{
					mCam->GetTransform(tmpTrans);
					if ( mCam->GetParent() != NULL )
					{
						mCam->GetParent()->RemoveChild(mCam);
						mCam->SetTransform(tmpTrans);
						std::cout<<"UnLock Camera from "<<proxy->GetActor()->GetName()<<std::endl;
					}
					else
						std::cout<<"Camera :: Already UnLock"<<std::endl;
				}
				break;
			}
		}

		success = true ;
	}    

	return success;

}


#endif 