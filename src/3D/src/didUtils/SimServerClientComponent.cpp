///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: SimServerClientComponent.cpp $
// Function       : Set and Get Global ( server and client ) Function or Procedure
//                  Used for didGameServer, didPlatform
// Sam			  : 2012.06.11 Create 
// 
///////////////////////////////////////////////////////////////////////////////

#include "SimServerClientComponent.h"

#include "../didCommon/simMessages.h"
#include "../didCommon/simmessagetype.h"
#include "../didCommon/BaseConstant.h"
#include "../didUtils/utilityfunctions.h"
#include "../didNetwork/SimTCPDataTypes.h"

#include <dtGame/machineinfo.h>
#include <dtABC/application.h>
#include <dtCore/scene.h>

#include <dtDAL/actortype.h>
#include <dtDAL/gameeventmanager.h>
#include <dtDAL/Actorproperty.h>
#include <dtDAL/LibraryManager.h>

#include <dtCore/camera.h>
#include <dtCore/particlesystem.h>
#include <dtCore/refptr.h>

#include <iostream>
#include <osgViewer/View>

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")


//////////////////////////////////////////////////////////////////////////
SimServerClientComponent::SimServerClientComponent(): 
  dtGame::DefaultMessageProcessor(C_COMP_SERVER_CLIENT_CTRL)
{
	 mUsePlayer      = false ;
	 //mPlayerUniqueID("") ;
}

SimServerClientComponent::~SimServerClientComponent()
{
}

dtCore::Transform SimServerClientComponent::get_default_actor_attach (std::string actName )
{
	dtCore::Transform offsetPos;
	osg::Vec3 pos, rot;

	if ( actName == C_CN_SHIP )
	{
		pos[0] = 0.0f;       
		pos[1] = -100.0f;      
		pos[2] = 40.0f;       
		rot[0] = 0.0f;   
		rot[1] = -10.0f;   
		rot[2] = 0.0f;   
	}
	else if ( actName == C_CN_SUBMARINE )
	{
		pos[0] = -10.0f;      
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;    
	}
	else if ( actName == C_CN_HELICOPTER )
	{
		pos[0] = -10.0f;      
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;      
	}
	else if ( actName == C_TYPE_MISSILE )
	{
		pos[0] = 0.0f;       
		pos[1] = -50.0f;      
		pos[2] = 10.0f;       
		rot[0] = 0.0f;   
		rot[1] = -15.0f;   
		rot[2] = 0.0f;   
	} else
		std::cout<<"Warning :: "<<GetName()<<" unknown ("<<actName<<") set default attach position. "<<std::endl;

	offsetPos.SetTranslation(pos);
	offsetPos.SetRotation(rot);

	return offsetPos ;
}

void SimServerClientComponent::SetPlayerAttachToVehicle( const int mVehicleID )
{
	if ( player!= NULL )
	{
		player->SetAttachToVehicleID(mVehicleID);
	} else
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy = NULL ;
		proxy		= GetShipActorByID(mVehicleID);
		if ( proxy.valid() )
		{
			std::string mDOFName = "DOF_Anjungan" ;

			dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
			actProxy = static_cast<dtGame::GameActorProxy *>(proxy.get());

			dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
			if ( mCam->GetParent() != NULL )
				mCam->GetParent()->RemoveChild(mCam);
			actProxy->GetActor()->AddChild(mCam);

			osg::Node *model = actProxy->GetActor()->GetOSGNode();
			dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

			if (mDOFTran != NULL)
			{
				osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
				dtCore::Transform CurrentPos ;
				CurrentPos.SetTranslation(vPos);
				mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
				mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				CurrentPos.SetRotation(0.0f,0.0f,0.0f);
				mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				std::cout <<" Camera attach at "<<actProxy->GetName()<<" by "<<mDOFName<<std::endl;

			} else
			{
				dtCore::Transform t;
				//(actProxy->GetGameActor()).GetTransform(t);
				t = get_default_actor_attach((actProxy->GetGameActor()).GetName());
				mCam->SetTransform(t,dtCore::Transformable::REL_CS);
				std::cout <<"Camera attach at "<<actProxy->GetName()<<" by default position"<<std::endl;
			}
		}
	}
}
 
void SimServerClientComponent::SetPlayerAttachToLauncher(  const int mVehicleID, const int mWeaponID, const int mLauncherID)
{
	bool isValidPlayer = false ;
	if ( mUsePlayer)
	{
		if ( player != NULL )
		{
			std::cout << "========= USE CAMERA PLAYER =============" << std::endl;

			//player->SetAttachToLauncher(mVehicleID, mWeaponID, mLauncherID );
			
			player->SetAttachToTDS(mVehicleID, mWeaponID, mLauncherID );
			isValidPlayer = true ;
		}
		else
			std::cout << "========= USE CAMERA PLAYER BUT NOT VALID =============" << std::endl;
	} 

	if ( !isValidPlayer )
	{
		dtCore::RefPtr<dtDAL::ActorProxy> proxy = NULL ;

		//Search In Launcher
		proxy = GetLauncherActors( C_WEAPON_TYPE_SPOUT , mVehicleID, mWeaponID, mLauncherID);
		if ( proxy.valid() )
		{
			dtCore::RefPtr<dtGame::GameActorProxy> actProxy = NULL ;
			actProxy = static_cast<dtGame::GameActorProxy *>(proxy.get());
	 
			std::string mDOFName = GetCameraDOFName(mWeaponID,mLauncherID) ;

			std::cout << "Search DOF In Launcher Weapon" << std::endl;
			std::cout << "DOF Name = " << mDOFName << std::endl;

			osg::Node *model = actProxy->GetActor()->GetOSGNode();
			dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
			dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDOFName);

			if (mDOFTran == NULL)
			{
				//Search In Ship
				mDOFName =  GetCameraDOFName(mWeaponID,mLauncherID);

				std::cout << "Cannot Find DOF in Launcher Search DOF In Ship" << std::endl;
				std::cout << "DOF Name = " << mDOFName << std::endl;

				dtCore::RefPtr<dtDAL::ActorProxy> shipProxy = NULL ; 
				shipProxy = GetShipActorByID(mVehicleID);

				if ( shipProxy.valid() )
				{	
					dtCore::RefPtr<dtGame::GameActorProxy> shipActProxy = NULL ;
					shipActProxy = static_cast<dtGame::GameActorProxy *>(shipProxy.get());

					osg::Node *shipmodel = shipActProxy->GetActor()->GetOSGNode();
					dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(shipmodel, dtUtil::NodeCollector::DOFTransformFlag);
					mDOFTran = mtColector->GetDOFTransform(mDOFName);
				}
				else
				{
					std::cout << "Cannot Find Ship With ID " << mVehicleID << std::endl;
				}
			}

			if (mDOFTran != NULL)
			{
				static dtCore::Transform SpoutTransform;
				float Heading ,Pitch ,Roll;
				dtCore::RefPtr<dtGame::GameActor> Spout = static_cast<dtGame::GameActor*>(actProxy->GetActor());
				Spout->GetTransform(SpoutTransform,dtCore::Transformable::REL_CS);
				SpoutTransform.GetRotation(Heading , Pitch ,Roll);

				osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);
				dtCore::Transform CurrentPos ;
				CurrentPos.SetTranslation(vPos);

				std::cout << "Heading Spout " << ValidateDegree(-Heading) << std::endl;
			  
				dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
				if ( mCam->GetParent() != NULL )
					mCam->GetParent()->RemoveChild(mCam);

				actProxy->GetActor()->AddChild(mCam);
				mCam->SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
				mCam->GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				CurrentPos.SetRotation(-Heading,0.0f,0.0f);
				mCam->SetTransform(CurrentPos,dtCore::Transformable::REL_CS);
				std::cout <<"	:: "<<GetGameManager()->GetMachineInfo().GetName()<<" Camera handle "<<actProxy->GetActor()->GetName()<<std::endl;

			} else
				std::cout <<"	:: TDS-"<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<" handle "<<actProxy->GetActor()->GetName()<< ", but cannot find position init "<<mDOFName<<std::endl;		
		} 
		else 
		{
			std::cout <<"	:: "<< GetName()<<" Cannot find launcher with launcher "<<mVehicleID<<"-"<<mWeaponID<<"-"<<mLauncherID<<std::endl;
		}
	}
}
 
void SimServerClientComponent::SetObserverFocusByUID( const dtCore::UniqueId uid)
{
	dtGame::GameActorProxy* proxy = NULL;
	proxy = GetGameManager()->FindGameActorById(uid);
	if ( proxy != NULL )
	{
		dtCore::RefPtr<dtGame::GameActorProxy> gap = dynamic_cast<dtGame::GameActorProxy*>(proxy);
		dtCore::Transform t ;
		(gap->GetGameActor()).GetTransform(t);
		t = get_default_vehicle_focus((gap->GetActorType()).GetName(),t);
		bool isValidPlayer = false ;
		if ( mUsePlayer )
		{
			if ( player != NULL )
			{
				player->SetTransform(t);
				isValidPlayer = true ;
				std::cout<<"Set player focus to "<<(proxy->GetGameActor()).GetName()<<std::endl;
			}  
		}
		if ( !isValidPlayer )
		{
			GetGameManager()->GetApplication().GetCamera()->SetTransform(t);
			std::cout<<"Set camera focus to "<<(proxy->GetGameActor()).GetName()<<std::endl;
		}
	}
}

void SimServerClientComponent::SetObserverFocus( const int shipID, const int weaponID, const int launcherID, const int missileID, const int missileNum,  const int eventID)
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	bool actorFound = false;
	if (( weaponID > 0 ) && ( launcherID > 0 ) && ( missileID > 0)) //Search missiles
	{
		proxy = GetMissileActors( shipID, weaponID, launcherID, missileID, missileNum);

		if( proxy.valid())
		{  
			actorFound = true;
		}
	}
	else //Search ship / sub / heli
	{               
		proxy = GetShipActorByID( shipID );

		if( proxy.valid())
		{  
			actorFound = true;
		}
	}

	if (!actorFound)
	{
		std::cout << "Set Camera Observer. Cannot find Actor :: :: shipID = "<< shipID 
			<<" weaponID = "<< weaponID <<" launcherID = "<< launcherID 
			<<" missileID = "<< missileID << std::endl;
	}
	else
	{
		bool bRemoveChild = true ;
		float x, y, z, h, p, r;
		dtCore::Transform tmpTrans;
		dtCore::UniqueId mCurrentTargetId (proxy->GetActor()->GetUniqueId());
		dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();

		if (  eventID == ORD_UTIL_CAMOBS_UP || eventID == ORD_UTIL_CAMOBS_FR ||
			eventID == ORD_UTIL_CAMOBS_BK || eventID == ORD_UTIL_CAMOBS_LF ||
			eventID == ORD_UTIL_CAMOBS_RG )
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
					mCam->GetParent()->RemoveChild(GetGameManager()->GetApplication().GetCamera());
					proxy->GetActor()->AddChild(mCam);
				}
			}
			else
			{
				bRemoveChild = true ;
				proxy->GetActor()->AddChild(mCam);
			}

			switch (eventID)
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
		else if ( eventID == ORD_UTIL_CAMOBS_MOVE_UP || eventID == ORD_UTIL_CAMOBS_MOVE_DW ||
			eventID == ORD_UTIL_CAMOBS_MOVE_RG || eventID == ORD_UTIL_CAMOBS_MOVE_LF ||
			eventID == ORD_UTIL_CAMOBS_MOVE_FR  || eventID == ORD_UTIL_CAMOBS_MOVE_BK )
		{
			osg::Matrix mat;
			osg::Quat q;
			osg::Vec3 viewDir;
			osg::Vec3 pos;

			mCam->GetTransform(tmpTrans);
			tmpTrans.GetRotation(mat);
			mat.get(q);

			switch (eventID)
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
		else if ( eventID == ORD_UTIL_CAMOBS_ROT_UP || eventID == ORD_UTIL_CAMOBS_ROT_DW ||
			eventID == ORD_UTIL_CAMOBS_ROT_RG || eventID == ORD_UTIL_CAMOBS_ROT_LF )
		{
			switch (eventID)
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
		else if ( eventID == ORD_UTIL_CAMOBS_LOCK || eventID == ORD_UTIL_CAMOBS_ULOCK  )
		{
			switch (eventID)
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
	}    
}

dtCore::RefPtr<dtDAL::ActorProxy> SimServerClientComponent::GetShipActorByID(int mVehicleID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== C_CN_SHIP ) || ((*iter)->GetActorType().GetName()== C_CN_SUBMARINE )
			|| ((*iter)->GetActorType().GetName()== C_CN_HELICOPTER )|| ((*iter)->GetActorType().GetName()== C_CN_AIRCRAFT )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mVehicleID )
			{
				proxy = (*iter);
				break;
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimServerClientComponent::GetLauncherActors(const int actTypeID, const int mVehicleID, const int mWeaponID, const int mLauncherID  )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID, actTypeID );

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> PVehID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( PVehID.get() ) );
			int tgt( ValID->GetValue() );

			if ( tgt == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> PWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( PWeaponID.get() ) );
				int wpn( ValWeaponID->GetValue() );

				if ( wpn == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> PLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( PLauncherID.get() ) );
					int lcr( ValLauncherID->GetValue() );
					if ( lcr == mLauncherID )
					{
						proxy = (*iter);
						break;
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimServerClientComponent::GetMissileActors(const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	if ( mMissileNum == 0 ) 
		return NULL ;

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> pVehicleID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValVehicleID( static_cast<dtDAL::IntActorProperty*>( pVehicleID.get() ) );
			int shipID( ValVehicleID->GetValue() );
			if ( shipID == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> pWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( pWeaponID.get() ) );
				int wpnid( ValWeaponID->GetValue() );
				if ( wpnid == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> pLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( pLauncherID.get() ) );
					int lcid( ValLauncherID->GetValue() );
					if ( lcid == mLauncherID )
					{
						dtCore::RefPtr<dtDAL::ActorProperty> pMissileID( (*iter)->GetProperty(C_SET_MID) );
						dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( pMissileID.get() ) );
						int tgt( ValID->GetValue() );
						if ( tgt == mMissileID )
						{
							dtCore::RefPtr<dtDAL::ActorProperty> pMissileNum( (*iter)->GetProperty(C_SET_MNUM) );
							dtCore::RefPtr<dtDAL::IntActorProperty> ValNum( static_cast<dtDAL::IntActorProperty*>( pMissileNum.get() ) );
							int num( ValNum->GetValue() );
							if ( num == mMissileNum )
							{
								proxy = (*iter);
								break;
							}
						}
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimServerClientComponent::GetMissileByLauncher(const int mVehicleID, const int mWeaponID, const int mLauncherID)
{
	//if ( mMissileNum == 0 ) 
		//return NULL ;

	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	const std::string& actTypeName = GetActorWeaponTypeName(mWeaponID,C_WEAPON_TYPE_MISSILE);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if (((*iter)->GetActorType().GetName()== actTypeName )) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> pVehicleID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValVehicleID( static_cast<dtDAL::IntActorProperty*>( pVehicleID.get() ) );
			int shipID( ValVehicleID->GetValue() );
			if ( shipID == mVehicleID )
			{
				dtCore::RefPtr<dtDAL::ActorProperty> pWeaponID( (*iter)->GetProperty(C_SET_WID) );
				dtCore::RefPtr<dtDAL::IntActorProperty> ValWeaponID( static_cast<dtDAL::IntActorProperty*>( pWeaponID.get() ) );
				int wpnid( ValWeaponID->GetValue() );
				if ( wpnid == mWeaponID )
				{
					dtCore::RefPtr<dtDAL::ActorProperty> pLauncherID( (*iter)->GetProperty(C_SET_LID) );
					dtCore::RefPtr<dtDAL::IntActorProperty> ValLauncherID( static_cast<dtDAL::IntActorProperty*>( pLauncherID.get() ) );
					int lcid( ValLauncherID->GetValue() );
					if ( lcid == mLauncherID )
					{
						proxy = (*iter);
						break;
					}
				}
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

dtCore::RefPtr<dtDAL::ActorProxy> SimServerClientComponent::GetMiscActorByID(int mMiscID )
{
	dtCore::RefPtr<dtDAL::ActorProxy> proxy ;

	std::vector<dtGame::GameActorProxy *> fill;
	std::vector<dtGame::GameActorProxy *>::iterator iter;
	GetGameManager()->GetAllGameActors(fill);

	for (iter = fill.begin(); iter < fill.end(); iter++)
	{
		if( (*iter)->GetActorType().GetName().compare(C_CN_MISC) == 0 ) 
		{
			dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( (*iter)->GetProperty(C_SET_VID) );
			dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
			int tgt( ValID->GetValue() );
			if ( tgt == mMiscID )
			{
				proxy = (*iter);
				break;
			}
		}
	}
	if(!proxy.valid())
	{
		return NULL;
	}
	return proxy;
}

 
dtCore::Transform SimServerClientComponent::get_default_vehicle_focus (std::string actName, dtCore::Transform vhcPos)
{
	dtCore::Transform offsetPos;
	osg::Vec3 pos, rot;

	vhcPos.GetTranslation(pos);

	if ( actName == C_CN_SHIP )
	{
		// set player on back upper
		//pos[2]+= 200;     // z  
		//rot[1] = -85.0f;  // p

		pos[0] += 60;
		pos[1] += 200;        // x 
		pos[2] += 20;        // x 
		rot[0] += 160.0f ;   // h
	}
	else if ( actName == C_CN_SUBMARINE )
	{
		// set player on side left
		pos[1] -= 100;        // x 
		rot[0] += 90.0f ;   // h
	}
	else if ( actName == C_CN_HELICOPTER )
	{
		// set player on side left
		pos[1] -= 200;        // x 
		rot[0] += 90.0f ;   // h
	} 
	else if ( actName == C_CN_AIRCRAFT )
	{
		// set player on side left
		pos[1] -= 200;        // x 
		rot[0] += 90.0f ;   // h
	}
	else
		std::cout<<"Warning :: unknown set default focus position. "<<std::endl;

	offsetPos.SetTranslation(pos);
	offsetPos.SetRotation(rot);

	return offsetPos ;
}


//////////////////////////////////////////////////////////////////////////
void SimServerClientComponent::CreatePlayer(const int mid, const bool IsViewCrossHair)
{
	dtCore::RefPtr<dtDAL::ActorProxy> ap= GetGameManager()->CreateActor(C_ACTOR_CAT, C_CN_PLAYER);
	dtCore::RefPtr<dtGame::GameActorProxy> gap= static_cast<dtGame::GameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::GameActor> ga= static_cast<dtGame::GameActor*>(gap->GetActor());
	GetGameManager()->RegisterForMessages(SimMessageType::UTILITY_AND_TOOLS,*gap,dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);

	ga->SetName("Player-"+GetGameManager()->GetMachineInfo().GetName());
	GetGameManager()->AddActor(*gap, false, false);

	std::cout << "Creating Player ID::"<<mid<<" Name::"<<ga->GetName()<<"..."  << std::endl;;
	player  = static_cast<PlayerActor*>(gap->GetActor());
	if ( player != NULL )
	{
		player->SetPlayerType(PLAYER_SET_OBSERVER); //default as observer
		player->SetPlayerID(mid);  
		SetPlayerUniqueID(player->GetUniqueId(),mid);
		dtCore::Transform tr(0.0f, 0.0f, 100.0f, 0, 0, 0);
		player->SetTransform(tr,dtCore::Transformable::ABS_CS);

		if (IsViewCrossHair)
		{
			player->set_view_crossHair();
			std::cout << "Creating Crooss hair " << std::endl;
		}
	}
	std::cout << "done.\n";

	// Turn off the scene light and use the light maps/shadow maps	
	/*dtABC::Application& app = GetGameManager()->GetApplication();
	dtCore::Camera& camera = *app.GetCamera();
	app.GetView()->GetOsgViewerView()->setLightingMode(osg::View::NO_LIGHT);
	osg::StateSet* globalState = camera.GetOSGCamera()->getOrCreateStateSet();
	globalState->setMode(GL_LIGHTING, osg::StateAttribute::OFF);*/
}

bool SimServerClientComponent::GetIsUsePlayer()
{
   return mUsePlayer ;
}

dtCore::UniqueId SimServerClientComponent::GetPlayerUniqueID() const
{
	return mPlayerUniqueID;
}

int SimServerClientComponent::GetPlayerMachineID() const
{
	return mPlayerMachineID;
}

void SimServerClientComponent::SetPlayerUniqueID(const dtCore::UniqueId& uid, const int mid)
{
	dtGame::GameActorProxy* proxy = NULL;
	proxy = GetGameManager()->FindGameActorById(uid);
	if ( proxy != NULL )
	{
		mPlayerMachineID = mid;
		mPlayerUniqueID  = uid ;
		mUsePlayer = true ;
	} else
		mUsePlayer = false ;
}

void SimServerClientComponent::SetUnlockCamera(dtCore::UniqueId mCurrentTargetId)
{
	dtCore::RefPtr<dtCore::Camera> mCam = GetGameManager()->GetApplication().GetCamera();
	dtCore::Transform t;

	dtGame::GameActorProxy* proxy = NULL;
	proxy = GetGameManager()->FindGameActorById(mCurrentTargetId);

	mCam->GetTransform(t,dtCore::Transformable::ABS_CS);

	if ( mCam->GetParent() != NULL )
	{
		if ( mCam->GetParent()->GetUniqueId() == mCurrentTargetId ) 
		{
			mCam->GetParent()->RemoveChild(GetGameManager()->GetApplication().GetCamera());
			
			std::cout<<"Unlock Camera from "<<proxy->GetName()<<std::endl;
		}
	}

	mCam->SetTransform(t,dtCore::Transformable::ABS_CS);	
}

void SimServerClientComponent::SetUnlockPlayer(dtCore::UniqueId mCurrentTargetId)
{
	/// alert player to update state attach 

	dtGame::GameActorProxy* proxy = NULL;
	proxy = GetGameManager()->FindGameActorById(mPlayerUniqueID);

	if ( proxy != NULL )
	{
		if ( (proxy->GetGameActor()).GetParent()->GetUniqueId() == mCurrentTargetId  )
		{
			if ( mUsePlayer)
			{
				if ( player != NULL )
				{
					player->AddToEnvironmentActor();
					std::cout<<"Unlock Player "<<proxy->GetName()<<std::endl;
				}
			}  
		}
	}  
}

void SimServerClientComponent::VerifyPlayerBeforeDeleteParent(dtCore::UniqueId mCurrentTargetId)
{
	if ( mUsePlayer ) 
		SetUnlockPlayer(mCurrentTargetId);
	else
		SetUnlockCamera(mCurrentTargetId);
}

dtCore::Transform SimServerClientComponent::get_player_or_camera_transform ()
{
	dtCore::Transform t ;
	if ( mUsePlayer )
	{
		if ( player!=NULL ) 
			player->GetTransform(t);
		else
			GetGameManager()->GetApplication().GetCamera()->GetTransform(t);
	}
		GetGameManager()->GetApplication().GetCamera()->GetTransform(t);
	return t ;
}

void SimServerClientComponent::set_player_or_camera_transform (dtCore::Transform t)
{
	if ( mUsePlayer )
	{
		if ( player!=NULL ) 
			player->SetTransform(t);
		else
			GetGameManager()->GetApplication().GetCamera()->SetTransform(t);
	}
	else
		GetGameManager()->GetApplication().GetCamera()->SetTransform(t);
}
//////////////////////////////////////////////////////////////////////////
bool SimServerClientComponent::IsInvalidMessage(const dtGame::Message& msg)
{
	if (GetGameManager() == NULL)
	{
		LOG_ERROR("This component is not assigned to a GameManager, but received a message.  It will be ignored.");         
		return true;
	}  

	if (msg.GetDestination() != NULL && GetGameManager()->GetMachineInfo().GetUniqueId()!= msg.GetDestination()->GetUniqueId())
	{
		LOG_DEBUG("Received message has a destination set to a different GameManager than this one. It will be ignored.");
		return true;
	}

	return false;
}

void SimServerClientComponent::ProcessMessage(const dtGame::Message& msg)
{
	/*if (IsInvalidMessage(msg)) {return;}
	if(msg.GetSource() != GetGameManager()->GetMachineInfo()) {
		HandleNetworkMessage(msg);
	}else {
		HandleLocalMessage(msg);
	}*/
}

void SimServerClientComponent::HandleLocalMessage(const dtGame::Message& msg)
{
	///
}

void SimServerClientComponent::HandleNetworkMessage(const dtGame::Message& msg)
{
	//
}