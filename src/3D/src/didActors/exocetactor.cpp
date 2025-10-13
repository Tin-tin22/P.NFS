#include "exocetactor.h"
#include "ShipModelActor.h"

#include "didactorssources.h"

///////////////////////////////////////////////////////////////////////////////
//const std::string ExocetActor::EVENT_HANDLER_NAME("HandleGameEvent");

///////////////////////////////////////////////////////////////////////////////
ExocetActor::ExocetActor(dtGame::GameActorProxy &proxy) : 
   MissilesActor(proxy),
	   TargetFired(false),
	   mBlast(false),
	   afterBlast(false),
	   flat(false),
	   mSmoke(false),
	   isFirst(true),stop(true),
	   mBearing(0),
	   elevation(0),
	   tempTime(0),
	   timeDel(0),
	   ExcRange(0),
	   tRange(0),
	   mTimeToBlow(0.0f),
	   findTarget(false)
{
  isSoundEngineEnabled = false;
  engineSound = NULL;
}

ExocetActor::~ExocetActor()
{
	
}

void ExocetActor::SetSoundEngineFile(const char* fname)
{
	assert( fname );
	if (engineSound != NULL){
		//std::cout << "Free sound \n";
		engineSound->Stop();
		dtAudio::AudioManager::GetInstance().FreeSound( *&engineSound );
		engineSound = NULL;
	}
	engineSound = dtAudio::AudioManager::GetInstance().NewSound();
	engineSound->LoadFile( fname );
	AddChild(engineSound);
	engineSound->SetLooping(true);
	engineSound->SetGain( 1.0f );
	engineSound->SetPitch( 1.0f);
	engineSound->SetRolloffFactor( 10.0f );
	dtCore::Transform transform( 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f );
	engineSound->SetTransform( transform, Transformable::REL_CS );
}

void ExocetActor::SetSoundEngine(bool val)
{
	SetSoundEngineFile("Missile.wav");
	if (isSoundEngineEnabled != val){
		isSoundEngineEnabled = val;

		if (!(engineSound == NULL)) 
		{
			engineSound->Play();
		}
	}
}
///////////////////////////////////////////////////////////////////////////////

void ExocetActor::TickLocal(const dtGame::Message &tickMessage)
{

  const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);    

  if( mSmokeStatus == true){
	   if ( mSmoke->IsEnabled()){}
	   else mSmoke->SetEnabled(true);
  }

  if(isLaunch == true)
  {
	//profile
	tempTime+= tick.GetDeltaSimTime();
	//if (tempTime <= 1.0f) 
	  //Step1();
	//else 
	  //Step2();

	dtCore::RefPtr<dtDAL::ActorProxy> proxy= CeckCollision(trac.GetSpeed()* DEF_MACH_TO_METRE, tick.GetDeltaSimTime());
	if ( proxy != NULL )
	{
	  UpdateStatusDBEffectTo2D(proxy->GetActor(),ST_MISSILE_HIT); 
	  assert(engineSound);
	  if (!(engineSound == NULL)) 
	  {
		  engineSound->Stop();
		  SetSoundEngineFile("ledakan.wav");
		  engineSound->SetLooping(false);
		  engineSound->Play();
		  std::cout<<"Hit Sound Activated"<<std::endl;
	  }
	  mBlast= true;
    }
    else{
		Move(tick.GetDeltaSimTime());
  	  
		if (ExcRange >= (31 * c_NauticalMiles_To_Meter )) //(exocet sudah sampai di target ato sudah melebihi 31 NM)
	    {
			isLaunch = false;
			SetHasTarget(false);
    		EndOfExocet();
	    }
	}

	if ( proxy != NULL )
    {
		if (mBlast== true)
		{
		  isLaunch = false;
		  ExcBlast(proxy.get());
		}
	}
    
  }// end if isLaunch
}

///////////////////////////////////////////////////////////////////////////////
void ExocetActor::TickRemote(const dtGame::Message &tickMessage)
{
   const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(tickMessage);
}

///////////////////////////////////////////////////////////////////////////////

void ExocetActor::ProcessOrderEvent(const dtGame::Message &message)
{
	const MsgSetExocet &Msg = static_cast<const MsgSetExocet&>(message);
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(Msg.GetVehicleID());
	if ( parentProxy.valid() )
	{
		dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
		if (Msg.GetVehicleID() == parent->GetVehicleID())
		{

		
			switch (Msg.GetOrderID())
			{
				case ORD_EXOCET_FIRE : 
				if ( (int)Msg.GetMissileID()  == mMissileID )
				{
					SetProximityFuze(Msg.GetProxFuze()); 
					SetAltitude(Msg.GetAltitude()); 
					SetSearchArea(Msg.GetSearchArea()); 
					SetRangeToGo(Msg.GetRangeToGo()); 
					SetManualWidth(Msg.GetManualWidth()); 
					SetSelectionDepth(Msg.GetSelecDepth());
					SetTargetBearing(Msg.GetTargetBearing());
					e_bearing = Msg.GetTargetBearing();
					SetTargetRange(Msg.GetTargetRange()); 
					
					mSmokeStatus = true;
					isLaunch = true;
					mMyParent= parent;
					
					dtCore::Transform t;
					GetTransform(t);
					
					if ( GetParent() != NULL ) 
						GetParent()->RemoveChild(this);

					std::vector<dtDAL::ActorProxy *> ap;
					GetGameActorProxy().GetGameManager()->FindActorsByName(C_CN_OCEAN, ap);
					if (ap[0]!= NULL) //Environment hanya ada satu, belum support multiple environment
					{
						static_cast<dtGame::IEnvGameActor*>( ap[0]->GetActor() )->AddActor( *(this) );
					}
					else
						std::cout<<"Environment actor is missing!"<<std::endl;
					
					
					SetTransform(t);
					SetSoundEngine(true);
					UpdateStatusDBEffectTo2D(mMyParent.get(),ST_MISSILE_RUN);
				 }
				break;
			}
		}
	}
}

void ExocetActor::ProcessMessage(const dtGame::Message &message)
{
	if(GetGameActorProxy().IsInGM()){
		if(message.GetMessageType().GetName() == SimMessageType::EXOCET_EVENT.GetName())
		{
			ProcessOrderEvent(message);
		}
	}
}

void ExocetActor::SetProximityFuze(int pf)
{
	/* 0 : Proximity ON
	   1 : Proximity OFF */
	mPF = pf;
}
void ExocetActor::SetAltitude(int alt)
{
	/* dalam meter*/
	if(alt == 0)		// LOW
		mAlt = 2.2;
	else if(alt == 1)	// MEDIUM
		mAlt = 4.2;
	else if(alt == 2)	// HIGH
		mAlt = 7;	
	
}
void ExocetActor::SetSearchArea(int sa)
{
	mSA = sa;
}
void ExocetActor::SetTargetBearing(float bearing)
{
	//mBearing = bearing;  //----->asli
	dtCore::Transform xform;
	GetTransform(xform);
	//osg::Vec3f right, up, forward;
	//xform.GetOrientation(right, up, forward);
	osg::Vec3f rot = xform.GetRotation();	
	float shipBearing = rot.z();
	mBearing = bearing + shipBearing+90; 
}
void ExocetActor::SetTargetRange(float targetRange)
{
	mTargetRange = targetRange * c_NauticalMiles_To_Meter ;
	tRange = mTargetRange;
}
void ExocetActor::SetRangeToGo(int rtg)
{
	/* dalam meter*/
	if (rtg == 0)		// LOW
		mRTG = 5000;
	else if (rtg == 1)	// MEDIUM
		mRTG = 8000;
	else if (rtg == 2)	// HIGH
		mRTG = 12000;
}
void ExocetActor::SetManualWidth(int mw)
{
	/* derajat */
	if (mw == 0)		// LOW
		mMW = 2.5f;		
	else if (mw == 1)	// MEDIUM
		mMW = 6.25f;	
	else if (mw == 2)	// HIGH
		mMW = 10.0f;	

}
void ExocetActor::SetSelectionDepth(int sd)
{
	/* meter */
	if (sd == 0)		// LOW
		mSD = 750.0f;
	else if (sd == 1)	// MED
		mSD = 1812.5f;
	else if (sd == 2)	// HIGH
		mSD = 2500.0f;
}

float ExocetActor::SelBearing(float b1, float b2)
{
	float c1,c2;
	c1 = b1 - b2;
	c2 = b2 - b1;
	if (c1 < 0.0f) c1 = c1 + 360.0f;
	if (c2 < 0.0f) c2 = c2 + 360.0f;

	if (c1 < c2) return c1;
	else return c2;
}

void ExocetActor::Move(double deltaSimTime)
{
	/*static dtCore::Transform trans;
	static osg::Vec3 exoPos, dir, rot, missileFirstPos;
	static float turnElevation,turnElevation2,turnRate1,turnRate2;
	static bool stop = true;
	static float temp_bearing;*/

	GetTransform(trans);
	trans.GetTranslation(exoPos);

	if (isFirst==true){		
		missileFirstPos=exoPos;
		Step1();
		temp_bearing = trac.GetDirection();
		isFirst = false;
	}

	
	trac.Calc_Speed(deltaSimTime);
	trac.Calc_Direction(deltaSimTime);
	dir = trac.Calc_Movement(deltaSimTime);

	ExcRange = GetDistance(exoPos,missileFirstPos);

		exoPos.x() += dir.x();
		exoPos.y() += dir.y();
		exoPos.z() += dir.z();

	//printf("Range = %f\n",ExcRange);

	if (ExcRange > 750.0f){
		if (stop==true){
			turnElevation = turnElevation + 1;
			trac.SetElevation(30.0f-turnElevation);
			if (trac.GetElevation() <= -30.0f){trac.SetElevation(-30.0f);}
			//printf("Elevasi = %f\n",trac.GetElevation());
		}
	}
	//if (ExcRange > 2000){EndOfExocet();}

	
	if (exoPos.z() < GetAltitude()) {
		stop=false;
		exoPos.z() = GetAltitude();
		turnElevation2 = turnElevation2 + 1;
		trac.SetElevation(-30.0f+turnElevation2);
		if (trac.GetElevation() >= 0.0f){trac.SetElevation(0.0f);}
	}

	//printf("z= %f\n",exoPos.z());
	if (exoPos.z() < 0.0f){
		printf("FATAL Z\n");
		EndOfExocet();
	}

	trans.SetTranslation(exoPos);

	trans.GetRotation(rot);
	rot[0] = -trac.GetDirection();
	rot[1] = trac.GetElevation();
	rot[2] = 0.0f;
	trans.SetRotation(rot); 

	SetCurrentSpeed(trac.GetSpeed());
	SetCurrentHeading(trac.GetDirection());
	CSetTranslation(trans.GetTranslation());
	CSetRotation(trans.GetRotation());

	SetTransform(trans);

	if (ExcRange >= 3000.0f){
		if (temp_bearing > e_bearing)
		{
			turnRate1 = turnRate1 - 1;
			if (trac.GetDirection()<e_bearing)
				trac.SetTurnRate(0.0f);
			else{
				trac.SetTurnRate(turnRate1);
			}
		}
		else{
			turnRate1 = turnRate1 + 1;
			if (trac.GetDirection()>e_bearing)
				trac.SetTurnRate(0.0f);
			else{
				trac.SetTurnRate(turnRate1);
			}
		}
		
	}

	
	
 
	/*if(ExcRange >= GetRangeToGo()){
	  if ( ! ( findTarget 	))DetectTarget();
	}*/
}

float ExocetActor::GetDistance(osg::Vec3 point1, osg::Vec3 point2){
	return sqrtf(osg::square(point1.x()-point2.x())+osg::square(point1.y()-point2.y()));
}



inline double InitMissileDir(int iCount, double sh)
{
	double dir;
	if ((iCount % 2) == 0)	//kiri
		dir =  sh ; //- 60.0;
	else					// kanan
		dir = sh ; //+ 60.0;

	ValidateDegree(dir);
	return dir;

};

void ExocetActor::Step1()
{
	float ShipNalaHeading;
	dtCore::RefPtr<dtDAL::ActorProxy> parentProxy = GetShipActorByID(GetVehicleID());
	if ( parentProxy.valid() )
	{
		static dtCore::Transform objectTransform;
		static osg::Vec3 objectPosition;
		static osg::Vec3 objectRotation;
		dtCore::RefPtr<ShipActor> parent = static_cast<ShipActor*>(parentProxy->GetActor());
		mMyParent = parent;
		dtGame::GameActorProxy &pr = parent->GetGameActorProxy();
		parent->GetTransform(objectTransform);
		objectTransform.GetTranslation(objectPosition);
		objectTransform.GetRotation(objectRotation);
		ShipNalaHeading = objectRotation.x();
		printf("heading nala = %f\n",ShipNalaHeading);
	}

	if ((mMissileID== 1) || (mMissileID==3))
		//trac.SetDirection(90.0f);
		trac.SetDirection(90.0f-ShipNalaHeading);
	else if ((mMissileID== 2) || (mMissileID==4))
		//trac.SetDirection(270.0f);
		trac.SetDirection(270-ShipNalaHeading);
	trac.SetElevation(30.0f);
}

void ExocetActor::Step2()
{
	float b,bearing;

	dtCore::Transform trans;
	osg::Vec3 exoPos;
	GetTransform(trans);
	trans.GetTranslation(exoPos);

	bearing = GetTargetBearing();//ConvCompass_To_Cartesian(mBearing);
	b = trac.GetDirection();
	/*if (floor(b) > floor(bearing)){
		trac.SetTurnRate(-20.0f);		
	}
	else if (floor(b) == floor(bearing)) trac.SetDirection(bearing);
	else{
		trac.SetTurnRate(20.0f);
	}*/
	
	//elevasi turun perlahan2
	elevation = trac.GetElevation();
	if (exoPos.z() >= 7.0f) elevation -= 0.5f;
	else {
		elevation =0.0f;
		exoPos.z() = 7.0f;
	}
	trac.SetElevation(elevation);

	trans.SetTranslation(exoPos);
	GetTransform(trans);

	//if(ExcRange>= GetRangeToGo())

}

void ExocetActor::EndOfExocet()
{
	if (!(engineSound == NULL)) 
	{
		dtAudio::AudioManager::GetInstance().FreeSound( *&engineSound );
		std::cout << GetName()<<" "<< mMissileID << " End. "<< GetGameActorProxy().GetTranslation() << " Exocet sound Free. "<<std::endl ; 
	}
	else
		std::cout << GetName()<<" "<< mMissileID << " End. "<< GetGameActorProxy().GetTranslation() << std::endl ; 
	UpdateStatusDBEffectTo2D(mMyParent, ST_MISSILE_DEL);
}

void ExocetActor::ExcBlast(dtDAL::ActorProxy* p)
{
	mSmoke ->SetEnabled(false);
	dtCore::Transform tx;
	//tx.SetTranslation(mExplosionPos);
	//GetTransform(tx);
	dtCore::RefPtr<dtCore::ParticleSystem> mExplosion= new dtCore::ParticleSystem();
	mExplosion->LoadFile(C_PARTICLES_EXPLODE,true);
	p->GetActor()->AddChild(mExplosion.get());
	mExplosion->SetTransform(tx);
	mExplosion->SetEnabled(true);
	
	EndOfExocet();
}

void ExocetActor::SetCurrentSpeed(float val){
	CurrentSpeed = val ;
}


///////////////////////////////////////////////////////////////////////////////
void ExocetActor::CSetRotation(const osg::Vec3& v3)
{
	dtCore::Transform trans;
	GetTransform(trans,ABS_CS);
	trans.SetRotation(v3);
	SetTransform(trans,ABS_CS);
	//std::cout<<"Set Rotation : "<<trans.GetRotation()<<std::endl;
}

///////////////////////////////////////////////////////////////////////////////
osg::Vec3 ExocetActor::CGetRotation()
{
	osg::Vec3 v3;
	dtCore::Transform trans;
	GetTransform(trans,ABS_CS);
	trans.GetRotation(v3);
	return v3;
}

///////////////////////////////////////////////////////////////////////////////
void ExocetActor::CSetTranslation(const osg::Vec3& v3)
{
	dtCore::Transform trans;
	GetTransform(trans,ABS_CS);
	trans.SetTranslation(v3);
	SetTransform(trans,ABS_CS);
}

///////////////////////////////////////////////////////////////////////////////
osg::Vec3 ExocetActor::CGetTranslation()
{
	osg::Vec3 v3;
	dtCore::Transform trans;
	GetTransform(trans,ABS_CS);
	trans.GetTranslation(v3);
	return v3;
}

void ExocetActor::OnEnteredWorld()
{
	MissilesActor::OnEnteredWorld();

	trac.SetElevation(30.0f);
	trac.SetSpeed(0.9f);
	//trac.SetSpeed(1.0f/DEF_MACH_TO_METRE);

	mSmoke = new dtCore::ParticleSystem();
	mSmoke->LoadFile(C_PARTICLES_MISSILE,true);
	mSmoke->SetEnabled(false);
	GetGameActorProxy().GetActor()->AddChild(mSmoke.get());

}

void ExocetActor::OnRemovedFromWorld()
{
	std::cout<<GetName()<<" Remove from the world"<<std::endl;
    RemoveSender(&(GetGameActorProxy().GetGameManager()->GetScene()));
}


///////////////////////////////////////////////////////////////////////////////

ExocetActorProxy::ExocetActorProxy()
{

}

///////////////////////////////////////////////////////////////////////////////
void ExocetActorProxy::BuildPropertyMap()
{
	MissilesActorProxy::BuildPropertyMap();

	ExocetActor* actor = NULL;
	GetActor(actor);

	AddProperty(new dtDAL::FloatActorProperty(C_SET_SPEED,C_SET_SPEED,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetCurrentSpeed),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetCurrentSpeed), "Sets/gets speed.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty(C_SET_HEADING,C_SET_HEADING,
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetCurrentHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetCurrentHeading), "Sets/gets Heading.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("SoundEngine","SoundEngine",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetSoundEngine),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetSoundEngine), 
		"SoundEngine." , C_TYPE_MISSILE));

	//////////////////////////////////////////////////////////////////////
	AddProperty(new dtDAL::IntActorProperty("ProximityFuze", "ProximityFuze", 
		dtDAL::IntActorProperty::SetFuncType(actor, &ExocetActor::SetProximityFuze), 
		dtDAL::IntActorProperty::GetFuncType(actor, &ExocetActor::GetProximityFuze),
		"ProximityFuze", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty("SearchArea", "SearchArea", 
		dtDAL::IntActorProperty::SetFuncType(actor, &ExocetActor::SetSearchArea), 
		dtDAL::IntActorProperty::GetFuncType(actor, &ExocetActor::GetSearchArea),
		"SearchArea", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Altitude","Altitude",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetAltitude),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetAltitude), 
		"Altitude.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("TargetRange","TargetRange",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetTargetRange),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetTargetRange), 
		"TargetRange.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Bearing","Bearing",
		dtDAL::FloatActorProperty::SetFuncType(actor,&ExocetActor::SetTargetBearing),
		dtDAL::FloatActorProperty::GetFuncType(actor,&ExocetActor::GetTargetBearing),
		"Target Bearing", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty("RangeToGo","RangeToGo",
		dtDAL::IntActorProperty::SetFuncType(actor, &ExocetActor::SetRangeToGo),
		dtDAL::IntActorProperty::GetFuncType(actor, &ExocetActor::GetRangeToGo), 
		"RangeToGo.", C_TYPE_MISSILE));

	AddProperty(new dtDAL::IntActorProperty("ManualWidth","ManualWidth",
		dtDAL::IntActorProperty::SetFuncType(actor, &ExocetActor::SetManualWidth),
		dtDAL::IntActorProperty::GetFuncType(actor, &ExocetActor::GetManualWidth), 
		"ManualWidth.", C_TYPE_MISSILE));   

	AddProperty(new dtDAL::IntActorProperty("SelectionDepth","SelectionDepth",
		dtDAL::IntActorProperty::SetFuncType(actor, &ExocetActor::SetSelectionDepth),
		dtDAL::IntActorProperty::GetFuncType(actor, &ExocetActor::GetSelectionDepth), 
		"SelectionDepth.", C_TYPE_MISSILE));  

	AddProperty(new dtDAL::BooleanActorProperty("TargetFired","TargetFired",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetTargetFired),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetTargetFired), 
		"TargetFired." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("MBlast","MBlast",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetMBlast),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetMBlast), 
		"MBlast." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("AfterBlast","AfterBlast",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetAfterBlast),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetAfterBlast), 
		"AfterBlast." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("Flat","Flat",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetFlat),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetFlat), 
		"Flat." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("Elevation","Elevation",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetElevation),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetElevation), 
		"Elevation." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("TempTime","TempTime",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetTempTime),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetTempTime), 
		"TempTime." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("ExcRange","ExcRange",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetExcRange),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetExcRange), 
		"ExcRange." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("TimeDel","TimeDel",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetTimeDel),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetTimeDel), 
		"TimeDel." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("tRange","tRange",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SettRange),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GettRange), 
		"tRange." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::FloatActorProperty("ShipHeading","ShipHeading",
		dtDAL::FloatActorProperty::SetFuncType(actor, &ExocetActor::SetShipHeading),
		dtDAL::FloatActorProperty::GetFuncType(actor, &ExocetActor::GetShipHeading), 
		"ShipHeading." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("SmokeStatus","SmokeStatus",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetSmokeStatus),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetSmokeStatus), 
		"AfterBlast." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::BooleanActorProperty("HasTarget","HasTarget",
		dtDAL::BooleanActorProperty::SetFuncType(actor, &ExocetActor::SetHasTarget),
		dtDAL::BooleanActorProperty::GetFuncType(actor, &ExocetActor::GetHasTarget), 
		"HasTarget." , C_TYPE_MISSILE));

	AddProperty(new dtDAL::ActorIDActorProperty(*this,"CurrentTargetID", "CurrentTargetID",
		dtDAL::ActorIDActorProperty::SetFuncType(actor, &ExocetActor::SetCurrentTargetId),
		dtDAL::ActorIDActorProperty::GetFuncType(actor, &ExocetActor::GetCurrentTargetId),
		"CurrentTargetID", C_TYPE_MISSILE));


	AddProperty(new dtDAL::Vec3ActorProperty("Model Rotation", "Model Rotation",
		dtDAL::Vec3ActorProperty::SetFuncType(actor, &ExocetActor::CSetRotation),
		dtDAL::Vec3ActorProperty::GetFuncType(actor, &ExocetActor::CGetRotation),
		"Specifies the Rotation of the object", C_TYPE_MISSILE));

	AddProperty(new dtDAL::Vec3ActorProperty("Model Translation", "Model Translation",
		dtDAL::Vec3ActorProperty::SetFuncType(actor, &ExocetActor::CSetTranslation),
		dtDAL::Vec3ActorProperty::GetFuncType(actor, &ExocetActor::CGetTranslation),
		"Specifies the Translation of the object", C_TYPE_MISSILE));

}

///////////////////////////////////////////////////////////////////////////////
void ExocetActorProxy::CreateActor()
{
   SetActor(*new ExocetActor(*this));
}

///////////////////////////////////////////////////////////////////////////////
void ExocetActorProxy::OnEnteredWorld()
{
	MissilesActorProxy::OnEnteredWorld();
	RegisterForMessages(SimMessageType::EXOCET_EVENT, dtGame::GameActorProxy::PROCESS_MSG_INVOKABLE);
}