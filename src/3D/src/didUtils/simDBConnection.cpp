///////////////////////////////////////////////////////////////////////////////
//
// File           : $Workfile: simDBConnection.cpp $
// Version        : $Revision: 1 $
// Function       : $Database Connection: 1 $
// Sam
// 
///////////////////////////////////////////////////////////////////////////////

#include "simDBConnection.h"
#include "../didUtils/simDBContants.h"
#include "../didUtils/utilityfunctions.h"
#include "../didUtils/simActorControl.h"
#include "../didCommon/BaseConstant.h"
#include "../didNetwork/SimTCPDataTypes.h"

#include <dtABC/application.h>
#include <dtActors/gamemeshactor.h>
//#include <dtCore/odebodywrap.h>
#include <dtterrain/dtedterrainreader.h>

#include <stdlib.h>
#include <iostream>
#include <sstream>
#include <stdexcept>

/// temp use include ShipActor.h next use setproperty
#include "../didActors/ShipActor.h"

using namespace std;


SimDBConnection::SimDBConnection(void): dtGame::GMComponent(C_COMP_DB_CONNECTION)
{
	//
	enableProcessMessage = true;
}

SimDBConnection::~SimDBConnection(void)
{
}

string IntToString(int arg)  
{
    ostringstream buffer;
    buffer << arg;  
    return buffer.str();        
}

void SimDBConnection::ShowError( sql::SQLException &e )
{
  cout << "# ERR: SQLException in " << __FILE__;
  cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
  cout << "# ERR: " << e.what();
  cout << " (MySQL error code: " << e.getErrorCode();
  cout << ", SQLState: " << e.getSQLState() << " )" << endl;
}

bool SimDBConnection::GetStringValue( const std::string& attribName , float& result )
{
	bool retVal = false;

	std::string valueString = attribName ;
	valueString = dtUtil::Trim(valueString);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> result;
		if ( ss.eof() )
			retVal = true;
	}

	return retVal;
}

bool SimDBConnection::GetStringValue( const std::string& attribName , bool& result )
{
	bool retVal = false;

	std::string valueString = attribName;
	valueString = dtUtil::Trim(valueString);
	std::transform(valueString.begin(), valueString.end(), valueString.begin(), tolower);

	if (!valueString.empty())
	{
		if ( valueString == "true" || valueString == "1" )
		{
			result = true;
			retVal = true;
		}
		else if ( valueString == "false" || valueString == "0" )
		{
			result = false;
			retVal = true;
		}

	}

	return retVal;
}
bool SimDBConnection::GetStringValue( const std::string& attribName , osg::Vec2f& result )
{
	bool retVal = false;

	std::string valueString = attribName ;
	valueString = dtUtil::Trim(valueString);
	if (!valueString.empty())
	{
		std::istringstream ss, ssTempX, ssTempY;
		std::string tempStr;
		ss.str(valueString);
		char temp[255];
		float x, y;
		ss.getline(temp, ss.str().length(), ',');
		tempStr = temp;
		tempStr = dtUtil::Trim(tempStr);
		ssTempX.str(tempStr);
		ssTempX >> x;
		if (ssTempX.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempY.str(tempStr);
			ssTempY >> y;
		}

		if (ss.eof())
		{
			result.set(x,y);
			retVal = true;
		}
	}

	return retVal;
}

void SimDBConnection::ShowErrorGet( const std::string& err)
{
	std::cout<<"Error Get Value :: "<<err<<std::endl;
}

bool SimDBConnection::GetStringValue( const std::string& attribName , osg::Vec3f& result )
{
	bool retVal = false;

	std::string valueString = attribName;
	valueString = dtUtil::Trim(valueString);
	if (!valueString.empty())
	{
		std::istringstream ss, ssTempX, ssTempY, ssTempZ;
		std::string tempStr;
		ss.str(valueString);
		char temp[255];
		float x, y, z;
		ss.getline(temp, ss.str().length(), ',');
		tempStr = temp;
		tempStr = dtUtil::Trim(tempStr);
		ssTempX.str(tempStr);
		ssTempX >> x;
		if (ssTempX.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempY.str(tempStr);
			ssTempY >> y;
		}
		if (ssTempY.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempZ.str(tempStr);
			ssTempZ >> z;
		}

		if (ss.eof())
		{
			result.set(x,y,z);
			retVal = true;
		}
	}

	return retVal;
}

bool SimDBConnection::GetStringValue( const std::string& attribName , osg::Vec4f& result )
{
	bool retVal = false;

	std::string valueString = attribName;
	valueString = dtUtil::Trim(valueString);
	if (!valueString.empty())
	{
		std::istringstream ss, ssTempX, ssTempY, ssTempZ, ssTempW;
		std::string tempStr;
		ss.str(valueString);
		char temp[255];
		float x, y, z, w;
		ss.getline(temp, ss.str().length(), ',');
		tempStr = temp;
		tempStr = dtUtil::Trim(tempStr);
		ssTempX.str(tempStr);
		ssTempX >> x;
		if (ssTempX.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempY.str(tempStr);
			ssTempY >> y;
		}
		if (ssTempY.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempZ.str(tempStr);
			ssTempZ >> z;
		}
		if (ssTempZ.eof())
		{
			ss.getline(temp, ss.str().length(), ',');
			tempStr = temp;
			tempStr = dtUtil::Trim(tempStr);
			ssTempW.str(tempStr);
			ssTempW >> w;
		}

		if (ss.eof())
		{
			result.set(x,y,z,w);
			retVal = true;
		}
	}

	return retVal;
}
void SimDBConnection::SetOceanConfig(didEnviro::OceanConfigActor* configActor)
{
	////////////////////////////////////////////////////////////////
	//Ocean surface
	configActor->SetFFTGridSize(mOceanCFG.mFFTGridSize);
	configActor->SetResolution(mOceanCFG.mResolution);
	configActor->SetNumTiles(mOceanCFG.mNumTiles);
	configActor->SetWindDirection(mOceanCFG.mWindDirection);
	configActor->SetWindSpeed(mOceanCFG.mWindSpeed);
	configActor->SetDepth(mOceanCFG.mDepth);
	configActor->SetWaveScale(mOceanCFG.mWaveScale);
	configActor->SetIsChoppy(mOceanCFG.mIsChoppy);
	configActor->SetChoppyFactor(mOceanCFG.mChoppyFactor);
	configActor->SetAnimLoopTime(mOceanCFG.mAnimLoopTime);
	configActor->SetNumFrames(mOceanCFG.mNumFrames);
	configActor->SetFoamBottomHeight(mOceanCFG.mFoamBottomHeight);
	configActor->SetFoamTopHeight(mOceanCFG.mFoamTopHeight);
	configActor->SetEnableCrestFoam(mOceanCFG.mEnableCrestFoam);
	configActor->SetEnableEndlessOcean(mOceanCFG.mEnableEndlessOcean);
	configActor->SetOceanHeight(mOceanCFG.mOceanHeight);
	configActor->SetSeaState(mOceanCFG.mSeaState);

	////////////////////////////////////////////////////////////////
	//Skybox
	configActor->SetSkyBoxRadius(mOceanCFG.mSkyBoxRadius);
	configActor->SetSkyBoxLongSteps(mOceanCFG.mSkyBoxLongSteps);
	configActor->SetSkyBoxLatSteps(mOceanCFG.mSkyBoxLatSteps);
	configActor->SetSkyBoxUp(mOceanCFG.mTexUp);
	configActor->SetSkyBoxDown(mOceanCFG.mTexDown);
	configActor->SetSkyBoxLeft(mOceanCFG.mTexLeft);
	configActor->SetSkyBoxRight(mOceanCFG.mTexRight);
	configActor->SetSkyBoxFront(mOceanCFG.mTexFront);
	configActor->SetSkyBoxBack(mOceanCFG.mTexBack);

	////////////////////////////////////////////////////////////////
	//Lighting
	configActor->SetLightColor(mOceanCFG.mLightColor);
	configActor->SetSunDirection(mOceanCFG.mSunDirection);
	configActor->SetSunDiffuseColor(mOceanCFG.mSunDiffuseColor);
	configActor->SetSunAmbientColor(mOceanCFG.mSunAmbientColor);
	configActor->SetSunSpecularColor(mOceanCFG.mSunSpecularColor);
	configActor->SetUnderWaterDiffuseColor(mOceanCFG.mUnderWaterDiffuseColor);
	configActor->SetUnderWaterAttentuation(mOceanCFG.mUnderWaterAttentuation);
	configActor->SetEnableUnderwaterDOF(mOceanCFG.mEnableUnderwaterDOF);
	configActor->SetEnableReflections(mOceanCFG.mEnableReflections);
	configActor->SetReflectionDamping(mOceanCFG.mReflectionDamping);
	configActor->SetEnableRefractions(mOceanCFG.mEnableRefractions);
	configActor->SetEnableGodRays(mOceanCFG.mEnableGodRays);
	configActor->SetEnableSilt(mOceanCFG.mEnableSilt);
	configActor->SetEnableGlare(mOceanCFG.mEnableGlare);
	configActor->SetEnableGlow(mOceanCFG.mEnableGlow);  
	configActor->SetGlareAttentuation(mOceanCFG.mGlareAttentuation);
	configActor->SetUseDefaultSceneShader(mOceanCFG.mUseDefaultSceneShader);

	////////////////////////////////////////////////////////////////
	//Fog
	configActor->SetAboveWaterFogHeight(mOceanCFG.mAboveWaterFogHeight);
	configActor->SetAboveWaterFogColor(mOceanCFG.mAboveWaterFogColor);
	configActor->SetUnderWaterFogHeight(mOceanCFG.mUnderWaterFogHeight);
	configActor->SetUnderWaterFogColor(mOceanCFG.mUnderWaterFogColor);

	configActor->SetOceanInitFlag(); //Set the ocean so that it is built.
}


bool SimDBConnection::CreateOceanConfigActor()
{
	bool retVal = false;

	dtDAL::ActorProxy* proxy = NULL;
	dtCore::RefPtr<dtDAL::ActorProxy> proxyRef = NULL;
	dtCore::RefPtr<didEnviro::OceanConfigActorProxy> configActorProxy = NULL;
	dtCore::RefPtr<didEnviro::OceanConfigActor> configActor = NULL;

	dtGame::GameManager* gm = GetGameManager();
	const dtDAL::ActorType* type = gm->FindActorType(C_OCEAN_CAT, C_CN_OCEAN_CFG);
	gm->FindActorByType(*type, proxy );
	proxyRef = proxy;

	if (proxy)
	{
		configActor = dynamic_cast<didEnviro::OceanConfigActor*>(proxyRef.get()->GetActor());
	}
	else
	{
		proxyRef  = gm->CreateActor(*type);
		configActorProxy = dynamic_cast<didEnviro::OceanConfigActorProxy*>(proxyRef.get());
		configActor   = dynamic_cast<didEnviro::OceanConfigActor*>(configActorProxy->GetActor());
		gm->AddActor(*configActorProxy);
	}

	SetOceanConfig(configActor);
	retVal = true;
	return retVal;
}

bool SimDBConnection::CreateOceanConfigFromDatabase(const int scenarioID)
{
	bool retVal = false;
	int themeID = GetThemeIDFromScenarioID(scenarioID);
	if ( themeID >= 0 )
	{
		if ( retVal = LoadOceanConfigFromDatabase(themeID, scenarioID) )
		{	
			retVal = CreateOceanConfigActor( );
		}
	}

	return retVal;
}

std::vector<NGSPos*> SimDBConnection::GetNGSpos(const int ScenarioID)
{
	std::vector<NGSPos*> mListDef;

	int ThemeID;
	ThemeID = GetPortIDFromScenarioID(ScenarioID);
	if (ThemeID < 0 )
		return mListDef;

	try	
	{
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;
		qry.str("");
		qry << "SELECT * FROM m_splash_cannon ";
		qry << "WHERE idTheme ="<<ThemeID;
		res = stmt->executeQuery(qry.str());
	
		std::cout << "Get Splash From Theme " << ThemeID << std::endl;
			
		size_t row;
		row = 0;
		while (res->next()) 
		{
			NGSPos* mNGSDef = new NGSPos();
			mNGSDef->id = res->getInt("id");
			mNGSDef->idTheme = res->getInt("idTheme");
			mNGSDef->PosX = res->getInt("posX");
			mNGSDef->PosY = res->getInt("posY");
			mNGSDef->PosZ = res->getInt("posZ");

			mListDef.push_back(mNGSDef);

			std::cout << "NGSPos @" << mNGSDef->id << " Pos " << mNGSDef->PosX <<"-"<<mNGSDef->PosY<<"-"<<mNGSDef->PosZ << std::endl;  	
			row ++;
		}

		delete res;
		delete stmt;

		return mListDef;
	}
	catch (sql::SQLException &e) 
	{
		ShowError(e);
	}
}

void SimDBConnection::GetEnvironmentValue(const int ScenarioID, 
						  float& mEnvi_SeaState,
						  float& mEnvi_WindSpeed,
						  float& mEnvi_CurrentSpeed,
						  float& mEnvi_Temperature,
						  float& mEnvi_BarometerPressure,
						  float& mEnvi_Humidity,
						  float& mEnvi_WindDirection,
						  float& mEnvi_CurrentDirection,
						  float& mFog_Height)

{
	try	
	{
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;
		qry.str("");
		qry << "SELECT * FROM sce_main ";
		qry << "WHERE ID="<<ScenarioID;
		res = stmt->executeQuery(qry.str());
		res->next();

		mEnvi_SeaState = (float) res->getDouble("ENV_SEASTATE");
		mEnvi_WindSpeed = (float) res->getDouble("ENV_WSPEED");
		mEnvi_CurrentSpeed = (float) res->getDouble("ENV_CURSPEED");
		mEnvi_Temperature = (float) res->getDouble("ENV_TEMP");
		mEnvi_BarometerPressure = (float) res->getDouble("ENV_BAROPRESSURE");
		mEnvi_Humidity = (float) res->getDouble("ENV_HUMIDITY");
		mEnvi_WindDirection = (float) res->getDouble("ENV_WDIR_DEG");
		mEnvi_CurrentDirection = (float) res->getDouble("ENV_CURDIR_DEG");
		mFog_Height = (float) res->getDouble("ENV_FOG_H");
				
		delete res;
		delete stmt;
	}
	catch (sql::SQLException &e) 
	{
		ShowError(e);
	}

}


bool SimDBConnection::LoadOceanConfigFromDatabase(const int themeID, const int scenarioID )
{
	bool success = true;

	try	{		

		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;
		qry.str("");
		qry << "SELECT * FROM env_ocean ";
		qry << "WHERE ID="<<themeID;
		res = stmt->executeQuery(qry.str());
		res->next();

		//Ocean
		mOceanCFG.mFFTGridSize				= res->getInt("FFT_gridsize") ;
		mOceanCFG.mResolution				= res->getInt("resolution") ;
		mOceanCFG.mNumTiles					= res->getInt("num_tiles") ;
		if (!GetStringValue(res->getString("wind_direction"),mOceanCFG.mWindDirection))
			ShowErrorGet("wind_direction");
		mOceanCFG.mWindSpeed				= res->getInt("wind_speed") ;
		mOceanCFG.mDepth					= res->getInt("depth") ;
		if (!GetStringValue(res->getString("wave_scale"),mOceanCFG.mWaveScale))
			ShowErrorGet("wave_scale");
		if (!GetStringValue(res->getString("is_choppy"),mOceanCFG.mIsChoppy))
			ShowErrorGet("is_choppy");
		if (!GetStringValue(res->getString("choppy_factor"),mOceanCFG.mChoppyFactor))
			ShowErrorGet("choppy_factor");
		mOceanCFG.mAnimLoopTime				= res->getInt("anim_loop_time") ;
		mOceanCFG.mNumFrames				= res->getInt("num_frames") ;
		if (!GetStringValue(res->getString("foam_bottom_height"),mOceanCFG.mFoamBottomHeight))
			ShowErrorGet("foam_bottom_height");
		if (!GetStringValue(res->getString("foam_top_height"),mOceanCFG.mFoamTopHeight))
			ShowErrorGet("foam_top_height");
		if (!GetStringValue(res->getString("enable_crest_foam"),mOceanCFG.mEnableCrestFoam))
			ShowErrorGet("enable_crest_foam");
		if (!GetStringValue(res->getString("enable_endless_ocean"),mOceanCFG.mEnableEndlessOcean))
			ShowErrorGet("enable_endless_ocean");
		mOceanCFG.mOceanHeight				= res->getInt("ocean_height") ;

		//Skybox
		mOceanCFG.mSkyBoxRadius				= res->getInt("skybox_radius") ;
		mOceanCFG.mSkyBoxLongSteps			= res->getInt("skybox_longsteps") ;
		mOceanCFG.mSkyBoxLatSteps			= res->getInt("skybox_latsteps") ;
		
		sql::Statement *stmtSkyBox;
		sql::ResultSet *resSkyBox;
		stmtSkyBox = mysql_connection->createStatement();
		stringstream qrySkyBox;
		qrySkyBox.str("");
		qrySkyBox << "SELECT * FROM env_skybox ";
		qrySkyBox << "WHERE TIPE="<<themeID;
		resSkyBox = stmtSkyBox->executeQuery(qrySkyBox.str());
		resSkyBox->next();

		mOceanCFG.mTexUp					= resSkyBox->getString("tex_up") ;
		mOceanCFG.mTexDown					= resSkyBox->getString("tex_down") ;
		mOceanCFG.mTexLeft					= resSkyBox->getString("tex_left") ;
		mOceanCFG.mTexRight					= resSkyBox->getString("tex_right") ;
		mOceanCFG.mTexFront					= resSkyBox->getString("tex_front") ;
		mOceanCFG.mTexBack					= resSkyBox->getString("tex_back") ;

		delete stmtSkyBox;
		delete resSkyBox;
		

		//Lighting
		if (!GetStringValue(res->getString("light_color"),mOceanCFG.mLightColor))
			ShowErrorGet("Light Color");
		if (!GetStringValue(res->getString("sun_direction"),mOceanCFG.mSunDirection))
			ShowErrorGet("Sun Direction"); 
		if (!GetStringValue(res->getString("sun_diffuse_color"),mOceanCFG.mSunDiffuseColor))
			ShowErrorGet("Sun Diffuse Color");
		if (!GetStringValue(res->getString("sun_ambient_color"),mOceanCFG.mSunAmbientColor))
			ShowErrorGet("Sun Ambient Color");
		if (!GetStringValue(res->getString("sun_specular_color"),mOceanCFG.mSunSpecularColor))
			ShowErrorGet("Sun Specular Color");
		if (!GetStringValue(res->getString("underwater_diffuse_color"),mOceanCFG.mUnderWaterDiffuseColor))
			ShowErrorGet("UnderWaterDiffuseColor");
		if (!GetStringValue(res->getString("underwater_attenuation"),mOceanCFG.mUnderWaterAttentuation))
			ShowErrorGet("UnderWaterAttentuation");
		if (!GetStringValue(res->getString("enable_underwater_DOF"),mOceanCFG.mEnableUnderwaterDOF))
			ShowErrorGet("enable_underwater_DOF");
		if (!GetStringValue(res->getString("enable_reflection"),mOceanCFG.mEnableReflections))
			ShowErrorGet("enable_reflection");
		if (!GetStringValue(res->getString("reflection_damping"),mOceanCFG.mReflectionDamping))
			ShowErrorGet("reflection_damping");
		if (!GetStringValue(res->getString("enable_refraction"),mOceanCFG.mEnableRefractions))
			ShowErrorGet("enable_refraction");
		if (!GetStringValue(res->getString("enable_godrays"),mOceanCFG.mEnableGodRays))
			ShowErrorGet("enable_godrays");
		if (!GetStringValue(res->getString("enable_silt"),mOceanCFG.mEnableSilt))
			ShowErrorGet("enable_silt");
		if (!GetStringValue(res->getString("enable_glare"),mOceanCFG.mEnableGlare))
			ShowErrorGet("enable_glare");
		if (!GetStringValue(res->getString("enable_glow"),mOceanCFG.mEnableGlow))
			ShowErrorGet("enable_glow");
		if (!GetStringValue(res->getString("glare_attenuation"),mOceanCFG.mGlareAttentuation))
			ShowErrorGet("glare_attenuation");
		if (!GetStringValue(res->getString("use_default_scene_shader"),mOceanCFG.mUseDefaultSceneShader))
			ShowErrorGet("use_default_scene_shader");

		//Fog
		if (!GetStringValue(res->getString("abovewater_fog_height"),mOceanCFG.mAboveWaterFogHeight))
			ShowErrorGet("abovewater_fog_height");
		if (!GetStringValue(res->getString("underwater_fog_height"),mOceanCFG.mAboveWaterFogHeight))
			ShowErrorGet("underwater_fog_height");
		if (!GetStringValue(res->getString("abovewater_fog_color"),mOceanCFG.mAboveWaterFogColor))
			ShowErrorGet("AboveWaterFogColor") ;
		if (!GetStringValue(res->getString("underwater_fog_color"),mOceanCFG.mUnderWaterFogColor))
			ShowErrorGet("UnderWaterFogColor") ;
		 
		delete res;
		delete stmt;

		
		sql::Statement *Oceanstmt;
		sql::ResultSet *Oceanres;
		Oceanstmt = mysql_connection->createStatement();
		stringstream Oceanqry;
		Oceanqry.str("");
		Oceanqry << "SELECT * FROM sce_main ";
		Oceanqry << "WHERE ID="<<scenarioID;
		Oceanres = Oceanstmt->executeQuery(Oceanqry.str());
		Oceanres->next();
			
		mOceanCFG.mWaveScale = (float) Oceanres->getDouble("ENV_WSCALE"); 
		mOceanCFG.mWindSpeed = (float) Oceanres->getDouble("ENV_WSPEED");
		mOceanCFG.mWindDirection[0] = (float) Oceanres->getDouble("ENV_WDIR_X");
		mOceanCFG.mWindDirection[1] = (float) Oceanres->getDouble("ENV_WDIR_Y");
		mOceanCFG.mAboveWaterFogHeight = (float) Oceanres->getDouble("ENV_FOG_H");
		mOceanCFG.mSeaState = Oceanres->getInt("ENV_SEASTATE");

		delete Oceanres;
		delete Oceanstmt;


		success = true;

	} catch (sql::SQLException &e) {
		ShowError(e);
		success = false ;
	}

	return success;
}

bool SimDBConnection::LoadStaticObjectFromDatabase(const std::string& tblName , const int themeID )
{
	bool success = true;

	try	{		

		sql::Statement *stmt;
		sql::ResultSet *res;

		stmt = mysql_connection->createStatement();

		stringstream qry;
		qry.str("");
		qry << "SELECT * FROM "<<tblName<<" ";
		qry << "WHERE TIPE="<<themeID;
		res = stmt->executeQuery(qry.str());
		res->next();

		mStaticObject.mName				= res->getString("NAMA") ;
		mStaticObject.mMesh    			= res->getString("MESH") ;

		if (!GetStringValue(res->getString("TRANS_X"),mStaticObject.mTranslationXYZ.x()))
			ShowErrorGet("TRANS_X");
		if (!GetStringValue(res->getString("TRANS_Y"),mStaticObject.mTranslationXYZ.y()))
			ShowErrorGet("TRANS_Y");
		if (!GetStringValue(res->getString("TRANS_Z"),mStaticObject.mTranslationXYZ.z()))
			ShowErrorGet("TRANS_Z");
		if (!GetStringValue(res->getString("ROTATION"),mStaticObject.mRotationHPR.x()))
			ShowErrorGet("ROTATION");

		delete res;
		delete stmt;

		success = true;

	} catch (sql::SQLException &e) {
		ShowError(e);
		success = false ;
	}

	return success;
}


void SimDBConnection::CreateStaticObject(dtGame::GameManager &gameManager, const bool setCollision)
{
	if (mStaticObject.mMesh != "")
	{
		
		dtCore::RefPtr<dtDAL::ActorProxy> proxy;
		dtCore::RefPtr<dtActors::GameMeshActor> actMesh;
		dtActors::GameMeshActorProxy *actProxy;

		dtCore::Transform tx;

		proxy = gameManager.CreateActor("dtcore.Game.Actors", "Game Mesh Actor");
		proxy->SetName(mStaticObject.mName);
		if(!proxy.valid())
		{
			cout <<"!!! WARNING "<<mStaticObject.mName<<" Failed to create the object. Aborting."<< endl;
		}
		actMesh = static_cast<dtActors::GameMeshActor *>(proxy->GetActor());
		if(!actMesh.valid())
		{
			cout <<"!!! WARNING "<<mStaticObject.mName<<" The object was created, but has an invalid actor. Aborting."<< endl;
		}
		actProxy = static_cast<dtActors::GameMeshActorProxy *>(proxy.get());

		osg::Matrix matRot;
		tx.SetTranslation(mStaticObject.mTranslationXYZ);
		tx.SetRotation(mStaticObject.mRotationHPR.x(), mStaticObject.mRotationHPR.y(), mStaticObject.mRotationHPR.z());
		tx.GetRotation(matRot);
		actProxy->SetTranslation(mStaticObject.mTranslationXYZ);
		actProxy->SetRotationFromMatrix(matRot);
		actMesh->SetMesh(mStaticObject.mMesh);
		gameManager.AddActor(*proxy);

		if ( setCollision )
		{
			/*dMass mass;
			dMassSetBox(&mass, 1.0f, 1.0f, 1.0f, 1.0f);
			actMesh->SetCollisionMesh();
			actMesh->SetMass(&mass);*/
		}

	}
}

void SimDBConnection::CreateOceanActor(dtGame::GameManager &gameManager)
{
	dtCore::RefPtr<dtDAL::ActorProxy> ap= gameManager.CreateActor(C_OCEAN_CAT, C_CN_OCEAN);
	dtCore::RefPtr<dtGame::IEnvGameActorProxy> gap= static_cast<dtGame::IEnvGameActorProxy *>(ap.get());
	dtCore::RefPtr<dtGame::IEnvGameActor> ga= static_cast<dtGame::IEnvGameActor*>(gap->GetActor());
	gameManager.SetEnvironmentActor(gap);
}

bool SimDBConnection::CreateEnvironmentFromDatabase(dtGame::GameManager &gameManager, const int scenarioID) 
{
	bool succes = false;
	int portID = GetPortIDFromScenarioID(scenarioID);

	if ( ( portID >= 0 ) && ( portID != 2) )
	{
		// static terrain
		if ( succes = LoadStaticObjectFromDatabase("env_terrain",portID) )
		{
			CreateStaticObject(gameManager,true);
		}

		// static building
		if ( succes = LoadStaticObjectFromDatabase("env_building",portID) )
		{
			CreateStaticObject(gameManager,true);
		}

		// static ship
		if ( succes = LoadStaticObjectFromDatabase("env_ships",portID) )
		{
			CreateStaticObject(gameManager,true);
		}

		if (portID != 6)
		{
			//Static buoys
			if ( succes = LoadStaticObjectFromDatabase("env_buoy",portID) )
			{
				CreateStaticObject(gameManager,true);
			}

			//Static trees
			if ( succes = LoadStaticObjectFromDatabase("env_tree",portID) )
			{
				CreateStaticObject(gameManager,false);
			}
		}
	}

	return succes;
}

void SimDBConnection::GetListActorMissileDatabase( SimActorShipDef* mCompDef )
{
	try	{		

		sql::Statement *stmt;
		sql::ResultSet *res;

		stmt = mysql_connection->createStatement();

		stringstream qry;
		qry.str("");
	
		qry << " SELECT A.IDSHIP, A.IDWEAPON, A.IDDET AS IDLAUNCHER, B.IDMISSILE, CONCAT(C.NAMA,'-', A.IDSHIP, '-', A.IDDET, '-', B.IDMISSILE) AS MISSILE_NAME, ";
		qry	<< "	CONCAT(D.NAMA,'.', D.EXT) AS MODEL_NAME, E.NAMA AS DOF, B.POS_H, B.POS_P, B.H_LAUNCHER ";
		qry << " FROM m_model D RIGHT OUTER JOIN m_ship_missile B ON (D.ID = B.IDMODEL) ";
		qry << "    LEFT OUTER JOIN m_dof E ON (B.IDDOF = E.ID), m_ship_weapon A, m_weapon C  ";
		qry << " WHERE ( C.ID = A.IDWEAPON ) AND ( B.IDM = A.ID ) AND ( A.IDSHIP = "<<mCompDef->shipID<<" ) ";
		qry << " ORDER BY  A.IDSHIP, A.IDWEAPON, A.IDDET, B.IDMISSILE";

		res = stmt->executeQuery(qry.str());

		size_t row;
		row = 0;

		while (res->next()) {
			 
			SimActorMissileDef* msl	= new SimActorMissileDef();
			msl->VehicleID			= res->getInt("IDSHIP") ;
			msl->WeaponID  			= res->getInt("IDWEAPON") ;	
			msl->LauncherID			= res->getInt("IDLAUNCHER") ;
			msl->MissileID			= res->getInt("IDMISSILE") ;
			msl->MissileNum			= mCompDef->GetLastMissileNum(msl->VehicleID,msl->WeaponID,msl->LauncherID,msl->MissileID);
			msl->POS_Heading 		= res->getInt("POS_H") ;
			msl->POS_Pitch   		= res->getInt("POS_P") ;
			qry.str("");
			qry << msl->MissileNum ;
			std::string missileName	= res->getString("MISSILE_NAME")+"-"+qry.str() ;
			msl->MissileName 		= missileName;
			msl->MeshName 			= C_FOLDER_WEAPON+res->getString("MODEL_NAME") ;
			msl->DOFName    		= res->getString("DOF") ;
			msl->IsHasLauncher		= res->getBoolean("H_LAUNCHER") ;

			mCompDef->AddMissileOnShip(msl);

			cout<<"   :: "<<msl->MissileName<<" :: done.\n";
			//cout<<"   :: "<<msl->MissileName<<" :: "<<msl->DOFName<<" done.\n";

			row ++;

		};

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
	}


}

void SimDBConnection::GetListActorWeaponDatabase( SimActorShipDef* mCompDef , const int scenarioID)
{
	//Add Weapon
	try	{		
		//Nando Added Weapon Query
		//int ShipID_ForWeapon;
		//ShipID_ForWeapon = res->getInt("SHIP_ID");

		sql::Statement *stmtWeapon;
		sql::ResultSet *resWeapon;

		stmtWeapon = mysql_connection->createStatement();

		stringstream qry;
		qry.str("");
		//sementara ambil dari m_ship_weapon....editor 2D blom selesai kalau selesai pindah query ke sce_weapon
		//qry << "SELECT * FROM m_ship_weapon WHERE IDSHIP = " << mCompDef->shipID;
		//qry << " ORDER BY IDSHIP, IDWEAPON, IDDET";

		qry << " SELECT s.IDSHIP, s.IDWEAPON, s.IDDET, m.ID, m.IDMODEL1, m.IDMODEL2, m.IDDOF1, m.IDDOF2, m.IDSWITCH, m.POS_H, m.POS_P, m.IS3DACTOR, m.STARTANGLE, m.ENDANGLE, m.STARTPITCH, m.ENDPITCH ";
		qry << " FROM m_ship_weapon m INNER JOIN sce_weapon s ON (m.IDSHIP = s.IDSHIP) AND (m.IDWEAPON = s.IDWEAPON) AND (m.IDDET = s.IDDET) ";
		qry << " AND (s.IDSHIP = " << mCompDef->shipID << ")" ;
		qry << " AND (s.IDSCEN = "<<scenarioID << ")";
		qry << " ORDER BY s.IDSHIP, s.IDWEAPON, s.IDDET ";

		resWeapon = stmtWeapon->executeQuery(qry.str());

		size_t rowWeapon; 
		rowWeapon = 0;

		while (resWeapon->next()) {
			
			int idWeapon = resWeapon->getInt("IDWEAPON") ;
			if ( idWeapon > 0 )
			{
				std::string weaponName = SetLauncherName(mCompDef->shipID,idWeapon,resWeapon->getInt("IDDET"));

				
					SimActorWeaponDef* newCompWeaponDef = new SimActorWeaponDef();
					newCompWeaponDef->DatabaseID		= resWeapon->getInt("ID") ;
					newCompWeaponDef->Weapon_ShipID		= mCompDef->shipID;

					newCompWeaponDef->Weapon_ID			= idWeapon;
					newCompWeaponDef->Weapon_Launcher	= resWeapon->getInt("IDDET");
					newCompWeaponDef->Weapon_ModelID1	= resWeapon->getInt("IDMODEL1");
					int idModel2						= resWeapon->getInt("IDMODEL2");
					newCompWeaponDef->Weapon_ModelID2	= idModel2;
					newCompWeaponDef->Weapon_DOFID1  	= resWeapon->getInt("IDDOF1");
					newCompWeaponDef->Weapon_DOFID2  	= resWeapon->getInt("IDDOF2");
					newCompWeaponDef->Weapon_SwitchID  	= resWeapon->getInt("IDSWITCH");
					newCompWeaponDef->Weapon_Name		= weaponName;
					
					if ( newCompWeaponDef->Weapon_ModelID1 > 0)
					{
						newCompWeaponDef->MeshName1 = C_FOLDER_WEAPON+GetModelNameFromIDModel(newCompWeaponDef->Weapon_ModelID1);
					}

					if ( newCompWeaponDef->Weapon_ModelID2 > 0)
					{
						newCompWeaponDef->MeshName2	= C_FOLDER_WEAPON+GetModelNameFromIDModel(newCompWeaponDef->Weapon_ModelID2);
					}
					
					newCompWeaponDef->is3DActor			= resWeapon->getBoolean("IS3DACTOR");

					if (newCompWeaponDef->is3DActor == true)
					{
						if ( newCompWeaponDef->Weapon_DOFID1 > 0 )
						{
							newCompWeaponDef->DOFName1 = GetDOFNameFromIDDOF(newCompWeaponDef->Weapon_DOFID1);
						} else
						{
							cout<<"   Warning :: "<<weaponName<<" DOF ID belum di set."<<endl;
							newCompWeaponDef->DOFName1 = "nullDOF";
						}

						if ( newCompWeaponDef->Weapon_DOFID2 > 0 )
						{
							newCompWeaponDef->DOFName2 = GetDOFNameFromIDDOF(newCompWeaponDef->Weapon_DOFID2);
						}  else
						{
							cout<<"   Warning :: "<<weaponName<<" DOF ID 2 belum di set."<<endl;
							newCompWeaponDef->DOFName2 = "nullDOF";
						}

						if ( newCompWeaponDef->Weapon_SwitchID > 0 )
						{
							newCompWeaponDef->SwitchName    = GetSwitchNameFromIDSwitch(newCompWeaponDef->Weapon_SwitchID);
						} else
						{
							cout<<"   Warning :: "<<weaponName<<" id switch belum di set."<<endl;
							newCompWeaponDef->SwitchName = "nullSwitch";
						}
					}

					newCompWeaponDef->POS_Heading		= resWeapon->getInt("POS_H");
					newCompWeaponDef->POS_Pitch  		= resWeapon->getInt("POS_P");
					newCompWeaponDef->CountFire			= 0;
					newCompWeaponDef->isFire			= false;
					newCompWeaponDef->IntervalSalvo		= 0;
					newCompWeaponDef->isFirst			= true;
					newCompWeaponDef->i_launcher		= 0;

					

					newCompWeaponDef->StartAngle = (float)(resWeapon->getDouble("STARTANGLE"));
					newCompWeaponDef->EndAngle	 = (float)(resWeapon->getDouble("ENDANGLE"));
					newCompWeaponDef->StartPitch = (float)(resWeapon->getDouble("STARTPITCH"));
					newCompWeaponDef->EndPitch	 = (float)(resWeapon->getDouble("ENDPITCH"));

					if ( idWeapon == CT_CANNON_40 || 
						 idWeapon == CT_CANNON_57 ||
						 idWeapon == CT_CANNON_76 ||
						 idWeapon == CT_CANNON_120)
					{
						newCompWeaponDef->IntervalTimeSalvo = 5.0f;
					}
					else
					if ( idWeapon == CT_RBU_6000 )
					{
						newCompWeaponDef->IntervalTimeSalvo = 0.5f;
					}
					else
					if ( idWeapon == CT_YAKHONT)
					{
						newCompWeaponDef->IntervalTimeSalvo = 10.0f;
					}


					cout<<"   :: "<<weaponName<<" :: done.\n";

					//Add Weapon On Ship
					mCompDef->mCompDefWeaponShip.push_back(newCompWeaponDef);
			}
			else  /// if ( idWeapon > 0 )  
			{
				cout<<"   Warning :: Unknown weapon with id = "<<idWeapon<<endl;
			}


			//// next row database
			rowWeapon ++;

		};

		delete resWeapon;
		delete stmtWeapon;

	} catch (sql::SQLException &e) {
		ShowError(e);
	}

}


void SimDBConnection::GetListActorDefDatabase( const int scenarioID )
{
	CurrentScenarioID = scenarioID ;

	try {
		sql::Statement *stmt;
		sql::ResultSet *res;

		stmt = mysql_connection->createStatement();

		stringstream qry;

		std::cout << "Prepare Ship n Weapon From Database \n";

		qry.str("");
		qry << "SELECT A.*, B.TRANS_X, B.TRANS_Y, B.TRANS_Z, B.HEADING, B.SPEED, C.*";
		qry << " FROM sce_main A, sce_ship B, m_ship C";
		qry << " WHERE B.IDM = A.ID AND C.SHIP_ID = B.IDSHIP AND  A.ID = "<<CurrentScenarioID;
		res = stmt->executeQuery(qry.str());
		//res = stmt->executeQuery("SELECT A.ID, A.NAMA, B.IDSHIP, C.SHIP_NAME, C.SHIP_NO, B.TRANS_X, B.TRANS_Y, B.TRANS_Z" 
		//	" FROM sce_main A, sce_ship B, m_ship C" 
		//	" WHERE B.IDM = A.ID AND C.SHIP_ID = B.IDSHIP AND  A.ID = 1"
		//	);

		size_t row;
		row = 0;
		while (res->next()) {

			TypeActor tyActor;
			tyActor = SHIP;

			SimActorShipDef* newCompDef = new SimActorShipDef();
			
			newCompDef->shipID			= res->getInt("SHIP_ID");
			newCompDef->Category		= "dtcore.Game.Actors.Simulations";
			
			switch (res->getInt("SHIP_CATEGORY_ID")) 
			{
				case 1 : 
					newCompDef->CategoryName	= C_CN_SUBMARINE;
					break;
				case 50 : 	
					newCompDef->CategoryName	= C_CN_HELICOPTER;
					break;
				case 51 :
					newCompDef->CategoryName	= C_CN_AIRCRAFT;
					break;
				default :
					newCompDef->CategoryName	= C_CN_SHIP;
			}		
			
			newCompDef->SetTypeActor(tyActor);
			newCompDef->Name			= res->getString("SHIP_NAME");
			newCompDef->modelID         = res->getInt("IDMODEL");
			
			std::string fileModel		= ""; 
			if ( newCompDef->modelID > 0 )
			{
				fileModel = C_FOLDER_SHIP+GetModelNameFromIDModel(newCompDef->modelID);
				if ( fileModel == "" ) fileModel = C_FOLDER_SHIP+IntToString(newCompDef->shipID)+".ive"; 
			}

			newCompDef->MeshName		= fileModel;
			std::cout <<"Prepare Ship " << res->getString("SHIP_NAME") << " From Database \n";

			newCompDef->translation.x() = (float)(res->getDouble("TRANS_X"));
			newCompDef->translation.y() = (float)(res->getDouble("TRANS_Y"));
			newCompDef ->translation.z() = (float)(res->getDouble("TRANS_Z"));
			newCompDef->rotation.x()	= (float)(res->getDouble("HEADING"));
			newCompDef->length			= (float)(res->getDouble("DIM_LENGTH"));
			newCompDef->width			= (float)(res->getDouble("DIM_WIDTH"));
			newCompDef->height			= (float)(res->getDouble("DIM_HEIGHT"));
			newCompDef->max_ahead		= (float)(res->getDouble("SHIP_MAX_SPEED"));
			newCompDef->max_astern		= (float)(res->getDouble("SHIP_MAX_SPEED_ASTERN"));
			newCompDef->max_steer		= (float)(res->getDouble("SHIP_N_THROTTLE"));
			newCompDef->speed			= (float)(res->getDouble("SPEED"));
			newCompDef->isTargetActor	= res->getBoolean("ISTARGET");
			newCompDef->damage          = res->getInt("DAMAGE_SUSTAINABILITY");
						
			//cout << " heading "<< (float)(res->getDouble("HEADING"))<< endl;
			/*
			if ( res->getString("SHIP_CTRL_TYPE") == "RUDDER" )
				newCompDef->control_type = 0 ;
			else if ( res->getString("SHIP_CTRL_TYPE") == "STEER" )
				newCompDef->control_type = 1 ;
			*/

			//// get weapon / launcher detail 
			GetListActorWeaponDatabase(newCompDef, CurrentScenarioID);
			//// get missile detail 
			GetListActorMissileDatabase(newCompDef);
			//Add Ship
			mVehicleActors.push_back(newCompDef);

			cout << "   :: "<<newCompDef->Name<< ". done :: with speed "<< newCompDef->speed << " :: with damage " << newCompDef->damage << endl;

			row++;
		}

		delete res;
		delete stmt;
		
		/*
		std::auto_ptr< sql::ResultSet > res(stmt->executeQuery("SELECT SHIP_ID, SHIP_NAME FROM m_ship ORDER BY SHIP_ID ASC"));
		cout << "res->rowsCount() = " << res->rowsCount() << endl;

		size_t row;
		row = 0;
		while (res->next()) {
			cout << "#\t\t Fetching row " << row << "\t";
			cout << "ID = " << res->getInt("SHIP_ID"); ///res->getInt(1);
			cout << ", SHIP = '" << res->getString("SHIP_NAME") << "'" << endl;
			row++;
		}
		*/


	} catch (sql::SQLException &e) {
	  ShowError(e);
	}
}

std::string SimDBConnection::SetLauncherName(const int mVehicleID, const int mWeaponID , const int mLauncherID) 
{
	stringstream sname ;
	sname.str("");
	sname << "LAUNCHER "+GetWeaponNameFromIDWeapon(mWeaponID)<<"-"<<mVehicleID<<"-"<<mLauncherID;
	return sname.str();

}

SimActorMissileDef* SimDBConnection::GetNewDatabaseActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum )
{
	SimActorShipDef* vhc  = FindVehicleActorCompDef(mVehicleID);
	SimActorWeaponDef* weapon = FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID);
	SimActorMissileDef* missile  = FindActorMissileDef(mVehicleID,mWeaponID,mLauncherID,mMissileID,mMissileNum);

	// start [5/2/2013 DID RKT2]
	if (weapon == NULL)
	{
		std::cout << "weapon null GetNewDatabaseActorMissileDef" <<std::endl;
		weapon = GetNewDatabaseActorWeaponDef(mVehicleID,mWeaponID,mLauncherID);
	}
	// end [5/2/2013 DID RKT2]

	if ( vhc != NULL && weapon != NULL )
	{
		if ( missile == NULL )
		{
			try	
			{		
				sql::Statement *stmt;
				sql::ResultSet *res;

				stmt = mysql_connection->createStatement();

				stringstream qry;
				qry.str("");

				/*
				SELECT A.IDSHIP, A.IDWEAPON, A.IDDET AS IDLAUNCHER, B.IDMISSILE, CONCAT(C.NAMA,'-', A.IDSHIP, '-', A.IDDET, '-', B.IDMISSILE) AS MISSILE_NAME,  
					CONCAT(D.NAMA,'.', D.EXT) AS MODEL_NAME, E.NAMA AS DOF, B.POS_H, B.POS_P, B.H_LAUNCHER  
					FROM m_model D RIGHT OUTER JOIN m_ship_missile B ON (D.ID = B.IDMODEL)  
					LEFT OUTER JOIN m_dof E ON (B.IDDOF = E.ID), m_ship_weapon A, m_weapon C  
				WHERE ( C.ID = A.IDWEAPON ) AND ( B.IDM = A.ID ) AND  
					( A.IDSHIP = 29 ) AND ( A.IDWEAPON = 10)  AND ( A.IDDET= 1 )   AND ( B.IDMISSILE= 1 ) 
				ORDER BY  A.IDSHIP, A.IDWEAPON, A.IDDET, B.IDMISSILE
				*/

				qry << " SELECT A.IDSHIP, A.IDWEAPON, A.IDDET AS IDLAUNCHER, B.IDMISSILE, CONCAT(C.NAMA,'-', A.IDSHIP, '-', A.IDDET, '-', B.IDMISSILE) AS MISSILE_NAME, ";
				qry	<< "	CONCAT(D.NAMA,'.', D.EXT) AS MODEL_NAME, E.NAMA AS DOF, B.POS_H, B.POS_P, B.H_LAUNCHER ";
				qry << " FROM m_model D RIGHT OUTER JOIN m_ship_missile B ON (D.ID = B.IDMODEL) ";
				qry << "    LEFT OUTER JOIN m_dof E ON (B.IDDOF = E.ID), m_ship_weapon A, m_weapon C  ";
				qry << " WHERE ( C.ID = A.IDWEAPON ) AND ( B.IDM = A.ID ) AND ";
				qry << "    ( A.IDSHIP = "<<mVehicleID<<" ) AND ( A.IDWEAPON = "<<mWeaponID<<" )  AND ( A.IDDET= "<<mLauncherID<<" )   AND ( B.IDMISSILE= "<<mMissileID<<" )";
				qry << " ORDER BY  A.IDSHIP, A.IDWEAPON, A.IDDET, B.IDMISSILE";

				//cout<<"start query"<<endl;

				res = stmt->executeQuery(qry.str());
				res->next() ;
				
				//cout<<"start 1"<<endl;
				missile						= new SimActorMissileDef();
				missile->VehicleID			= res->getInt("IDSHIP") ;
				missile->WeaponID  			= res->getInt("IDWEAPON") ;	
				missile->LauncherID			= res->getInt("IDLAUNCHER") ;
				missile->MissileID			= res->getInt("IDMISSILE") ;
				missile->POS_Heading 		= res->getInt("POS_H") ;
				missile->POS_Pitch   		= res->getInt("POS_P") ;
				if ( mMissileNum > 0 ) 
					missile->MissileNum		= mMissileNum ;
				else if ( mMissileNum == 0 ) 
					missile->MissileNum		= vhc->GetLastMissileNum(missile->VehicleID,missile->WeaponID,missile->LauncherID,missile->MissileID);
				//cout<<"start missileName"<<endl;
				std::string missileName		= res->getString("MISSILE_NAME") ;
				//cout<<"start MissileName"<<endl;
				missile->MissileName 		= missileName ;
				//cout<<"MeshName"<<endl;
				missile->MeshName 			= C_FOLDER_WEAPON+res->getString("MODEL_NAME") ;
				//cout<<"DOFName"<<endl;
				missile->DOFName    		= res->getString("DOF") ;
				missile->IsHasLauncher		= res->getBoolean("H_LAUNCHER") ;
				missile->Lethality			= weapon->Lethality;

				std::cout << "missile->Lethality : " <<missile->Lethality << std::endl; 

				cout<<"AddMissileOnShip"<<endl;
				vhc->AddMissileOnShip(missile);
				//cout<<"end AddMissileOnShip"<<endl;
				

			} catch (sql::SQLException &e) {
				ShowError(e);
			}

		}

	}

	return missile;
}


SimActorWeaponDef* SimDBConnection::GetNewDatabaseActorWeaponDef( const int mVehicleID, const int mWeaponID, const int mLauncherID )
{
	SimActorShipDef* vhc  = FindVehicleActorCompDef(mVehicleID);
	SimActorWeaponDef* weapon = FindActorWeaponDef(mVehicleID,mWeaponID,mLauncherID);

	if ( vhc != NULL )
	{
		if ( weapon == NULL )
		{
			try	
			{		
				sql::Statement *stmtWeapon;
				sql::ResultSet *resWeapon;

				stmtWeapon = mysql_connection->createStatement();

				stringstream qry;
				qry.str("");
				qry << "SELECT * FROM m_ship_weapon WHERE IDSHIP = " << mVehicleID <<" AND IDWEAPON = "<<mWeaponID<<" AND IDDET = "<<mLauncherID;
				resWeapon = stmtWeapon->executeQuery(qry.str());

				resWeapon->next();

				weapon						= new SimActorWeaponDef();
				weapon->DatabaseID			= resWeapon->getInt("ID") ;
				weapon->Weapon_ShipID		= mVehicleID;

				weapon->Weapon_ID			= mWeaponID;
				weapon->Weapon_Launcher		= resWeapon->getInt("IDDET");
				int idModel1				= resWeapon->getInt("IDMODEL1") ;
				weapon->Weapon_ModelID1		= idModel1;
				int idModel2				= resWeapon->getInt("IDMODEL2") ;
				weapon->Weapon_ModelID2		= idModel2;
				weapon->Weapon_DOFID1  		= resWeapon->getInt("IDDOF1");
				weapon->Weapon_DOFID2  		= resWeapon->getInt("IDDOF2");
				weapon->Weapon_SwitchID 	= resWeapon->getInt("IDSWITCH");
				std::string weaponName		= SetLauncherName(mVehicleID,mWeaponID,mLauncherID);
				weapon->Weapon_Name			= weaponName;
				weapon->Lethality			= GetWeaponLethalityFromIDWeapon(mWeaponID);

				if (weapon->Weapon_ModelID1 != 0 ) //  [5/2/2013 DID RKT2]
					weapon->MeshName1			= C_FOLDER_WEAPON+GetModelNameFromIDModel(weapon->Weapon_ModelID1);
				if (weapon->Weapon_ModelID2 != 0 ) //  [5/2/2013 DID RKT2]
					weapon->MeshName2			= C_FOLDER_WEAPON+GetModelNameFromIDModel(weapon->Weapon_ModelID2);

				if ( weapon->Weapon_DOFID1 > 0 ) 
					weapon->DOFName1 = GetDOFNameFromIDDOF(weapon->Weapon_DOFID1);
				else
				{
					cout<<"   Warning :: "<<weaponName<<" DOFID1 belum di set."<<endl;
					weapon->DOFName1 = "dofnull";
				}

				if ( weapon->Weapon_DOFID2 > 0 ) 
					weapon->DOFName2 = GetDOFNameFromIDDOF(weapon->Weapon_DOFID2);
				else
				{
					cout<<"   Warning :: "<<weaponName<<" DOFID2 belum di set."<<endl;
					weapon->DOFName2 = "dofnull";
				}
				if ( weapon->Weapon_SwitchID > 0 ) weapon->SwitchName    = GetSwitchNameFromIDSwitch(weapon->Weapon_SwitchID);
				else
				{
					cout<<"   Warning :: "<<weaponName<<" switch belum di set."<<endl;
					weapon->SwitchName = "switchnull";
				}

				weapon->POS_Heading			= resWeapon->getInt("POS_H");
				weapon->POS_Pitch  			= resWeapon->getInt("POS_P");

				weapon->StartAngle		= (float) resWeapon->getDouble("STARTANGLE");
				weapon->EndAngle		= (float) resWeapon->getDouble("ENDANGLE");
				weapon->StartPitch		= (float) resWeapon->getDouble("STARTPITCH");
				weapon->EndPitch		= (float) resWeapon->getDouble("ENDPITCH");

				vhc->AddWeaponOnShip(weapon);

				cout<<"AddWeaponOnShip"<<endl;

				delete resWeapon;
				delete stmtWeapon;

			} catch (sql::SQLException &e) {
				ShowError(e);
			}

		}

	}

	return weapon;
}

void SimDBConnection::ShowShipList()
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;

		stmt = mysql_connection->createStatement();
		res = stmt->executeQuery("SELECT SHIP_ID, SHIP_NAME FROM m_ship ORDER BY SHIP_ID ASC");

		size_t row;
		row = 0;
		while (res->next()) {
			cout << "#\t\t Fetching row " << row << "\t";
			cout << "ID = " << res->getInt("SHIP_ID"); ///res->getInt(1);
			cout << ", SHIP = '" << res->getString("SHIP_NAME") << "'" << endl;
			row++;
		}

		delete res;
		delete stmt;
		
		/*
		std::auto_ptr< sql::ResultSet > res(stmt->executeQuery("SELECT SHIP_ID, SHIP_NAME FROM m_ship ORDER BY SHIP_ID ASC"));
		cout << "res->rowsCount() = " << res->rowsCount() << endl;

		size_t row;
		row = 0;
		while (res->next()) {
			cout << "#\t\t Fetching row " << row << "\t";
			cout << "ID = " << res->getInt("SHIP_ID"); ///res->getInt(1);
			cout << ", SHIP = '" << res->getString("SHIP_NAME") << "'" << endl;
			row++;
		}
		*/


	} catch (sql::SQLException &e) {
	  ShowError(e);
	}
}

bool SimDBConnection::isDatabaseConnected()
{
	bool isOK = false ;

	try
    {
	  //// todo :: cari cara lain yang lebih baik dari ceck connected database ini... ? 
      std::string retschema(""); 
      retschema = mysql_connection->getSchema();

	  std::transform(retschema.begin(), retschema.end(),retschema.begin(), ::toupper);
	  std::transform(mConnDBName.begin(), mConnDBName.end(),mConnDBName.begin(), ::toupper);

      if ( retschema == mConnDBName )
         isOK = true ; 
      else
		 isOK = false ; 
    }
    catch (sql::SQLException &)
    {
		isOK = false ;
    }

	return isOK; 
}

bool SimDBConnection::ConnectDatabase( const std::string& mHost, 
	const std::string& mUser, const std::string& mPass, const std::string& mDBN )
{
	std::string vHost ;
	if ( mHost != "" ) {
		vHost = "tcp://"+mHost+":3306";
	} else vHost = "";

	vHost != "" ?	( mConnHost = vHost )	: ( mConnHost = DID_CONN_HOST ) ;

	//Edited by Nando
	/*mUser != "" ?	( mConnUser = vHost )	: ( mConnUser = DID_CONN_USER  ) ;
	mPass != "" ?	( mConnPass = vHost )	: ( mConnPass = DID_CONN_PASS  ) ;
	mDBN  != "" ?	( mConnDBName= vHost )  : ( mConnDBName = DID _CONN_DB  ) ;*/

	mUser != "" ?	( mConnUser   = mUser )	: ( mConnUser   = DID_CONN_USER  ) ;
	mPass != "" ?	( mConnPass	  = mPass )	: ( mConnPass   = DID_CONN_PASS  ) ;
	mDBN  != "" ?	( mConnDBName = mDBN  ) : ( mConnDBName = DID_CONN_DB    ) ;

	try {
		mysql_driver		= sql::mysql::get_driver_instance();
		
		mysql_connection	= mysql_driver->connect(mConnHost,mConnUser,mConnPass);
		mysql_connection->setSchema(mConnDBName);

		//std::auto_ptr< sql::Statement > stmt(mysql_connection->createStatement());
		//stmt->execute("USE " + mConnDBName);
		
		/*
		stringstream sql;
		int i ;

		for (i = 0; i < res->rowsCount(); i++) {
			sql.str("");
			sql << "INSERT INTO m_ship(SHIP_ID, SHIP_NAME) VALUES (";
			sql << i << ", '" << "SHIP"<<i<< "')";
			stmt->execute(sql.str());
		}
		*/

		return true;
		 
	} catch (sql::SQLException &e) {
		ShowError(e);
		return false;
	} catch (std::runtime_error &e) {

		cout << "# ERR: runtime_error in " << __FILE__;
		cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
		cout << "# ERR: " << e.what() << endl;

		return false;
	}
	 
}

SimActorShipDef* SimDBConnection::GetActorCompDef(std::string actName)
{
	return NULL;
};


SimActorShipDef* SimDBConnection::FindActorCompDef(SimActorShipDef* actComp, std::string type)
{
	//std::cout << "Now Find " << type << " in " << actComp->Name << "\n";
	SimActorShipDef* act = NULL;

	if (actComp->Name == type)
	{
		act = actComp;
		IsActorFound = true;		
	}
	else
	if((actComp->mCompDefChilds.size() > 0) && (!IsActorFound)){
		for(std::vector<SimActorShipDef*>::iterator iter2=actComp->mCompDefChilds.begin(); 
				iter2!=actComp->mCompDefChilds.end(); iter2++ )
			// oh.. no more recurse please... pucink deh
			act = FindActorCompDef(*iter2, type);				
	}

	return act;
}

void SimDBConnection::CreateActorMissile(SimActorShipDef* actDef )
{
	for(std::vector<SimActorMissileDef*>::iterator iter=actDef->mCompDefMissile.begin();
		iter!=actDef->mCompDefMissile.end(); iter++)
	{
		int mVehicleID		= (*iter)->VehicleID;
		int mWeaponID		= (*iter)->WeaponID;
		int mLauncherID		= (*iter)->LauncherID;
		int mMissileID		= (*iter)->MissileID;
		int mMissileNum		= (*iter)->MissileNum;
		bool isHasLauncher	= (*iter)->IsHasLauncher;

		SimActorControl* simCtrl = dynamic_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
		dtCore::RefPtr<dtDAL::ActorProxy> proxy = simCtrl->GetMissileActors( mVehicleID, mWeaponID, mLauncherID, mMissileID, mMissileNum );
		if(!proxy.valid())
		{
			//std::cout<<"...create missile "<<(*iter)->MissileName<<std::endl; 
			simCtrl->CreateMissileActors(mVehicleID,mWeaponID, mLauncherID, mMissileID, mMissileNum);
		}
	}
}

void SimDBConnection::CreateActorWeapon(SimActorShipDef* actDef )
{
	//Nando Added
	for(std::vector<SimActorWeaponDef*>::iterator iter=actDef->mCompDefWeaponShip.begin();
		iter!=actDef->mCompDefWeaponShip.end(); iter++)
	{
		int mVehicleID  = (*iter)->Weapon_ShipID;
		int mWeaponID   = (*iter)->Weapon_ID;
		int mLauncherID = (*iter)->Weapon_Launcher;
		bool is3DActor =  (*iter)->is3DActor;

		if (is3DActor == true)
		{
			SimActorControl* simCtrl = dynamic_cast<SimActorControl*> (GetGameManager()->GetComponentByName(C_COMP_ACTOR_CONTROLLER));
			dtCore::RefPtr<dtDAL::ActorProxy> proxy = simCtrl->GetLauncherActors( C_WEAPON_TYPE_SPOUT, mVehicleID, mWeaponID, mLauncherID);
			if(!proxy.valid())
			{
				//std::cout<<"...create launcher "<<(*iter)->Weapon_Name<<std::endl; 
				simCtrl->CreateLaunchersActors(mVehicleID,mWeaponID, mLauncherID );
			}
		}
	};
}


dtCore::RefPtr<dtGame::GameActorProxy> SimDBConnection::CreateComponent(SimActorShipDef* actDef, std::string name, bool isChild )
{
	dtCore::RefPtr<const dtDAL::ActorType> atype;
	dtCore::RefPtr<dtDAL::ActorProxy> ap;
	dtCore::RefPtr<dtGame::GameActorProxy> gap;
	dtCore::RefPtr<dtGame::GameActor> ga;
	dtCore::RefPtr<dtGame::GameActorProxy> prChild;

	if (actDef != NULL) {
		atype	=  GetGameManager()->FindActorType(actDef->Category,actDef->CategoryName);
		ap		= GetGameManager()->CreateActor(*atype);
		gap		= dynamic_cast<dtGame::GameActorProxy*>(ap.get());
		ga		= dynamic_cast<dtGame::GameActor*>(gap->GetActor());

		std::string vehID;
		vehID = IntToString(actDef->shipID);

		if ( actDef->CategoryName == C_CN_SHIP || actDef->CategoryName == C_CN_SUBMARINE || actDef->CategoryName == C_CN_HELICOPTER
			|| actDef->CategoryName == C_CN_AIRCRAFT)
		{
			VehicleActor* actor = dynamic_cast<VehicleActor*> (ga.get());
			actor->SetVehicleID(actDef->shipID);
			actor->SetName(actDef->Name);
			actor->SetNight(isNightScenario(CurrentScenarioID));
			actor->SetIsTarget(actDef->isTargetActor);
			actor->SetMaxAheadSpeed(actDef->max_ahead);
			std::cout << GetName() << " max speed : " << actor->GetMaxAheadSpeed() << std::endl;
			if ( actor->GetIsTarget() )  
				std::cout<<GetName()<<" is target "<<std::endl;

			dtCore::Transform tx;	
			tx.SetTranslation(actDef->translation.x(),actDef->translation.y(),actDef->translation.z());
			tx.SetRotation(360- actDef->rotation.x(), 360- actDef->rotation.y(), 360- actDef->rotation.z());
			ga->SetTransform(tx);

			/*gap->GetProperty(C_SET_VID)->FromString( vehID );
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Width"))->SetValue(actDef->width);
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Length"))->SetValue(actDef->length);
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Height"))->SetValue(actDef->height);
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Max_Ahead"))->SetValue(actDef->max_ahead);
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Max_Astern"))->SetValue(actDef->max_astern);
			dynamic_cast<dtDAL::FloatActorProperty*> (gap->GetProperty("Max_Steer"))->SetValue(actDef->max_steer);
			dynamic_cast<dtDAL::IntActorProperty*> (gap->GetProperty("Control_Type"))->SetValue(actDef->control_type); */
		}
		
		//set property here
		gap->GetProperty(C_SET_MODEL)->FromString(actDef->MeshName);
		ga->SetName(actDef->Name);

		std::cout<<" Creating Actor DB :: "<<gap->GetActor()->GetName()<<std::endl;
		
		GetGameManager()->AddActor(*gap, false, false);

		dtCore::RefPtr<dtGame::ActorUpdateMessage> mes = 
			static_cast<dtGame::ActorUpdateMessage*>(GetGameManager()->GetMessageFactory().CreateMessage(dtGame::MessageType::INFO_ACTOR_CREATED).get());

		gap->PopulateActorUpdate(*mes);
		
		CreateActorWeapon(actDef);

		//CreateActorMissile(actDef);
		 
	}
	return gap; 
}

SimActorShipDef* SimDBConnection::FindActorCompDefByName(std::string name)
{
	IsActorFound = false;
	SimActorShipDef* actComp;

	for(std::vector<SimActorShipDef*>::iterator iter=mVehicleActors.begin(); 
		iter!=mVehicleActors.end(); iter++ )
	{
		actComp = FindActorCompDef(*iter,name);
		if (IsActorFound) {
			break;
		}
	}
	return actComp;
}

SimActorShipDef* SimDBConnection::FindVehicleActorCompDef(const int mVehicleID)
{
	SimActorShipDef* act = NULL;

	for(std::vector<SimActorShipDef*>::iterator iter= mVehicleActors.begin(); 
		iter!=mVehicleActors.end(); iter++ )
	{
		if ((*iter)->shipID == mVehicleID ) 
		{
			act = (*iter);
			break;
		}
	}

	return act;

}
SimActorWeaponDef* SimDBConnection::FindActorWeaponDef( const int mVehicleID, const int mWeaponID, const int mLauncherID ) 
{
	SimActorShipDef* vhc  = FindVehicleActorCompDef(mVehicleID);
	SimActorWeaponDef* wpn = NULL;

	if ( vhc != NULL  )
	{
		for(std::vector<SimActorWeaponDef*>::iterator iter = vhc->mCompDefWeaponShip.begin(); 
			iter!= vhc->mCompDefWeaponShip.end(); iter++ )
		{
			int WeaponID = (*iter)->Weapon_ID;
			int LauncherID = (*iter)->Weapon_Launcher;

			/*std::cout << "Name : " << vhc->Name << std::endl;
			std::cout << "Weapon ID : " << WeaponID << std::endl;
			std::cout << "launcherID : " << LauncherID << std::endl;*/

			if ((WeaponID == mWeaponID ) && (LauncherID == mLauncherID ))
			{
				wpn = (*iter);
				break;
			}
		}
 
	}

	return wpn;
}



SimActorMissileDef* SimDBConnection::FindActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum ) 
{
	SimActorShipDef* vhc  = FindVehicleActorCompDef(mVehicleID);
	SimActorMissileDef* msl = NULL;

	if ( vhc != NULL  )
	{
		for(std::vector<SimActorMissileDef*>::iterator iter = vhc->mCompDefMissile.begin(); 
			iter!= vhc->mCompDefMissile.end(); iter++ )
		{
			if (((*iter)->WeaponID == mWeaponID ) && ((*iter)->LauncherID == mLauncherID )&&
				((*iter)->MissileID  == mMissileID )&& ((*iter)->MissileNum  == mMissileNum ))
			{ 
				msl = (*iter);
				break;
			}
		}

	}

	return msl;
}


void SimDBConnection::DeleteActorMissileDef( const int mVehicleID, const int mWeaponID, const int mLauncherID, const int mMissileID, const int mMissileNum ) 
{
	SimActorShipDef* vhc  = FindVehicleActorCompDef(mVehicleID);
	SimActorMissileDef* msl = NULL;

	if ( vhc != NULL  )
	{
		for(std::vector<SimActorMissileDef*>::iterator iter = vhc->mCompDefMissile.begin(); 
			iter!= vhc->mCompDefMissile.end(); iter++ )
		{
			if (((*iter)->WeaponID == mWeaponID ) && ((*iter)->LauncherID == mLauncherID )&&
				((*iter)->MissileID  == mMissileID )&& ((*iter)->MissileNum  == mMissileNum ))
			{ 
				vhc->mCompDefMissile.erase(iter);
				break;
			}
		}

	}

}


dtCore::RefPtr<dtGame::GameActorProxy> SimDBConnection::CreateActor( std::string name )
{
	SimActorShipDef* act = FindActorCompDefByName(name);

	if (act != NULL){
		return CreateComponent(act,name,false);
	}

	return NULL;
}

void SimDBConnection::ProcessMessage(const dtGame::Message& Message)
{
	if (enableProcessMessage)
	{
		LOG_INFO("Database Conncetion Event");
		if(Message.GetMessageType().GetName() == SimMessageType::DATABASE_EVENT.GetName())
		{
			ProcessSetDBEvents(Message);
		}
	}
}


void SimDBConnection::ProcessSetDBEvents(const dtGame::Message &message)
{
	const MsgDatabaseEvent &Msg = static_cast<const MsgDatabaseEvent&>(message);

	int tipe	= (int)Msg.GetTypeID();
	int order	= (int)Msg.GetOrderID();

	switch ( tipe )
	{
		case ORD_DBE_TEST :
		{
			switch ( order)
			{
				case ORD_DBE_TEST_SHIP_LIST :
				{
					if ( isDatabaseConnected() )
						ShowShipList();
					else  
						cout <<"   Cannot Get Ship List :: Database Connection is Closed." << endl;
				}
				break;

				case ORD_DBE_TEST_WEAPON_LIST :
				{
					
				}
				break;

			}

			break;

		}
		
		case ORD_DBE_ADMIN :
		{
			switch ( order)
			{
				case ORD_DBE_ADMIN_CONNECT :
				{
					if ( isDatabaseConnected() )
						cout <<"   Database Connection is Opened." << endl;
					else
					{
						cout <<"   Connecting to Database ..." ;
						ConnectDatabase(mConnHost,mConnUser,mConnPass,mConnDBName);
						if ( isDatabaseConnected() )
							cout << "done.\n";
						else
							cout << "Someting wrong when try Connecting to Database.\n";
					} //
				}
				break;

				case ORD_DBE_ADMIN_DISCONNECT :
				{
					if ( isDatabaseConnected() )
					{
						cout <<"  Closing Database Connection ..." ;
						mysql_connection->close();
						bool isDBClosed = mysql_connection->isClosed();
						if ( isDBClosed )
						  cout << "done.\n" << endl;
						else
						  cout << "Someting wrong when try closing Database Connection." << endl;
					}
					else
						cout <<"  Database Connection is already Closed." << endl;
				}
				break;

			}

			break;
		}
 
	}
}



bool SimDBConnection::isNightScenario( const int scenarioID )
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;

		stmt = mysql_connection->createStatement();

		stringstream qry;

		qry.str("");
		qry << "SELECT B.night_scene";
		qry << " FROM sce_main A, env_ocean B";
		//qry << " WHERE B.ID = A.ENV_THEME AND A.ID = '"<<scenarioID<<"'";
		qry << " WHERE B.ID = A.ENV_THEME AND A.ID = "<<scenarioID;
		res = stmt->executeQuery(qry.str());
		res->next();
		return res->getBoolean("night_scene");

		delete res;
		delete stmt;


	} catch (sql::SQLException &e) {
	  ShowError(e);
	  return false;
	}
}


std::string SimDBConnection::GetShipNameByID ( const int shipID )  
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT A.SHIP_NAME";
			qry << " FROM m_ship A";
			qry << " WHERE A.SHIP_ID= "<<shipID;
			res = stmt->executeQuery(qry.str());
			res->next();
			return res->getString("SHIP_NAME");

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
		  ShowError(e);
		  return "";
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return "";
	}

}


double SimDBConnection::GetShipMaxSpeedByID ( const int shipID )  
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT A.SHIP_MAX_SPEED";
			qry << " FROM m_ship A";
			qry << " WHERE A.SHIP_ID= "<<shipID;
			res = stmt->executeQuery(qry.str());
			res->next();
			return res->getDouble("SHIP_MAX_SPEED");

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return 0;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return 0;
	}

}



double SimDBConnection::GetShipDamageByID ( const int shipID )  
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT A.DAMAGE_SUSTAINABILITY";
			qry << " FROM m_ship A";
			qry << " WHERE A.SHIP_ID= "<<shipID;
			res = stmt->executeQuery(qry.str());
			res->next();
			return res->getDouble("DAMAGE_SUSTAINABILITY");

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return 0;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return 0;
	}

}



int SimDBConnection::GetModelIDFromShipID( const int ShipID )
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		qry << "SELECT * ";
		qry << " FROM m_ship";
		qry << " WHERE SHIP_ID= "<< ShipID;
		res = stmt->executeQuery(qry.str());
		res->next();

		qry.str("");
		qry << res->getInt("IDMODEL");

		return res->getInt("IDMODEL");

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return 0;
	}
}

std::string SimDBConnection::GetModelNameFromIDModel(const int modelID )  
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		//qry << "SELECT CONCAT(NAMA,'.',EXT) AS MODELNAME ";
		qry << "SELECT * ";
		qry << " FROM m_model";
		qry << " WHERE ID= "<<modelID;
		res = stmt->executeQuery(qry.str());
		res->next();

		//cout <<qry.str()<< endl;

		qry.str("");
		qry << res->getString("NAMA")<<"."<<res->getString("EXT");
		//return res->getString("MODELNAME");
		
		return qry.str();

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return "";
	}

}


std::string SimDBConnection::GetDOFNameFromIDDOF(const int ID_DOF )  
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		qry << "SELECT * ";
		qry << " FROM m_dof";
		qry << " WHERE ID= "<<ID_DOF;
		res = stmt->executeQuery(qry.str());
		res->next();

		//cout <<qry.str()<< endl;
		return res->getString("NAMA");

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return "";
	}

}

std::string SimDBConnection::GetSwitchNameFromIDSwitch(const int ID_SWITCH )  
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		qry << "SELECT * ";
		qry << " FROM m_switch";
		qry << " WHERE ID= "<<ID_SWITCH;
		res = stmt->executeQuery(qry.str());
		res->next();

		//cout <<qry.str()<< endl;
		return res->getString("NAMA");

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return "";
	}

}

std::string SimDBConnection::GetWeaponNameFromIDWeapon(const int IDWEAPON )  
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		qry << "SELECT * ";
		qry << " FROM m_weapon";
		qry << " WHERE ID= "<<IDWEAPON;
		res = stmt->executeQuery(qry.str());
		res->next();

		return res->getString("NAMA");

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return "";
	}
}


int SimDBConnection::GetWeaponLethalityFromIDWeapon(const int IDWEAPON )  
{
	try {
		sql::Statement *stmt;
		sql::ResultSet *res;
		stmt = mysql_connection->createStatement();
		stringstream qry;

		qry.str("");
		qry << "SELECT * ";
		qry << " FROM m_weapon";
		qry << " WHERE ID= "<<IDWEAPON;
		res = stmt->executeQuery(qry.str());
		res->next();

		return res->getInt("LETHALITY");

		delete res;
		delete stmt;

	} catch (sql::SQLException &e) {
		ShowError(e);
		return 0;
	}
}

double SimDBConnection::GetxOffSetFromScenarioID(const int scenarioID)
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT xoffset";
			qry << " FROM env_port";
			qry << " inner join sce_main on";
			qry << " sce_main.id = "<<scenarioID;
			qry << " and sce_main.env_peta = env_port.id";
			res = stmt->executeQuery(qry.str());
			//res->next();
			double res_double;
			while (res->next())
			{
				 res_double = res->getDouble("xoffset");
			}

			return res_double;
			
			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return -1;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return -1;
	}
}

double SimDBConnection::GetyOffSetFromScenarioID(const int scenarioID)
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT yoffset";
			qry << " FROM env_port";
			qry << " inner join sce_main on";
			qry << " sce_main.id = "<<scenarioID;
			qry << " and sce_main.env_peta = env_port.id";
			res = stmt->executeQuery(qry.str());
			//res->next();
			double res_double;
			while (res->next())
			{
				res_double = res->getDouble("yoffset");
			}

			return res_double;

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return -1;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return -1;
	}
}

int SimDBConnection::GetPortIDFromScenarioID(const int scenarioID)
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT ENV_PETA";
			qry << " FROM sce_main";
			qry << " WHERE ID= "<<scenarioID;
			res = stmt->executeQuery(qry.str());
			res->next();
			return res->getInt("ENV_PETA");

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return -1;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return -1;
	}
}

int SimDBConnection::GetThemeIDFromScenarioID (const int scenarioID )  
{
	if ( isDatabaseConnected() )
	{
		try {
			sql::Statement *stmt;
			sql::ResultSet *res;

			stmt = mysql_connection->createStatement();

			stringstream qry;

			qry.str("");
			qry << "SELECT ENV_THEME";
			qry << " FROM sce_main";
			qry << " WHERE ID= "<<scenarioID;
			res = stmt->executeQuery(qry.str());
			res->next();
			return res->getInt("ENV_THEME");

			delete res;
			delete stmt;


		} catch (sql::SQLException &e) {
			ShowError(e);
			return -1;
		}
	}
	else 
	{
		cout <<"  Database Connection is Closed." << endl;
		return -1;
	}
}