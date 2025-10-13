
#include "launcherbodyactor.h"
#include "didactorssources.h"
#include "shipmodelactor.h"



///////////////////////////////////////////////////////////////////////////////
LauncherBodyActorProxy::LauncherBodyActorProxy()
{

}

LauncherBodyActorProxy::~LauncherBodyActorProxy()
{

}


///////////////////////////////////////////////////////////////////////////////
void LauncherBodyActorProxy::BuildPropertyMap()
{

	BaseWeaponActorProxy::BuildPropertyMap();

	LauncherBodyActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::StringActorProperty(C_SET_INIT_SWITCHNAME,C_SET_INIT_SWITCHNAME,
		dtDAL::StringActorProperty::SetFuncType(actor,&LauncherBodyActor::SetSwitchName),
		dtDAL::StringActorProperty::GetFuncType(actor,&LauncherBodyActor::GetSwitchName),
		"set switch on parent ship models",C_TYPE_MISSILE ));

}

void LauncherBodyActorProxy::BuildInvokables()
{
    BaseWeaponActorProxy::BuildInvokables();
}

void LauncherBodyActorProxy::OnEnteredWorld()
{
	BaseWeaponActorProxy::OnEnteredWorld();
}

void LauncherBodyActorProxy::OnRemovedFromWorld()
{
	BaseWeaponActorProxy::OnRemovedFromWorld();
}

///////////////////////////////////////////////////////////////////////////////
 
LauncherBodyActor::LauncherBodyActor(dtGame::GameActorProxy& proxy)
                : BaseWeaponActor(proxy) 
{

}

LauncherBodyActor::~LauncherBodyActor()
{

}

void LauncherBodyActor::SetSwitchName ( const std::string &name)
{ 
	mSwitchName = name;
}

std::string LauncherBodyActor::GetSwitchName() const 
{ 
	return mSwitchName; 
}

int LauncherBodyActor::GetIndexSwitchWeaponParents() 
{
	int idx = -1 ;

	if ( mSwitchName ==  C_SwitchMeriam120    )	idx = 0 ;	
	if ( mSwitchName ==  C_SwitchMeriam76	  )	idx = 1 ;
	if ( mSwitchName ==  C_SwitchMeriam57	  )	idx = 2 ;
	if ( mSwitchName ==  C_SwitchMeriam40_1	  ) idx = 3 ;
	if ( mSwitchName ==  C_SwitchMeriam40_2	  ) idx = 4 ;
	if ( mSwitchName ==  C_SwitchMeriam40_3	  ) idx = 5 ;
	if ( mSwitchName ==  C_SwitchAsroc		  ) idx = 6 ;	 
	if ( mSwitchName ==  C_SwitchRBU6000_1	  )	idx = 7 ;
	if ( mSwitchName ==  C_SwitchRBU6000_2	  )	idx = 8 ;
	if ( mSwitchName ==  C_SwitchStrela_1	  )	idx = 9 ;
	if ( mSwitchName ==  C_SwitchStrela_2	  )	idx = 10 ;
	if ( mSwitchName ==  C_SwitchTetral_1	  )	idx = 11 ;
	if ( mSwitchName ==  C_SwitchTetral_2	  )	idx = 12 ;
	if ( mSwitchName ==  C_SwitchMistral_1	  )	idx = 13 ;
	if ( mSwitchName ==  C_SwitchMistral_2	  )	idx = 14 ; 

	return idx ;

}

void LauncherBodyActor::SetPositionOnParent() 
{
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(mVehicleID);
	if ( parentProxy.valid() && parentProxy->GetActor() != NULL)
	{
		osg::Node *model = parentProxy->GetActor()->GetOSGNode();

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
			CurrentPos.SetRotation(mPosInitHeading,mPosInitPitch,0.0f);
			SetTransform(CurrentPos,dtCore::Transformable::REL_CS);

			std::cout<<" :> "<<GetName()<<" attach at "<<parentProxy->GetActor()->GetName()<<std::endl;

			ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
			if (shp!= NULL) {
				shp->SetSwitchWeaponOFF(GetIndexSwitchWeaponParents(), false);
				shp->GetGameActorProxy().NotifyFullActorUpdate();
			}
			shp = NULL;
			free(shp);

		} else { 
			std::cout<<GetName()<<" can not find "<<mDofName<<" on :: ";
			std::cout<<"	!! "<<parentProxy->GetActor()->GetName()<<std::endl;
		}

	} else std::cout<<"		!!! "<<GetName()<<" can not find parent ship with id :: "<< mVehicleID <<std::endl;

}
 
void LauncherBodyActor::OnEnteredWorld()
{
	BaseWeaponActor::OnEnteredWorld();
	SetPositionOnParent();
}

void LauncherBodyActor::OnRemovedFromWorld()
{
	/*dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(mVehicleID);
	ShipModelActor* shp  = static_cast<ShipModelActor*>(parentProxy->GetActor());
	if (shp!= NULL) {
		shp->SetSwitchWeaponOFF(GetIndexSwitchWeaponParents(), true); //launcher 1
		shp->GetGameActorProxy().NotifyFullActorUpdate();
	}*/

	RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}


