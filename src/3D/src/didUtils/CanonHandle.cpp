#include "./CanonHandle.h"
#include "../didUtils/SimEnvironmentDB.h"
#include <iostream>

CanonData::CanonData()
{

}

CanonHandle::CanonHandle(void) : dtGame::GMComponent(C_COMP_ACTOR_CANON)
{
	enableProcessMessage = true;
}

CanonHandle::~CanonHandle(void)
{

}

bool CanonHandle::isInsideCircle(const int tgtX, int tgtY, int tgtZ, int refX, int refY, int refZ, float radius)
{
	float deltaX = tgtX - refX;
    float deltaY = tgtY - refY;
    float deltaZ = tgtZ - refZ; 
    float deltaR = sqrt(abs((deltaX*deltaX)+(deltaY*deltaY)+(deltaZ*deltaZ)));
    return(deltaR <= radius);
}

void CanonHandle::ProcessMessage(const dtGame::Message& Message)
{
	if (enableProcessMessage)
	{
		if (Message.GetMessageType().GetName() == SimMessageType::TICK_LOCAL.GetName())
		{
			const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(Message);
			float deltaSimTime = tick.GetDeltaSimTime();
			Move(deltaSimTime);
		}
		if(Message.GetMessageType().GetName() == SimMessageType::CANNON_EVENT.GetName())
		{
			AddNewCanonData(Message);
		}
	}
}

void CanonHandle::CleanUpDataCannon()
{
	for(std::vector<CanonData*>::iterator iter=mCanonData.begin(); 
		iter!=mCanonData.end(); iter++ )
	{
		if (!(*iter)->isEnable)
		{
			//Delete Data In Vector
		}
	}
}

void CanonHandle::Move(double aDt)
{
	if (mCanonData.size() > 0)
	{
		//std::cout << "CanonHandle" << std::endl;
		//Begin Calculate Moving Object
		for(std::vector<CanonData*>::iterator iter=mCanonData.begin(); 
		iter!=mCanonData.end(); iter++ )
		{
			if ((*iter)->isEnable)
			{
				(*iter)->LifeTime += aDt;
				
				if ((*iter)->LifeTime < 120.0f)
				{
					//Move Cannon 40/57
					if (((*iter)->mWeaponID == CT_CANNON_40) || 
					   ((*iter)->mWeaponID == CT_CANNON_57))
					{
						(*iter)->dir = (*iter)->trac.Calc_Movement_CannonProjectile_40_byElev((*iter)->LifeTime, 
																							  (*iter)->FirstLaunchPoint, 
																							  (*iter)->spoutElev, 
																							  (*iter)->V0X, 
																							  (*iter)->V0Y);

						(*iter)->WindEnviX = (*iter)->WindEnviX + GetWindDirX(); 
						(*iter)->WindEnviY = (*iter)->WindEnviY + GetWindDirY();
					}
					else
					//Move Cannon 76
					if ((*iter)->mWeaponID == CT_CANNON_76) 
					{
						if ((*iter)->mBalistikID == 0)
						{
							//Low Balistik
							(*iter)->dir = (*iter)->trac.Calc_Movement_CannonProjectile_76Low_byElev((*iter)->LifeTime, 
																									 (*iter)->FirstLaunchPoint, 
																									 (*iter)->spoutElev, 
																									 (*iter)->Gun_76_HeightMax, 
																									 (*iter)->Gun_76_TimeMax );
						}
						else
						{
							//High Balistik
							(*iter)->dir = (*iter)->trac.Calc_Movement_CannonProjectile_76High_byElev((*iter)->LifeTime, 
																									  (*iter)->FirstLaunchPoint, 
																									  (*iter)->spoutElev, 
																									  (*iter)->Gun_76_RangeMax, 
																									  (*iter)->Gun_76_HeightMax, 
																									  (*iter)->Gun_76_TimeMax, 
																									  (*iter)->Gun_76_Time);
						}

						(*iter)->WindEnviX = (*iter)->WindEnviX + GetWindDirX(); 
						(*iter)->WindEnviY = (*iter)->WindEnviY + GetWindDirY();
					}
					//Move Cannon 120
					else
					if ((*iter)->mWeaponID == CT_CANNON_120) 
					{
						(*iter)->dir = (*iter)->trac.Calc_Movement_CannonProjectile_120_byElev((*iter)->LifeTime, 
																							   (*iter)->FirstLaunchPoint, 
																							   (*iter)->spoutElev, 
																							   (*iter)->V0X, 
																							   (*iter)->V0Y);

						(*iter)->WindEnviX = (*iter)->WindEnviX + GetWindDirX(); 
						(*iter)->WindEnviY = (*iter)->WindEnviY + GetWindDirY();
					}

					(*iter)->dir.x() = (*iter)->dir.x() + (*iter)->WindEnviX;
					(*iter)->dir.y() = (*iter)->dir.y() + (*iter)->WindEnviY;

					//Check Collision Cannon With Every Vehicle @Game
					//If Collision Send Splash and Effect
					if ((*iter)->dir.z() < 0)
					{
						//Send Splash and Effect
						int refX, refY, refZ;
						refX = (*iter)->dir.x();
						refY = (*iter)->dir.y();
						refZ = (*iter)->dir.z();
						
						dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
						GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);
						MsgUtils->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
						MsgUtils->SetUAT0((*iter)->mWeaponID);		   
						MsgUtils->SetUAT1(refX);		
						MsgUtils->SetUAT2(refY);    
						//MsgUtils->SetUAT3(0);
						MsgUtils->SetUAT3( GetGameManager()->GetScene().GetHeightOfTerrain(refX, refY) );
						MsgUtils->SetUAT4(0);		
						MsgUtils->SetUAT5((*iter)->ShipID);		
						MsgUtils->SetUAT6((*iter)->mLauncherID);
						GetGameManager()->SendNetworkMessage(*MsgUtils);
						GetGameManager()->SendMessage(*MsgUtils);

						(*iter)->isEnable = false;
						std::cout << "Cannon Hit Ocean on " << 
							refX <<" "<< refY <<" "<< GetGameManager()->GetScene().GetHeightOfTerrain(refX, refY) << std::endl;
					}
					else
					{
						//Check Collision With Ground
						for(std::vector<NGSPos*>::iterator iterground=mNGSpos.begin(); 
							iterground!=mNGSpos.end(); iterground++ )
						{
							int tgtX, tgtY, tgtZ;
							int refX, refY, refZ;

							tgtX = (*iterground)->PosX;
							tgtY = (*iterground)->PosY;
							tgtZ = (*iterground)->PosZ;
							refX = (*iter)->dir.x();
							refY = (*iter)->dir.y();
							refZ = (*iter)->dir.z();

							if(isInsideCircle(tgtX, tgtY, tgtZ, refX, refY, refZ, 10))
							{
								//Send Splash and Effect
								dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
								GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);
								MsgUtils->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
								MsgUtils->SetUAT0((*iter)->mWeaponID);		   
								MsgUtils->SetUAT1(refX);		
								MsgUtils->SetUAT2(refY);    
								//MsgUtils->SetUAT3(refZ);
								MsgUtils->SetUAT3( GetGameManager()->GetScene().GetHeightOfTerrain(refX, refY) );
								MsgUtils->SetUAT4(0);		
								MsgUtils->SetUAT5((*iter)->ShipID);		
								MsgUtils->SetUAT6((*iter)->mLauncherID);
								GetGameManager()->SendNetworkMessage(*MsgUtils);
								GetGameManager()->SendMessage(*MsgUtils);

								(*iter)->isEnable = false;
								/*std::cout << "Collision With Ground in ID " << 
									(*iterground)->id << "@"<< (*iterground)->PosX<<"."<< (*iterground)->PosY <<"."<< (*iterground)->PosZ <<std::endl;*/
								std::cout << "Collision With Ground on " << 
									refX <<" "<< refY <<" "<< GetGameManager()->GetScene().GetHeightOfTerrain(refX, refY) <<std::endl;
							}
						}


						//Check Collision With Vehicle
						if (!(*iter)->isHitGround)
						{
							std::vector<dtGame::GameActorProxy *> fill;
							std::vector<dtGame::GameActorProxy *>::iterator tgtiter;
							GetGameManager()->GetAllGameActors(fill);
							for (tgtiter = fill.begin(); tgtiter < fill.end(); tgtiter++)
							{
								if (((*tgtiter)->GetActorType().GetName()== C_CN_SHIP ) || ((*tgtiter)->GetActorType().GetName()== C_CN_SUBMARINE )
									|| ((*tgtiter)->GetActorType().GetName()== C_CN_HELICOPTER )|| ((*tgtiter)->GetActorType().GetName()== C_CN_AIRCRAFT )) 
								{
									dtCore::RefPtr<dtDAL::ActorProperty> VehicleID( (*tgtiter)->GetProperty(C_SET_VID) );
									dtCore::RefPtr<dtDAL::IntActorProperty> ValID( static_cast<dtDAL::IntActorProperty*>( VehicleID.get() ) );
									int tgt( ValID->GetValue() );
									if ( tgt != (*iter)->ShipID )
									{
										dtCore::RefPtr<dtCore::DeltaDrawable> SearchShipTarget;
										SearchShipTarget = (*tgtiter)->GetActor() ;
										if ( SearchShipTarget != NULL )
										{
											dtCore::RefPtr<dtGame::GameActor> TargetAct = dynamic_cast<dtGame::GameActor*>(SearchShipTarget.get());
											if ( TargetAct != NULL )
											{
												int tgtX, tgtY, tgtZ;
												int refX, refY, refZ;
												
												static dtCore::Transform TargetTransform;
												static osg::Vec3 TargetPosition;
												TargetAct->GetTransform(TargetTransform);
												TargetTransform.GetTranslation(TargetPosition);

												tgtX = TargetPosition.x();
												tgtY = TargetPosition.y();
												tgtZ = TargetPosition.z();
												refX = (*iter)->dir.x();
												refY = (*iter)->dir.y();
												refZ = (*iter)->dir.z();

												if(isInsideCircle(tgtX, tgtY, tgtZ, refX, refY, refZ, 10))
												{
													//Send Splash and Effect
													dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
													GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);
													MsgUtils->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
													MsgUtils->SetUAT0((*iter)->mWeaponID);		   
													MsgUtils->SetUAT1(refX);		
													MsgUtils->SetUAT2(refY);    
													MsgUtils->SetUAT3(refZ);		
													MsgUtils->SetUAT4(0);		
													MsgUtils->SetUAT5((*iter)->ShipID);		
													MsgUtils->SetUAT6((*iter)->mLauncherID);
													GetGameManager()->SendNetworkMessage(*MsgUtils);
													GetGameManager()->SendMessage(*MsgUtils);

													(*iter)->isEnable = false;
													std::cout << "Collision With Target ID " << tgt << std::endl;
												}
											}
										}
									}
								}
							}
						}	
					}
				}
				else
				{
					//Send Splash and Effect
					int refX, refY, refZ;
					refX = (*iter)->dir.x();
					refY = (*iter)->dir.y();
					refZ = (*iter)->dir.z();
					
					dtCore::RefPtr<MsgUtilityAndTools> MsgUtils;
					GetGameManager()->GetMessageFactory().CreateMessage(SimMessageType::UTILITY_AND_TOOLS, MsgUtils);
					MsgUtils->SetOrderID(TIPE_UTIL_EVENT_EXPLODE);
					MsgUtils->SetUAT0((*iter)->mWeaponID);		   
					MsgUtils->SetUAT1(refX);		
					MsgUtils->SetUAT2(refY);    
					MsgUtils->SetUAT3(refZ);		
					MsgUtils->SetUAT4(0);		
					MsgUtils->SetUAT5((*iter)->ShipID);		
					MsgUtils->SetUAT6((*iter)->mLauncherID);
					GetGameManager()->SendNetworkMessage(*MsgUtils);
					GetGameManager()->SendMessage(*MsgUtils);

					(*iter)->isEnable = false;
					std::cout << "Cannon Timeout" << std::endl;
				}
			}
		}
	}
}

void CanonHandle::AddNewCanonData(const dtGame::Message& Message)
{
	const MsgSetCannon &Msg = static_cast<const MsgSetCannon&>(Message);
	int vid = (int) Msg.GetVehicleID();
	int wid = (int) Msg.GetWeaponID();
	int lid = (int) Msg.GetLauncherID();
	int mid = (int) Msg.GetMissileID();
	int mnum = (int) Msg.GetMissileNum();
	int oid = (int) Msg.GetOrderID();
	int tid = (int) Msg.GetTargetID();
	int modeid = (int) Msg.GetModeID();
	int updown = (int) Msg.GetUpDown();
	float autoCorElev= (float) Msg.GetAutoCorrectElev();
	float autoCorBearing = (float) Msg.GetAutoCorrectBearing();
	float posX = (float) Msg.GetPosXValue();
	float posY = (float) Msg.GetPosYValue();
	float posZ = (float) Msg.GetPosZValue();

	if (oid == ORD_CANNON_ADD_DATA)
	{
		CanonData* canonData = new CanonData();
		
		canonData->ShipID = vid;
		canonData->mWeaponID = wid;
		canonData->mLauncherID = lid;
		canonData->mMissileID = mid;
		canonData->mMissileNum = mnum;
		canonData->OrderID = oid;
		canonData->mTargetID = tid;
		canonData->mModeID = modeid;
		canonData->spoutElev = autoCorElev;
		canonData->spoutBearing = autoCorBearing;
		canonData->FirstLaunchPoint.x() = posX;
		canonData->FirstLaunchPoint.y() = posY;
		canonData->FirstLaunchPoint.z() = posZ;
		canonData->WindEnviX = 0.0f;
		canonData->WindEnviY = 0.0f;
		
		AddCanonData(canonData);
	}
}

void CanonHandle::AddCanonData(CanonData* canonData)
{
	bool isValid;
	isValid = false;

	if ( canonData->mWeaponID == CT_CANNON_76 )
	{
		if (( canonData->spoutElev < 35.9 ) && ( canonData->spoutElev > 1 ))
		{
			//Low Balistik
			canonData->mBalistikID = 0;
			isValid		 = true;
		}
		else
		if (( canonData->spoutElev < 79.9 ) && ( canonData->spoutElev > 41 ))
		{
			//High Balistik
			canonData->mBalistikID = 1;
			isValid		 = true;
		}
		else
		{
			isValid = false;
		}
	}
	else
	if (( canonData->mWeaponID == CT_CANNON_40 ) ||
	    ( canonData->mWeaponID == CT_CANNON_57 ))
	{
		if (( canonData->spoutElev < 37 ) && ( canonData->spoutElev > 1 ))
		{
			isValid = true;
		}
	}
	else
	if ( canonData->mWeaponID == CT_CANNON_120 )
	{
		if (( canonData->spoutElev < 40 ) && ( canonData->spoutElev > 1 ))
		{
			isValid = true;
		}
	}

	if (isValid)
	{	
		std::cout << "Add canon data " << std::endl;
		//Initialize Property For Moving
		canonData->V0X = 0.0f;
		canonData->V0Y = 0.0f;
		canonData->Gun_76_Time = 0.0f;
		canonData->Gun_76_TimeMax = 0.0f;
		canonData->Gun_76_HeightMax = 0.0f;
		canonData->Gun_76_RangeMax = 0.0f; 
		canonData->LifeTime = 0.0f;
		canonData->isEnable = true;
		canonData->isHitGround = false;

		//Set Direction & Elevation Trajectory
		canonData->trac.SetDirection(canonData->spoutBearing);
		canonData->trac.SetElevation(canonData->spoutElev);

		//Set property For Moving
		/* Mr Reza Calc */
		/* Cannon 40 */
		if ((canonData->mWeaponID == CT_CANNON_40) ||
			(canonData->mWeaponID == CT_CANNON_57))
		{
			canonData->V0X = canonData->trac.Gun_40_GetV0X_ByElev(canonData->spoutElev);
			canonData->V0Y = canonData->trac.Gun_40_GetV0Y_ByElev(canonData->spoutElev);
		}
		else
		/* Cannon 120 */
		if (canonData->mWeaponID == CT_CANNON_120)
		{
			canonData->V0X = canonData->trac.Gun_120_GetV0X_ByElev(canonData->spoutElev);
			canonData->V0Y = canonData->trac.Gun_120_GetV0Y_ByElev(canonData->spoutElev);
		}
		else
		/* Mr Andi P Calc
		/* Cannon 76 */
		if ( canonData->mWeaponID == CT_CANNON_76 )
		{
			/* Low Balistik */
			if (canonData->mBalistikID == 0)
			{
				canonData->Gun_76_RangeMax		= canonData->trac.Gun_76Low_ElevToRange(canonData->spoutElev); 
				canonData->Gun_76_HeightMax		= canonData->trac.Gun_76Low_ElevToHeight(canonData->spoutElev); 
				canonData->Gun_76_TimeMax		= canonData->trac.Gun_76Low_RangeToTOF(canonData->Gun_76_RangeMax);
			}
			/* High Balistik */
			else
			{		
				canonData->Gun_76_RangeMax		= canonData->trac.Gun_76High_ElevToRange(canonData->spoutElev); 
				canonData->Gun_76_HeightMax	    = canonData->trac.Gun_76High_ElevToHeight(canonData->spoutElev); 
				canonData->Gun_76_TimeMax		= canonData->trac.Gun_76High_ElevToTOF(canonData->spoutElev);
				canonData->Gun_76_Time		    = canonData->trac.Gun_76Low_RangeToTOF(canonData->Gun_76_RangeMax);
			}
		}

		mCanonData.push_back(canonData); 
	}
}
float CanonHandle::GetWindDirX()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->WindX;
	}
	else
		return 0.0f;
}

float CanonHandle::GetWindDirY()
{
	SimEnvironmentDataBase* simEnviDB = dynamic_cast<SimEnvironmentDataBase*> (GetGameManager()->GetComponentByName(C_COMP_ENVI_DB));
	if (simEnviDB != NULL)
	{
		return simEnviDB->WindY;
	}
	else
		return 0.0f;
}