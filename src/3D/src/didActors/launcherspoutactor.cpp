
#include "launcherspoutactor.h"
#include "didactorssources.h"

///////////////////////////////////////////////////////////////////////////////
LauncherSpoutActorProxy::LauncherSpoutActorProxy()
{

}

LauncherSpoutActorProxy::~LauncherSpoutActorProxy()
{

}


///////////////////////////////////////////////////////////////////////////////
void LauncherSpoutActorProxy::BuildPropertyMap()
{

	BaseWeaponActorProxy::BuildPropertyMap();

	/*LauncherSpoutActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::IntActorProperty(C_SET_MID, C_SET_MID, 
		dtDAL::IntActorProperty::SetFuncType(actor, &LauncherSpoutActor::SetMissileID), 
		dtDAL::IntActorProperty::GetFuncType(actor, &LauncherSpoutActor::GetMissileID),
		"Sets/gets Missile Id", C_TYPE_MISSILE)); */

}

void LauncherSpoutActorProxy::BuildInvokables()
{
    BaseWeaponActorProxy::BuildInvokables();
}

void LauncherSpoutActorProxy::OnEnteredWorld()
{
	BaseWeaponActorProxy::OnEnteredWorld();
}

///////////////////////////////////////////////////////////////////////////////
 
LauncherSpoutActor::LauncherSpoutActor(dtGame::GameActorProxy& proxy)
                : BaseWeaponActor(proxy) 
{

}

LauncherSpoutActor::~LauncherSpoutActor()
{

}


void LauncherSpoutActor::SetPositionOnParent() 
{
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetLauncherActors( C_WEAPON_TYPE_BODY , mVehicleID, mWeaponID, mLauncherID);

	if ( parentProxy.valid() && parentProxy->GetActor() != NULL)
	{
		osg::Node *model =  parentProxy->GetActor()->GetOSGNode() ; 

		dtCore::RefPtr<dtUtil::NodeCollector> mtColector = new dtUtil::NodeCollector(model, dtUtil::NodeCollector::DOFTransformFlag);
		dtCore::RefPtr<osgSim::DOFTransform> mDOFTran = mtColector->GetDOFTransform(mDofName);

		model = NULL;
		free(model);

		if (mDOFTran != NULL)
		{
			osg::Vec3 vPos = GetDOFPositionAbsolute(mDOFTran);

			dtCore::Transform CurrentPos ;
			CurrentPos.SetTranslation(vPos);

			if ( GetParent() != NULL )  
				GetParent()->RemoveChild(this);

			if (parentProxy->GetActor() != NULL)
				parentProxy->GetActor()->AddChild(this);

			SetTransform(CurrentPos,dtCore::Transformable::ABS_CS);
			GetTransform(CurrentPos,dtCore::Transformable::REL_CS);
			CurrentPos.SetRotation(0.0f,0.0f,0.0f);
			SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

			std::cout<<" :> "<<GetName()<<" attach at "<<parentProxy->GetActor()->GetName()<<std::endl;

			//std::cout<<GetName()<<" attach at "<<parentProxy->GetActor()->GetName()<<
			//	" position :: "<<CurrentPos.GetTranslation()<<
			//	" rotation :: "<<CurrentPos.GetRotation()<<std::endl;


		} else { 
			std::cout<<GetName()<<" can not find "<<mDofName<<" on :: ";
			std::cout<<"	!! "<<parentProxy->GetActor()->GetName()<<std::endl;
		}


	} else std::cout<<"	!!! "<<GetName()<<" can not find parent ship with id :: "<< mVehicleID <<std::endl;

}

void LauncherSpoutActor::OnEnteredWorld()
{
	BaseWeaponActor::OnEnteredWorld();
	SetPositionOnParent();
}

void LauncherSpoutActor::OnRemovedFromWorld()
{
	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));

}

bool LauncherSpoutActor::IsInCone(osg::Vec3 origin, osg::Vec3 pointToTest, float heading, float pitch, float distanceToTarget, float coneRadius){
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

float LauncherSpoutActor::GetDistanceCone(osg::Vec3 point1, osg::Vec3 point2){
	return (float)sqrt(pow(point1.x()-point2.x(),2)+pow(point1.y()-point2.y(),2)+pow(point1.z()-point2.z(),2));
}

float LauncherSpoutActor::GetDistance(osg::Vec3 point1, osg::Vec3 point2){
	return sqrtf(osg::square(point1.x()-point2.x())+osg::square(point1.y()-point2.y()));
}
