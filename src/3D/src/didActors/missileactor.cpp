#include "missileactor.h"
#include "ShipModelActor.h"
#include "submarineactor.h"
#include "helicopteractor.h"
#include "aircraftactor.h"
#include "didactorssources.h"

#define _WINSOCKAPI_
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <dtUtil/mswin.h>
#pragma comment(lib, "ws2_32.lib")

///////////////////////////////////////////////////////////////////////////////
MissilesActorProxy::MissilesActorProxy()
{

}

MissilesActorProxy::~MissilesActorProxy()
{

}


///////////////////////////////////////////////////////////////////////////////
void MissilesActorProxy::BuildPropertyMap()
{

	BaseWeaponActorProxy::BuildPropertyMap();

	MissilesActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::IntActorProperty(C_SET_MID, C_SET_MID, 
		dtDAL::IntActorProperty::SetFuncType(actor, &MissilesActor::SetMissileID), 
		dtDAL::IntActorProperty::GetFuncType(actor, &MissilesActor::GetMissileID),
		"Sets/gets Missile Id", C_TYPE_MISSILE)); 

	AddProperty(new dtDAL::IntActorProperty(C_SET_MNUM, C_SET_MNUM, 
		dtDAL::IntActorProperty::SetFuncType(actor, &MissilesActor::SetMissileNum), 
		dtDAL::IntActorProperty::GetFuncType(actor, &MissilesActor::GetMissileNum),
		"Sets/gets Missile Id", C_TYPE_MISSILE)); 

	AddProperty(new dtDAL::BooleanActorProperty(C_SET_LAUNCHED,C_SET_LAUNCHED,
		dtDAL::BooleanActorProperty::SetFuncType(actor, &MissilesActor::SetLaunched),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &MissilesActor::GetLaunched), 
		"Sets/gets Launched." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty(C_SET_HAS_LAUNCHER,C_SET_HAS_LAUNCHER,
		dtDAL::BooleanActorProperty::SetFuncType(actor, &MissilesActor::SetHasLauncher),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &MissilesActor::GetHasLauncher), 
		"Sets/gets Launched." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty(C_SET_LETHALITY, C_SET_LETHALITY, 
		dtDAL::IntActorProperty::SetFuncType(actor, &MissilesActor::SetMissileLethality), 
		dtDAL::IntActorProperty::GetFuncType(actor, &MissilesActor::GetMissileLethality),
		"Sets/gets Missile Lethality", C_TYPE_MISSILE));
}

void MissilesActorProxy::BuildInvokables()
{
    BaseWeaponActorProxy::BuildInvokables();
}

void MissilesActorProxy::OnEnteredWorld()
{
	BaseWeaponActorProxy::OnEnteredWorld();
}

void MissilesActorProxy::OnRemovedFromWorld()
{
	MissilesActor &pa = static_cast<MissilesActor&>(GetGameActor());

	if (dtAudio::AudioManager::GetInstance().IsInitialized() && pa.missileSound != NULL)
	{
	dtAudio::AudioManager::GetInstance().FreeSound(pa.missileSound);
	}
}

///////////////////////////////////////////////////////////////////////////////
 
MissilesActor::MissilesActor(dtGame::GameActorProxy& proxy)
                : BaseWeaponActor(proxy)
                , mMissileID(0)
				, mMissileNum(0)
				, Lethality(0)
				, distance(0)
				, isHasLauncher(false)
				, isLaunch(false)
				, mHitPointCollision(0.0f, 0.0f, 0.0f)
{
	//mIsector= new dtCore::Isector;
	//std::cout << " Test Stabil Create " << GetName() << std::endl;
	//parentProxy = NULL ;
}

MissilesActor::~MissilesActor()
{

}

bool MissilesActor::IsMissileValidID ( const int VID, const int WID, const int LID, const int MID, const int MNum )
{
	bool isValid = false ;

	if ( ( VID == mVehicleID )  && ( WID == mWeaponID )  && 
		 ( LID == mLauncherID ) && ( MID== mMissileID )  && ( MNum == mMissileNum ))
	   isValid = true ;
	
	return isValid ;
}


void MissilesActor::FreeSound(dtAudio::Sound *tmpSound)
{
	if ( tmpSound != NULL){
		tmpSound->Stop();
		dtAudio::AudioManager::GetInstance().FreeSound( *&tmpSound );
		tmpSound = NULL;
	}
}
void MissilesActor::chkPassable(const dtCore::DeltaDrawable *t, const dtCore::DeltaDrawable *s, bool &bChk)
{
	bChk= false;
	if (t->GetUniqueId()== s->GetUniqueId())
		bChk= true;

	if (!bChk)
	{
		for(unsigned int i= 0; i< s->GetNumChildren(); i++)
		{
			chkPassable(t, s->GetChild(i), bChk);
			if (bChk) 
				break;
		}
	}
}

dtDAL::ActorProxy* MissilesActor::CeckCollision(float pSpeed, float pDeltaTime)
{
	/*distance = pSpeed * pDeltaTime;
	if (distance<= 0.0f)
	{
		//std::cout<<"Warning: speed is zero, no need to check collision"<<std::endl;
		return NULL;
	}
	dtCore::Transform t;
	GetTransform(t);

	//if (mIsector->GetScene()== NULL)
	//{
		//mIsector->SetScene(&(GetGameActorProxy().GetGameManager()->GetScene()));
	//}

	mIsector->Reset();
	mIsector->SetScene(GetSceneParent());
	//osg::Vec3 pos= t.GetTranslation();
	//mIsector->SetStartPosition(pos);

	// coba gunakan matix [2/13/2013 DID RKT2]
	osg::Vec3 pos= t.GetTranslation();
	osg::Matrix matrix;
	t.GetRotation(matrix);
	mIsector->SetStartPosition(pos);
	osg::Vec3 at(matrix(1, 0), matrix(1, 1), matrix(1, 2));
	at *= 5;
	mIsector->SetEndPosition(pos + at);

	osg::Vec3 rot;
	t.GetRotation(rot);
	float h= rot[0];
	float p= rot[1];

	float x, y, z;
	z= sin(osg::DegreesToRadians(p));
	x= cos(osg::DegreesToRadians(p)) * sin(osg::DegreesToRadians(h));
	y= cos(osg::DegreesToRadians(p)) * cos(osg::DegreesToRadians(h));

	osg::Vec3 dir(x, y, z);

	mIsector->SetDirection(dir);
	mIsector->SetLength(distance);

	if (!mIsector.valid())
		return NULL;

	bool isUpdate = mIsector->Update();

	if (isUpdate)
	{
		osgUtil::IntersectVisitor::HitList hl= mIsector->GetHitList();
		osgUtil::IntersectVisitor::HitList::iterator i;

		int j= 0;
		for(i= hl.begin(); i!= hl.end(); i++)
		{
			dtCore::ObserverPtr<dtCore::DeltaDrawable> hitActor= mIsector->MapNodePathToDrawable((*i).getNodePath());
			bool bChk= false;

			if (hitActor.get() == this)
			{
				//std::cout<<"Warning: hitting myself!"<<std::endl;
				continue;
			}

			if ( mMyParent == NULL ){

				dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(mVehicleID);
				if ( parentProxy.valid() )
				{
					dtCore::RefPtr<ShipModelActor> parent = static_cast<ShipModelActor*>(parentProxy->GetActor());
					mMyParent = parent;
				}
			}

			if ( mMyParent != NULL ){
				chkPassable(hitActor.get(), mMyParent.get(), bChk);
				if (!bChk)
				{
					dtCore::RefPtr<dtDAL::ActorProxy> proxy= GetGameActorProxy().GetGameManager()->FindGameActorById(hitActor->GetUniqueId());
					if (proxy!= NULL)
					{    
						if ( proxy->GetName()==C_CN_OCEAN )  
						{
							std::cout<<GetName()<<" "<<mMissileID<<" hit ocean "<<std::endl;
							continue;
						} 
						else
						{ 
							mIsector->GetHitPoint(mHitPointCollision, j);
							return proxy.get();
						}
					}
				}
				j++;
			}
		}
	}*/
	return NULL;
}


//dtDAL::ActorProxy* MissilesActor::CeckCollision(float pSpeed, float pDeltaTime)
//{
//	float distance = 10.0f;
//	if (distance<= 0.0f)
//	{
//		//std::cout<<"Warning: speed is zero, no need to check collision"<<std::endl;
//		return NULL;
//	}
//	dtCore::Transform t;
//	GetTransform(t);
//
//	if (mIsector->GetScene()== NULL)
//	{
//		mIsector->SetScene(&(GetGameActorProxy().GetGameManager()->GetScene()));
//	}
//
//	mIsector->Reset();
//	osg::Vec3 pos= t.GetTranslation();
//	osg::Matrix matrix;
//	t.GetRotation(matrix);
//	mIsector->SetStartPosition(pos);
//	osg::Vec3 at(matrix(1, 0), matrix(1, 1), matrix(1, 2));
//	at *= 5;
//	mIsector->SetEndPosition(pos + at);
//
//	osg::Vec3 rot;
//	t.GetRotation(rot);
//	float h= rot[0];
//	float p= rot[1];
//
//	float x, y, z;
//	z= sin(osg::DegreesToRadians(p));
//	x= cos(osg::DegreesToRadians(p)) * sin(osg::DegreesToRadians(h));
//	y= cos(osg::DegreesToRadians(p)) * cos(osg::DegreesToRadians(h));
//
//	osg::Vec3 dir(x, y, z);
//
//	mIsector->SetDirection(dir);
//	mIsector->SetLength(distance);
//	if (mIsector->Update())
//	{
//		dtCore::DeltaDrawable* dd = mIsector->GetClosestDeltaDrawable();
//		if (dd == NULL)
//		{
//			return NULL;
//		}
//
//		if ( dd == this )
//		{
//			return NULL ;
//		}
//
//		if ( GetParent()->GetUniqueId() == dd->GetUniqueId() )
//		{
//			/// warning ocean bisa jadi parentnya, do something
//			return NULL ;
//		}
//
//		dtCore::RefPtr<dtDAL::ActorProxy> proxy= GetGameActorProxy().GetGameManager()->FindGameActorById(dd->GetUniqueId());
//		if (proxy!= NULL)
//		{    
//			if ( proxy->GetName()==C_CN_OCEAN )  
//			{
//				std::cout<<GetName()<<" hit ocean "<<std::endl;
//			}
//			else
//			{ 
//				std::cout<<GetName()<<" hit "<<proxy->GetName()<<std::endl;
//				return proxy.get();
//			}
//		}
//		else
//		{
//			proxy = GetGameActorProxy().GetGameManager()->FindActorById(dd->GetUniqueId());
//
//			if (proxy!= NULL)
//			{
//				std::cout<<GetName()<<" hit "<<proxy->GetName()<<std::endl;
//				return proxy.get();
//			}
//		}
//	}
//	return NULL;
//}

void MissilesActor::AddToEnvironmentActor()
{
	dtCore::Transform t;
	GetTransform(t);

	if ( GetParent() != NULL ) 
		GetParent()->RemoveChild(this);

	std::vector<dtDAL::ActorProxy *> ap;
	GetGameActorProxy().GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
	if (ap[0]!= NULL)  
	{
		static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(this) );
	}
	else
		std::cout<<"Environment actor is missing!"<<std::endl;
	SetTransform(t);

}

void MissilesActor::SetMissileID(int val)
{
    mMissileID = val;
}
int MissilesActor::GetMissileID()
{
    return mMissileID;
}

void MissilesActor::SetMissileNum(int val)
{
	mMissileNum = val;
}
int MissilesActor::GetMissileNum()
{
	return mMissileNum;
}
 
void MissilesActor::SetLaunched(bool val)
{
	isLaunch = val;
}

bool MissilesActor::GetLaunched()
{
	return isLaunch;
}

void MissilesActor::SetHasLauncher(bool val)
{
	isHasLauncher = val;
}
bool MissilesActor::GetHasLauncher()
{
	return isHasLauncher;
}

void MissilesActor::SetMissileLethality(int val)
{
	Lethality = val;
}
int MissilesActor::GetMissileLethality()
{
	return Lethality;
}

void MissilesActor::SendMessageToServer( const int mVehicleID, int OrderID)
{

	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
	dtCore::RefPtr<MsgUtilityAndTools> mess;
	dtGame::MessageFactory* mf=&gm->GetMessageFactory();
	mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),mess);
	mess->SetOrderID(TIPE_UTIL_MISSILE_STATUS);
	mess->SetUAT0(mVehicleID);
	mess->SetUAT1(mWeaponID);
	mess->SetUAT2(mLauncherID);  
	mess->SetUAT3(mMissileID);
	mess->SetUAT4(mMissileNum);
	mess->SetUAT5(OrderID);
	gm->SendNetworkMessage(*mess);
	gm->SendMessage(*mess);

}


void MissilesActor::UpdateStatusDBEffectTo2D( const dtCore::DeltaDrawable *mVehicle, int OrderID)
{
	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
	if ( gm->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{

		std::string sts ;
		if ( OrderID == ST_MISSILE_RUN ) sts ="Update Status : Running ";
		//else if ( OrderID == ST_MISSILE_HIT ) sts ="Update Status : Hit ";
		else if ( OrderID == ST_MISSILE_DEL ) sts ="Update Status : Shutdown ";

		if (  OrderID == ST_MISSILE_RUN  || OrderID == ST_MISSILE_DEL )  
		{
			ShipModelActor* ShipAct  = static_cast<ShipModelActor*>(mMyParent.get());
			if (ShipAct!= NULL)
			{
				ShipAct->ShipHitByPosition(mHitPointCollision,0);
				SendMessageToServer(ShipAct->GetVehicleID(),OrderID);
			}
		}
		//else if ( OrderID == ST_MISSILE_HIT ) {

		//	dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameActorProxy().GetGameManager()->FindGameActorById(mVehicle->GetUniqueId());

		//	if ( gap )
		//	{
		//		static dtCore::Transform objectTransform;
		//		static osg::Vec3 objectPosition;
		//		GetTransform(objectTransform);
		//		objectTransform.GetTranslation(objectPosition);
		//		mHitPointCollision = objectPosition; 

		//		std::string actTypeName  = gap->GetActorType().GetName() ;
		//		if ( actTypeName == C_CN_SHIP ) 
		//		{
		//			ShipModelActor* target  = static_cast<ShipModelActor*>(gap->GetActor());
		//			if (target!= NULL) 
		//			{
		//				target->ShipHitByPosition(mHitPointCollision);

		//				std::cout<<GetName()<<" HIT Point ShipModelActor "<<std::endl;

		//				SendMessageToServer(target->GetVehicleID(),OrderID);
		//			}
		//		}
		//		else if ( actTypeName== C_CN_SUBMARINE )
		//		{
		//			SubMarineActor* target  = static_cast<SubMarineActor*>(gap->GetActor());
		//			if (target!= NULL) {

		//				//Eka added --> target rbu dan asroc bukan karena collision
		//				dtCore::Transform submarineTransform;
		//				osg::Vec3 submarinePosition;
		//				target->GetTransform(submarineTransform);
		//				submarineTransform.GetTranslation(submarinePosition);

		//				target->ShipHitByPosition(submarinePosition);


		//				//target->ShipHitByPosition(mHitPointCollision);
		//				std::cout<<GetName()<<" HIT Point SubMarineActor "<<std::endl;
		//				SendMessageToServer(target->GetVehicleID(),OrderID);
		//			}
		//		}
		//		else if (actTypeName == C_CN_HELICOPTER ) 
		//		{
		//			HelicopterActor* target  = static_cast<HelicopterActor*>(gap->GetActor());
		//			if (target!= NULL) {
		//				target->ShipHitByPosition(mHitPointCollision);

		//				std::cout<<GetName()<<" HIT Point HelicopterActor "<<std::endl;

		//				SendMessageToServer(target->GetVehicleID(),OrderID);
		//			}

		//		}
		//		else if (actTypeName == C_CN_AIRCRAFT) 
		//		{
		//			AircraftActor* target  = static_cast<AircraftActor*>(gap->GetActor());
		//			if (target!= NULL) {
		//				target->ShipHitByPosition(mHitPointCollision);

		//				std::cout<<GetName()<<" HIT Point AircraftActor "<<std::endl;

		//				SendMessageToServer(target->GetVehicleID(),OrderID);
		//			}

		//		}

		//	}

		//}
	}
}

void MissilesActor::SendExplode(const int ExplodeID, const int ExplodeType, const float ExplodeLife, const osg::Vec3 pos)
{
	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
	dtCore::RefPtr<MsgUtilityAndTools> mess;
	dtGame::MessageFactory* mf=&gm->GetMessageFactory();
	mf->CreateMessage(*(mf->GetMessageTypeByName(C_MT_UTILITY_AND_TOOLS)),mess);
	mess->SetOrderID(TIPE_UTIL_SPOUT_EXPLODE);
	mess->SetUAT0(mWeaponID);
	mess->SetUAT1(ExplodeID);
	mess->SetUAT2(ExplodeType);  
	mess->SetUAT3(pos.x());
	mess->SetUAT4(pos.y());
	mess->SetUAT5(pos.z());
	gm->SendNetworkMessage(*mess);
	gm->SendMessage(*mess);
}

void MissilesActor::UpdateStatusDBEffectTo2D( const dtCore::DeltaDrawable *mVehicle, int OrderID, int Lethality)
{
	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
	if ( gm->GetMachineInfo().GetName() == C_MACHINE_SERVER )
	{
		std::string sts ;
		if ( OrderID == ST_MISSILE_HIT ) sts ="Update Status : Hit ";
		if ( OrderID == ST_MISSILE_HIT ) {

			dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameActorProxy().GetGameManager()->FindGameActorById(mVehicle->GetUniqueId());

			if ( gap )
			{
				static dtCore::Transform objectTransform;
				static osg::Vec3 objectPosition;
				GetTransform(objectTransform);
				objectTransform.GetTranslation(objectPosition);
				mHitPointCollision = objectPosition;  //posisi missile

				std::string actTypeName  = gap->GetActorType().GetName() ;
				if ( actTypeName == C_CN_SHIP ) 
				{
					ShipModelActor* target  = static_cast<ShipModelActor*>(gap->GetActor());
					if (target!= NULL) 
					{
						target->ShipHitByPosition(mHitPointCollision,Lethality);

						std::cout<<GetName()<<" HIT Point ShipModelActor "<<std::endl;

						SendMessageToServer(target->GetVehicleID(),OrderID);
					}
				}
				else if ( actTypeName== C_CN_SUBMARINE )
				{
					SubMarineActor* target  = static_cast<SubMarineActor*>(gap->GetActor());
					if (target!= NULL) {

						//Eka added --> target rbu dan asroc bukan karena collision
						dtCore::Transform submarineTransform;
						osg::Vec3 submarinePosition;
						target->GetTransform(submarineTransform);
						submarineTransform.GetTranslation(submarinePosition);

						target->ShipHitByPosition(submarinePosition,Lethality);

						std::cout<<GetName()<<" HIT Point SubMarineActor "<<std::endl;
						SendMessageToServer(target->GetVehicleID(),OrderID);
					}
				}
				else if (actTypeName == C_CN_HELICOPTER ) 
				{
					HelicopterActor* target  = static_cast<HelicopterActor*>(gap->GetActor());
					if (target!= NULL) {
						target->ShipHitByPosition(mHitPointCollision,Lethality);

						std::cout<<GetName()<<" HIT Point HelicopterActor "<<std::endl;

						SendMessageToServer(target->GetVehicleID(),OrderID);
					}

				}
				else if (actTypeName == C_CN_AIRCRAFT) 
				{
					AircraftActor* target  = static_cast<AircraftActor*>(gap->GetActor());
					if (target!= NULL) {
						target->ShipHitByPosition(mHitPointCollision,Lethality);

						std::cout<<GetName()<<" HIT Point AircraftActor "<<std::endl;

						SendMessageToServer(target->GetVehicleID(),OrderID);
					}
				}
			}
		}
	}
}

void MissilesActor::SetPositionOnParent() 
{
	//std::cout << " SetPositionOnParent " << mVehicleID << std::endl;
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = NULL ;
	if ( isHasLauncher ){
		parentProxy = GetLauncherActors( C_WEAPON_TYPE_SPOUT , mVehicleID, mWeaponID, mLauncherID);
	}
	else 
	{
		parentProxy = GetShipActorByID(mVehicleID);
	}

	if ( parentProxy.valid() )
	{
		//std::cout << " done"<< std::endl;

		osg::Node *model =  parentProxy->GetActor()->GetOSGNode() ; 

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDofName);
		
		if (mDOFTran != NULL)
		{
			osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);

			dtCore::Transform CurrentPos ;
			CurrentPos.SetTranslation(vPos);

			if ( GetParent() != NULL )  
				GetParent()->RemoveChild(this);

			parentProxy->GetActor()->AddChild(this);

			SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
			GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
			CurrentPos.SetRotation(mPosInitHeading,mPosInitPitch,0.0f);
			SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

			std::cout<<" ::> "<<GetName()<<" attach at "<<parentProxy->GetActor()->GetName()<<std::endl;
			//std::cout<<" && position :: "<<CurrentPos.GetTranslation()<<"  rotation :: "<<CurrentPos.GetRotation()<<std::endl;

		} 
		else { 
			std::cout<<GetName()<<" can not find "<<mDofName<<" on :: ";
			std::cout<<"	!! "<<parentProxy->GetActor()->GetName()<<std::endl;
		}

	} else std::cout<<"	!!! "<<GetName()<<" can not find parent ship with id :: "<< mVehicleID <<std::endl;

}

void MissilesActor::OnEnteredWorld()
{
	BaseWeaponActor::OnEnteredWorld();
	SetPositionOnParent();
}

void MissilesActor::OnRemovedFromWorld()
{
	//FreeSound(missileSound.get());
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}

float MissilesActor::GetDistanceCone(osg::Vec3 point1, osg::Vec3 point2){
	return (float)sqrt(pow(point1.x()-point2.x(),2)+pow(point1.y()-point2.y(),2)+pow(point1.z()-point2.z(),2));
}

float MissilesActor::GetDistance(osg::Vec3 point1, osg::Vec3 point2){
	return sqrtf(osg::square(point1.x()-point2.x())+osg::square(point1.y()-point2.y()));
}

float MissilesActor::GetPitch(osg::Vec3 point1, osg::Vec3 point2){
	dtCore::Transform trans;
	trans.Set(point1, point2, osg::Vec3(0.f,0.f,1.f));
	osg::Vec3 rotation;
	trans.GetRotation(rotation);
	return rotation.y();
}

bool MissilesActor::IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius){
	float jarak = GetDistance(origin, pointToTest);

	if(GetDistanceCone(origin, pointToTest)<=distanceToTarget){
		//Setting Target Location
		osg::Vec3 target(origin);
		target.x() += (distanceToTarget*sin(-heading*3.14/180))*cos(pitch*3.14/180);
		target.y() += (distanceToTarget*cos(-heading*3.14/180))*cos(pitch*3.14/180);
		target.z() += distanceToTarget*sin(pitch*3.14/180);

		//Getting Tempdir
		osg::Vec3 tempDir(pointToTest - origin);
		tempDir.normalize();

		//Getting coneDir
		osg::Vec3 coneDir(target-origin);
		coneDir.normalize();

		float result(coneDir * tempDir);
		//getting alpha
		float alpha(atan(coneRadius/distanceToTarget));
		float cosResult(cos(alpha));
		return result >= cosResult;
	}
	return false;
}

//void MissilesActor::UpdateStatusDBEffectTo2D(const dtCore::UniqueId& uniqueId, int OrderID)
//{
//	dtGame::GameManager* gm= GetGameActorProxy().GetGameManager();
//	if ( gm->GetMachineInfo().GetName() == C_MACHINE_SERVER )
//	{
//		std::string sts ;
//		if ( OrderID == ST_MISSILE_RUN ) sts ="Update Status : Running ";
//		else if ( OrderID == ST_MISSILE_HIT ) sts ="Update Status : Hit ";
//		else if ( OrderID == ST_MISSILE_DEL ) sts ="Update Status : Shutdown ";
//
//		if ( OrderID == ST_MISSILE_HIT ) {
//
//			dtCore::RefPtr<dtGame::GameActorProxy> gap = GetGameActorProxy().GetGameManager()->FindGameActorById(uniqueId);
//
//			if ( gap )
//			{
//				static dtCore::Transform objectTransform;
//				static osg::Vec3 objectPosition;
//				GetTransform(objectTransform);
//				objectTransform.GetTranslation(objectPosition);
//				mHitPointCollision = objectPosition; 
//
//				std::string actTypeName  = gap->GetActorType().GetName() ;
//				if ( actTypeName == C_CN_SHIP ) 
//				{
//					ShipModelActor* target  = static_cast<ShipModelActor*>(gap->GetActor());
//					if (target!= NULL) {
//						target->ShipHitByPosition(mHitPointCollision,0);
//
//						std::cout<<GetName()<<" HIT Point ShipModelActor "<<std::endl;
//
//						SendMessageToServer(target->GetVehicleID(),OrderID);
//					}
//				}
//				else if ( actTypeName== C_CN_SUBMARINE )
//				{
//					SubMarineActor* target  = static_cast<SubMarineActor*>(gap->GetActor());
//					if (target!= NULL) {
//						target->ShipHitByPosition(mHitPointCollision,0);
//
//						std::cout<<GetName()<<" HIT Point SubMarineActor "<<std::endl;
//
//						SendMessageToServer(target->GetVehicleID(),OrderID);
//					}
//				}
//				else if (actTypeName == C_CN_HELICOPTER ) 
//				{
//					HelicopterActor* target  = static_cast<HelicopterActor*>(gap->GetActor());
//					if (target!= NULL) {
//						target->ShipHitByPosition(mHitPointCollision,0);
//
//						std::cout<<GetName()<<" HIT Point HelicopterActor "<<std::endl;
//
//						SendMessageToServer(target->GetVehicleID(),OrderID);
//					}
//
//				}
//
//			}
//
//		}
//		else  if (  OrderID == ST_MISSILE_RUN  || OrderID == ST_MISSILE_DEL )  
//		{
//			ShipModelActor* ShipAct  = static_cast<ShipModelActor*>(mMyParent.get());
//			if (ShipAct!= NULL)
//			{
//				ShipAct->ShipHitByPosition(mHitPointCollision,0);
//				SendMessageToServer(ShipAct->GetVehicleID(),OrderID);
//			}
//		}
//
//		std::cout<<GetName()<<" "<<sts<<" to 2D"<<std::endl;
//	}
//
//}
//
//
