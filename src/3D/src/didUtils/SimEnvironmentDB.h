#ifndef SimEnvironmentDB_H
#define SimEnvironmentDB_H

#ifdef USE_VLD
#include <vld.h>
#endif

#include "../didCommon/BaseConstant.h"
#include "../didNetwork/SimTCPDataTypes.h"
#include "../didUtils/simDBConnection.h"
#include "../didUtils/utilityfunctions.h"


class SimEnvironmentDataBase :
		public dtGame::GMComponent
{
	private:
	public:
		//Environment in Intruktur 
		float mEnvi_SeaState;
		float mEnvi_WindSpeed;
		float mEnvi_CurrentSpeed;
		float mEnvi_Temperature;
		float mEnvi_BarometerPressure;
		float mEnvi_Humidity;
		float mEnvi_WindDirection;
		float mEnvi_CurrentDirection;
		float mEnvi_Fog_Height;

		//Ocean Calculation
		float DriftDirection;
		float DriftSinX;
		float DriftCosX;
		float DriftX;
		float DriftY;

		//Wind Calculation
		float WindDirection;
		float WindSinX;
		float WindCosX;
		float WindX;
		float WindY;

		// - enable process message [7/21/2014 EKA]
		bool enableProcessMessage;

		SimEnvironmentDataBase(void);
		~SimEnvironmentDataBase(void);

		void Move(double aDt);

		virtual void ProcessMessage(const dtGame::Message& Message);
		virtual void ProcessOceanControlMessage(const dtGame::Message& message);
		void loadEnvironmentFromDatabase(const int ScenarioID);
	protected:
	
};

#endif