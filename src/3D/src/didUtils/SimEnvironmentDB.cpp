#include "SimEnvironmentDB.h"

SimEnvironmentDataBase::SimEnvironmentDataBase(void): 
	dtGame::GMComponent(C_COMP_ENVI_DB)
	,mEnvi_SeaState(0.0f)
	,mEnvi_WindSpeed(0.0f)
	,mEnvi_CurrentSpeed(0.0f)
	,mEnvi_Temperature(0.0f)
	,mEnvi_BarometerPressure(0.0f)
	,mEnvi_Humidity(0.0f)
	,mEnvi_WindDirection(0.0f)
	,mEnvi_CurrentDirection(0.0f)
	,mEnvi_Fog_Height(0.0f)
	,DriftX(0.0f)
	,DriftY(0.0f)
	,WindX(0.0f)
	,WindY(0.0f)
	,enableProcessMessage(true)
{	
	
}

SimEnvironmentDataBase::~SimEnvironmentDataBase(void)
{
	
}

void SimEnvironmentDataBase::Move(double aDt)
{
	DriftSinX = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree(mEnvi_CurrentDirection))));
	DriftCosX = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree(mEnvi_CurrentDirection))));
	
	WindSinX = sin(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree(mEnvi_WindDirection)))); 
	WindCosX = cos(osg::DegreesToRadians(ConvCompass_To_Cartesian(ValidateDegree(mEnvi_WindDirection))));
	
	DriftX = (mEnvi_CurrentSpeed*metersPerKnotPerSecond*aDt) * DriftCosX;
	DriftY = (mEnvi_CurrentSpeed*metersPerKnotPerSecond*aDt) * DriftSinX;

	//WindX = (mEnvi_WindSpeed*metersPerKnotPerSecond*aDt) * WindCosX;
	//WindY = (mEnvi_WindSpeed*metersPerKnotPerSecond*aDt) * WindSinX; 

	WindX = (mEnvi_WindSpeed*metersPerKnotPerSecond*aDt) * sin(osg::DegreesToRadians(mEnvi_WindDirection));
	WindY = (mEnvi_WindSpeed*metersPerKnotPerSecond*aDt) * cos(osg::DegreesToRadians(mEnvi_WindDirection)); 
}

void SimEnvironmentDataBase::ProcessOceanControlMessage(const dtGame::Message& message)
{
	
    const MsgOceanControl &oceanMsg= static_cast<const MsgOceanControl &>(message);
    dtGame::GameManager* gm = GetGameManager();
    const dtDAL::ActorType* type = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
    didEnviro::OceanConfigActorProxy* proxy = NULL;
    gm->FindActorByName(C_CN_OCEAN_CFG, proxy);
    didEnviro::OceanConfigActor* configActor = NULL;

    if (proxy)
        configActor = static_cast<didEnviro::OceanConfigActor*>(proxy->GetActor());
    else
        return; 

    unsigned int orderID = oceanMsg.GetOrderID();
    float fValue = oceanMsg.GetFloatValue();
    int iValue = oceanMsg.GetIntValue();

    switch (orderID)
    {
        case ORD_OCEAN_ABOVE_FOG_HEIGHT_INC:
            std::cout<< "Receive Increase Fog Height message!" <<std::endl;
            fValue = configActor->GetAboveWaterFogHeight() + fValue;
            if (fValue > 1.0f)
                fValue -= 1.0f;
            configActor->SetAboveWaterFogHeight(fValue);
			mEnvi_Fog_Height = fValue;
            break;

        case ORD_OCEAN_ABOVE_FOG_HEIGHT_DEC:
            std::cout<< "Receive Decrease Fog Height message!" <<std::endl;
            fValue = configActor->GetAboveWaterFogHeight() - fValue;
            if (fValue < 0.0f)
                fValue += 1.0f;
            configActor->SetAboveWaterFogHeight(fValue);
			mEnvi_Fog_Height = fValue;
            break;

        case ORD_OCEAN_ABOVE_FOG_HEIGHT_CHANGE:
            std::cout<< "Receive Change Fog Height message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : (fValue > 1.0f ? 1.0f : fValue);
            configActor->SetAboveWaterFogHeight(fValue);
			mEnvi_Fog_Height = fValue;
            break;
       
        case ORD_OCEAN_WAVE_SCALE_INC:
            std::cout<< "Receive Increase Wave Scale message!" <<std::endl;
            fValue = configActor->GetWaveScale() + fValue;
            if (fValue > 1.0f)
                fValue -= 1.0f;
            configActor->SetWaveScale(fValue);
            break;

        case ORD_OCEAN_WAVE_SCALE_DEC:
            std::cout<< "Receive Decrease Wave Scale message!" <<std::endl;
            fValue = configActor->GetWaveScale() - fValue;
            if (fValue < 0.0f)
                fValue = 0.0f;
            configActor->SetWaveScale(fValue);
            break;

        case ORD_OCEAN_WAVE_SCALE_CHANGE:
            std::cout<< "Receive Change Wave Scale message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : (fValue > 1.0f ? 1.0f : fValue);
            configActor->SetWaveScale(fValue);
            break;
       
        case ORD_OCEAN_WIND_SPEED_INC:
            std::cout<< "Receive Increase Wind Speed message!" <<std::endl;
            fValue = configActor->GetWindSpeed() + fValue;
            configActor->SetWindSpeed(fValue);
            break;

        case ORD_OCEAN_WIND_SPEED_DEC:
            std::cout<< "Receive Decrease Wind Speed message!" <<std::endl;
            fValue = configActor->GetWindSpeed() - fValue;
            if (fValue < 0.0f)
                fValue = 0.0f;
            configActor->SetWindSpeed(fValue);
            break;

        case ORD_OCEAN_WIND_SPEED_CHANGE:
            std::cout<< "Receive Change Wind Speed message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.0f : fValue;
            configActor->SetWindSpeed(fValue);
            break;
       
        case ORD_OCEAN_WIND_LENGTH_INC:
            std::cout<< "Receive Increase Wind Length message!" <<std::endl;
            fValue = configActor->GetWindLength() + fValue;
            configActor->SetWindLength(fValue);
            break;

        case ORD_OCEAN_WIND_LENGTH_DEC:
            std::cout<< "Receive Decrease Wind Length message!" <<std::endl;
            fValue = configActor->GetWindLength() - fValue;
            if (fValue < 0.0f)
                fValue = 0.1f;
            configActor->SetWindLength(fValue);
            break;

        case ORD_OCEAN_WIND_LENGTH_CHANGE:
            std::cout<< "Receive Change Wind Length message!" <<std::endl;
            fValue = fValue < 0.0f ? 0.1f : fValue;
            configActor->SetWindLength(fValue);
            break;
        
        case ORD_OCEAN_SEA_STATE_INC:
            std::cout<< "Receive Increase Sea State message!" <<std::endl;
            iValue = configActor->GetSeaState() + iValue;
            if (iValue > 9)
                iValue = 0;
            configActor->SetSeaState(iValue);
			mEnvi_SeaState = iValue;
            break;

        case ORD_OCEAN_SEA_STATE_DEC:
            std::cout<< "Receive Decrease Sea State message!" <<std::endl;
            iValue = configActor->GetSeaState() - iValue;
            if (iValue < 0)
                iValue = 9;
            configActor->SetSeaState(iValue);
			mEnvi_SeaState = iValue;
            break;

        case ORD_OCEAN_SEA_STATE_CHANGE:
            std::cout<< "Receive Change Sea State message!" <<std::endl;
            iValue = fValue < 0 ? 0 : (iValue > 9 ? 9 : iValue);
            configActor->SetSeaState(iValue);
			mEnvi_SeaState = iValue;
            break;

		case ORD_HUMIDITY :   
			std::cout<< "Receive ORD_HUMIDITY to "<< fValue <<std::endl;
			mEnvi_Humidity = fValue;
			break;
		case ORD_BAROPRESSURE : 
			std::cout<< "Receive ORD_BAROPRESSURE to "<< fValue <<std::endl;
			mEnvi_BarometerPressure = fValue;
			break;
		case ORD_TEMPERATURE : 
			std::cout<< "Receive ORD_TEMPERATURE to "<< fValue <<std::endl;
			mEnvi_Temperature = fValue;
			break;
		case ORD_CURSPEED :
			std::cout<< "Receive ORD_CURSPEED to "<< fValue <<std::endl;
			mEnvi_CurrentSpeed = fValue;
			break;
		case ORD_WINDSPEED :
			std::cout<< "Receive ORD_WINDSPEED to "<< fValue <<std::endl;
			mEnvi_WindSpeed = fValue;
			break;
		case ORD_WINDDIRECTION :
			std::cout<< "Receive ORD_WINDDIRECTION to "<< fValue <<std::endl;
			mEnvi_WindDirection = fValue;
			break;
		case ORD_CURDIRECTION :
			std::cout<< "Receive ORD_CURDIRECTION to "<< fValue <<std::endl;
			mEnvi_CurrentDirection = fValue;
			break;
		
	}
}

void SimEnvironmentDataBase::loadEnvironmentFromDatabase(const int ScenarioID)
{
	SimDBConnection* cdb= static_cast<SimDBConnection*>(GetGameManager()->GetComponentByName("Database Connection"));
	if( cdb!= NULL) 
	{
		bool isDatabaseConnected = cdb->isDatabaseConnected();
		if ( isDatabaseConnected ) 
		{
			cdb->GetEnvironmentValue(ScenarioID, 
									mEnvi_SeaState,
									mEnvi_WindSpeed,
									mEnvi_CurrentSpeed,
									mEnvi_Temperature,
									mEnvi_BarometerPressure,
									mEnvi_Humidity,
									mEnvi_WindDirection,
									mEnvi_CurrentDirection,
									mEnvi_Fog_Height);

			dtGame::GameManager* gm = GetGameManager();
			const dtDAL::ActorType* type = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
			didEnviro::OceanConfigActorProxy* proxy = NULL;
			gm->FindActorByName(C_CN_OCEAN_CFG, proxy);
			didEnviro::OceanConfigActor* configActor = NULL;

			if (proxy)
			{
				configActor = static_cast<didEnviro::OceanConfigActor*>(proxy->GetActor());
				configActor->SetSeaState(mEnvi_SeaState);
			}
		}
		else
			std::cout << "Database Not Connected" << std::endl;
	}
	else
		std::cout << "Componen Not Found" << std::endl;
}

void SimEnvironmentDataBase::ProcessMessage(const dtGame::Message& Message)
{
	if (enableProcessMessage)
	{
		if (Message.GetMessageType().GetName() == SimMessageType::TICK_LOCAL.GetName())
		{
			const dtGame::TickMessage &tick = static_cast<const dtGame::TickMessage&>(Message);
			float deltaSimTime = tick.GetDeltaSimTime();
			Move(deltaSimTime);
		}
		else
			if(Message.GetMessageType().GetName() == SimMessageType::OCEAN_CONTROL.GetName())
			{
				ProcessOceanControlMessage(Message);
			}
	}
}