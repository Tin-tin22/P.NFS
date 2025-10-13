#include "SimEnvironmentXML.h"

#include "../didCommon/BaseConstant.h"


#include <sstream>

#include <dtUtil/xercesutils.h>
#include <dtUtil/exception.h>

#include <xercesc/dom/DOM.hpp>
#include <xercesc/dom/DOMDocument.hpp>
#include <xercesc/dom/DOMDocumentType.hpp>
#include <xercesc/dom/DOMImplementation.hpp>
#include <xercesc/dom/DOMImplementationLS.hpp>
#include <xercesc/dom/DOMNodeIterator.hpp>
#include <xercesc/dom/DOMNodeList.hpp>
#include <xercesc/dom/DOMText.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>

#include <dtUtil/stringutils.h>

////////////////////////////////////////////////////////////////
//Constants
const SimOceanConfig SimEnvironmentXML::DEF_SIM_ENV_COMP		= SimOceanConfig();	///<default sim environment component							

const std::string SimEnvironmentXML::TAG_OCEAN						= "ocean";				//<ocean></ocean> tag

const std::string SimEnvironmentXML::TAG_OCEANSURFACE							= "oceansurface";			///<oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_FFT_GRIDSIZE			= "FFT_gridsize";			///<FFT_gridsize attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_RESOLUTION				= "resolution";				///<resolution attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_TILES				= "num_tiles";				///<num_tiles  attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_DIRECTION			= "wind_direction";			///<wind_direction attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_SPEED				= "wind_speed";				///<wind_speed attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_DEPTH					= "depth";					///<depth attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_WAVE_SCALE				= "wave_scale";				///<wave_scale attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_IS_CHOPPY				= "is_choppy";				///<is_choppy attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_CHOPPY_FACTOR			= "choppy_factor";			///<choppy_factor attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_ANIM_LOOP_TIME			= "anim_loop_time";			///<anim_loop_time attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_FRAMES				= "num_frames";				///<num_frames attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_BOTTOM_HEIGHT		= "foam_bottom_height";		///<foam_bottom_height attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_TOP_HEIGHT		= "foam_top_height";		///<foam_top_height attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_CREST_FOAM		= "enable_crest_foam";		///<enable_crest_foam attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_ENDLESS_OCEAN	= "enable_endless_ocean";	///<enable_endless_ocean attribute of oceansurface tag
const std::string SimEnvironmentXML::ATTRIB_OCEANSURFACE_OCEAN_HEIGHT			= "ocean_height";			///<ocean_height attribute of oceansurface tag

const std::string SimEnvironmentXML::TAG_SKYBOX						= "skybox";				//<skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_RADIUS			= "skybox_radius";		//skybox_radius attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_LONGSTEPS		= "skybox_longsteps";	//skybox_longsteps attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_LATSTEPS			= "skybox_latsteps";	//skybox_latsteps attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_UP			= "tex_up";				//tex_up attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_DOWN			= "tex_down";			//tex_down attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_LEFT			= "tex_left";			//tex_left attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_RIGHT		= "tex_right";			//tex_right attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_FRONT		= "tex_front";			//tex_front attribute of <skybox></skybox> tag
const std::string SimEnvironmentXML::ATTRIB_SKYBOX_TEX_BACK			= "tex_back";			//tex_back attribute of <skybox></skybox> tag

const std::string SimEnvironmentXML::TAG_LIGHTING								= "lighting";					///<lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_LIGHT_COLOR				= "light_color";				///<light_color attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIRECTION				= "sun_direction";				///<sun_direction attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIFFUSE_COLOR			= "sun_diffuse_color";			///<sun_diffuse_color attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_SUN_AMBIENT_COLOR			= "sun_ambient_color";			///<sun_ambient_color attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_SUN_SPECULAR_COLOR			= "sun_specular_color";			///<sun_specular_color attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_DIFFUSE_COLOR	= "underwater_diffuse_color";	///<underwater_diffuse_color attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_ATTENUATION		= "underwater_attenuation";		///<underwater_attenuation attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_UNDERWATER_DOF		= "enable_underwater_DOF";		///<enable_underwater_DOF attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFLECTION			= "enable_reflection";			///<enable_reflection attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_REFLECTION_DAMPING			= "reflection_damping";			///<reflection_damping attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFRACTION			= "enable_refraction";			///<enable_refraction attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GODRAYS				= "enable_godrays";				///<enable_godrays attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_SILT				= "enable_silt";				///<enable_silt attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLARE				= "enable_glare";				///<enable_glare attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLOW                = "enable_glow";				///<enable_glow attribute of lighting tag // BAWE:20110809
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_GLARE_ATTENUATION			= "glare_attenuation";			///<glare_attenuation attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_USE_DEFAULT_SCENE_SHADER	= "use_default_scene_shader";	///<use_default_scene_shader attribute of lighting tag
const std::string SimEnvironmentXML::ATTRIB_LIGHTING_NIGHT_SCENE                = "night_scene";                ///<night_scene attribute of lighting tag. NIGHT_BODY

const std::string SimEnvironmentXML::TAG_FOG						= "fog";						//<fog></fog> tag
const std::string SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_HEIGHT	= "abovewater_fog_height";		//abovewater_fog_height attribute of <fog></fog> tag
const std::string SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_COLOR	= "abovewater_fog_color";		//abovewater_fog_color attribute of <fog></fog> tag
const std::string SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_HEIGHT	= "underwater_fog_height";		//underwater_fog_height attribute of <fog></fog> tag
const std::string SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_COLOR	= "underwater_fog_color";		//underwater_fog_color attribute of <fog></fog> tag




////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimEnvironmentXML::SimEnvironmentXML()
						: dtGame::GMComponent("SimEnvironmentXML")
						, mLogger(dtUtil::Log::GetInstance("SimEnvironmentXML.cpp"))
{
}

SimEnvironmentXML::~SimEnvironmentXML()
{
}

////////////////////////////////////////////////////////////////
// Generic methods
bool SimEnvironmentXML::LoadXML(const std::string& fileName)
{
	bool success = true;

	// parse XML
	if(!ParseXML(fileName)){
		success = false;
	}

	return success;
}

bool SimEnvironmentXML::CreateOceanConfig( )
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

	SetConfig(configActor);

	retVal = true;

	return retVal;
}

bool SimEnvironmentXML::CreateOceanConfigFromXML(const std::string& fileName)
{
	bool retVal = false;

	if ( retVal = LoadXML(fileName) )
	{
		retVal = CreateOceanConfig( );
	}

	return retVal;
}

void SimEnvironmentXML::SetConfig(didEnviro::OceanConfigActor* configActor)
{
	////////////////////////////////////////////////////////////////
	//Ocean surface
	configActor->SetFFTGridSize(mSimOceanConfig.mFFTGridSize);
	configActor->SetResolution(mSimOceanConfig.mResolution);
	configActor->SetNumTiles(mSimOceanConfig.mNumTiles);
	configActor->SetWindDirection(mSimOceanConfig.mWindDirection);
	configActor->SetWindSpeed(mSimOceanConfig.mWindSpeed);
	configActor->SetDepth(mSimOceanConfig.mDepth);
	configActor->SetWaveScale(mSimOceanConfig.mWaveScale);
	configActor->SetIsChoppy(mSimOceanConfig.mIsChoppy);
	configActor->SetChoppyFactor(mSimOceanConfig.mChoppyFactor);
	configActor->SetAnimLoopTime(mSimOceanConfig.mAnimLoopTime);
	configActor->SetNumFrames(mSimOceanConfig.mNumFrames);
	configActor->SetFoamBottomHeight(mSimOceanConfig.mFoamBottomHeight);
	configActor->SetFoamTopHeight(mSimOceanConfig.mFoamTopHeight);
	configActor->SetEnableCrestFoam(mSimOceanConfig.mEnableCrestFoam);
	configActor->SetEnableEndlessOcean(mSimOceanConfig.mEnableEndlessOcean);
	configActor->SetOceanHeight(mSimOceanConfig.mOceanHeight);

	////////////////////////////////////////////////////////////////
	//Skybox
	configActor->SetSkyBoxRadius(mSimOceanConfig.mSkyBoxRadius);
	configActor->SetSkyBoxLongSteps(mSimOceanConfig.mSkyBoxLongSteps);
	configActor->SetSkyBoxLatSteps(mSimOceanConfig.mSkyBoxLatSteps);
	configActor->SetSkyBoxUp(mSimOceanConfig.mTexUp);
	configActor->SetSkyBoxDown(mSimOceanConfig.mTexDown);
	configActor->SetSkyBoxLeft(mSimOceanConfig.mTexLeft);
	configActor->SetSkyBoxRight(mSimOceanConfig.mTexRight);
	configActor->SetSkyBoxFront(mSimOceanConfig.mTexFront);
	configActor->SetSkyBoxBack(mSimOceanConfig.mTexBack);

	////////////////////////////////////////////////////////////////
	//Lighting
	configActor->SetLightColor(mSimOceanConfig.mLightColor);
	configActor->SetSunDirection(mSimOceanConfig.mSunDirection);
	configActor->SetSunDiffuseColor(mSimOceanConfig.mSunDiffuseColor);
	configActor->SetSunAmbientColor(mSimOceanConfig.mSunAmbientColor);
	configActor->SetSunSpecularColor(mSimOceanConfig.mSunSpecularColor);
	configActor->SetUnderWaterDiffuseColor(mSimOceanConfig.mUnderWaterDiffuseColor);
	configActor->SetUnderWaterAttentuation(mSimOceanConfig.mUnderWaterAttentuation);
	configActor->SetEnableUnderwaterDOF(mSimOceanConfig.mEnableUnderwaterDOF);
	configActor->SetEnableReflections(mSimOceanConfig.mEnableReflections);
	configActor->SetReflectionDamping(mSimOceanConfig.mReflectionDamping);
	configActor->SetEnableRefractions(mSimOceanConfig.mEnableRefractions);
	configActor->SetEnableGodRays(mSimOceanConfig.mEnableGodRays);
	configActor->SetEnableSilt(mSimOceanConfig.mEnableSilt);
	configActor->SetEnableGlare(mSimOceanConfig.mEnableGlare);
    configActor->SetEnableGlow(mSimOceanConfig.mEnableGlow); // BAWE-20110809: GLOW_SHADER
	configActor->SetGlareAttentuation(mSimOceanConfig.mGlareAttentuation);
	configActor->SetUseDefaultSceneShader(mSimOceanConfig.mUseDefaultSceneShader);

	////////////////////////////////////////////////////////////////
	//Fog
	configActor->SetAboveWaterFogHeight(mSimOceanConfig.mAboveWaterFogHeight);
	configActor->SetAboveWaterFogColor(mSimOceanConfig.mAboveWaterFogColor);
	configActor->SetUnderWaterFogHeight(mSimOceanConfig.mUnderWaterFogHeight);
	configActor->SetUnderWaterFogColor(mSimOceanConfig.mUnderWaterFogColor);

    //++ BAWE-20110405: ON_THE_FLY_OCEAN_CONTROL
    configActor->SetOceanInitFlag(); //Set the ocean so that it is built.
    //-- BAWE-20110405: ON_THE_FLY_OCEAN_CONTROL
}


bool SimEnvironmentXML::ParseXML( std::string fileName )
{
	bool success = true;

	std::ostringstream error;

	error << "Error parsing ocean config file: " << fileName << ".  Reason: "  ;
	
	xercesc::XercesDOMParser parser;

	parser.setValidationScheme(xercesc::XercesDOMParser::Val_Never);
	parser.setDoNamespaces(false);
	parser.setDoSchema(false);
	parser.setLoadExternalDTD(false);

	try
	{
		parser.parse(fileName.c_str());

		xercesc::DOMDocument *xmlDoc = parser.getDocument();
		if (xmlDoc == NULL)
		{
			std::ostringstream error;

			error << "Scenario XML document \" "<< fileName <<" \" not found.";
			throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		}

		xercesc::DOMElement *scenario = xmlDoc->getDocumentElement();
		if (scenario == NULL)
			throw dtUtil::Exception("Ocean Config XML document is empty.", __FILE__, __LINE__);

		dtUtil::XMLStringConverter strConv(scenario->getTagName());
		if (strConv.ToString() != SimEnvironmentXML::TAG_OCEAN)
			throw dtUtil::Exception("Malformed <ocean> element tag name.", __FILE__, __LINE__);

		xercesc::DOMNodeList *children = scenario->getChildNodes();
		for (XMLSize_t i=0; i<children->getLength(); i++)
		{
			xercesc::DOMNode *node = children->item(i);

			if (node == NULL)
				continue;
			if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
				continue;

			xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
			dtUtil::XMLStringConverter strConv(element->getTagName());

			/* parse oceansurface element */
			if (strConv.ToString() == SimEnvironmentXML::TAG_OCEANSURFACE )
				ParseOceansurfaceElement(element);	
			/* parse skybox element */
			else if (strConv.ToString() == SimEnvironmentXML::TAG_SKYBOX )
				ParseSkyboxElement(element);						
			/* parse lighting element */
			else if (strConv.ToString() == SimEnvironmentXML::TAG_LIGHTING )
				ParseLightingElement(element);						
			/* parse fog element */
			else if (strConv.ToString() == SimEnvironmentXML::TAG_FOG )
				ParseFogElement(element);
		}
	}
	catch (const xercesc::XMLException &e)
	{
		char *message = xercesc::XMLString::transcode(e.getMessage());
		std::ostringstream error;

		error << "Error parsing ocean config file: " << fileName << ".  Reason: " << message;

		xercesc::XMLString::release(&message);
		throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		success = false;
	}
	catch (const xercesc::DOMException &e)
	{

	}

	return success;
}

std::string SimEnvironmentXML::GetElementAttribute( xercesc::DOMElement& element
													  , const std::string& attribName
													  )
{
  XMLCh *xmlChar = xercesc::XMLString::transcode(attribName.c_str());
  dtUtil::XMLStringConverter converter(element.getAttribute(xmlChar));
  xercesc::XMLString::release(&xmlChar);

  return converter.ToString();
}

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											   , const std::string& attribName
											   , std::string& result
											   )
{
	bool retVal = false;

	result = GetElementAttribute(element, attribName);
	if (result.size() > 0)
		retVal = true;

	return retVal;
}

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											, const std::string& attribName
											, bool& result
											)
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											   , const std::string& attribName
											   , float& result
											   )
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											, const std::string& attribName
											, int& result
											)
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											, const std::string& attribName
											, osg::Vec2f& result
											)
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											, const std::string& attribName
											, osg::Vec3f& result
											)
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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

bool SimEnvironmentXML::GetAttribute( xercesc::DOMElement& element
											, const std::string& attribName
											, osg::Vec4f& result
											)
{
	bool retVal = false;

	std::string valueString = GetElementAttribute(element, attribName);
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


/* parsing skybox element*/
bool SimEnvironmentXML::ParseOceansurfaceElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	///////////
	// ATTRIB_OCEANSURFACE_FFT_GRIDSIZE
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_FFT_GRIDSIZE, mSimOceanConfig.mFFTGridSize ) ) )
	{
		mSimOceanConfig.mFFTGridSize = DEF_SIM_ENV_COMP.mFFTGridSize;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_FFT_GRIDSIZE << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_OCEANSURFACE_RESOLUTION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_RESOLUTION, mSimOceanConfig.mResolution ) ) )
	{
		mSimOceanConfig.mResolution = DEF_SIM_ENV_COMP.mResolution;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_RESOLUTION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_NUM_TILES
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_TILES, mSimOceanConfig.mNumTiles ) ) )
	{
		mSimOceanConfig.mNumTiles = DEF_SIM_ENV_COMP.mNumTiles;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_TILES << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_WIND_DIRECTION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_DIRECTION, mSimOceanConfig.mWindDirection ) ) )
	{
		mSimOceanConfig.mWindDirection = DEF_SIM_ENV_COMP.mWindDirection;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_DIRECTION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_WIND_SPEED
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_SPEED, mSimOceanConfig.mWindSpeed ) ) )
	{
		mSimOceanConfig.mWindSpeed = DEF_SIM_ENV_COMP.mWindSpeed;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_WIND_SPEED << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_DEPTH
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_DEPTH, mSimOceanConfig.mDepth ) ) )
	{
		mSimOceanConfig.mDepth = DEF_SIM_ENV_COMP.mDepth;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_DEPTH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_WAVE_SCALE
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_WAVE_SCALE, mSimOceanConfig.mWaveScale ) ) )
	{
		mSimOceanConfig.mWaveScale = DEF_SIM_ENV_COMP.mWaveScale;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_WAVE_SCALE << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_IS_CHOPPY
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_IS_CHOPPY, mSimOceanConfig.mIsChoppy ) ) )
	{
		mSimOceanConfig.mIsChoppy = DEF_SIM_ENV_COMP.mIsChoppy;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_IS_CHOPPY << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_CHOPPY_FACTOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_CHOPPY_FACTOR, mSimOceanConfig.mChoppyFactor ) ) )
	{
		mSimOceanConfig.mChoppyFactor = DEF_SIM_ENV_COMP.mChoppyFactor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_CHOPPY_FACTOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	///////////
	// ATTRIB_OCEANSURFACE_ANIM_LOOP_TIME
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_ANIM_LOOP_TIME, mSimOceanConfig.mAnimLoopTime ) ) )
	{
		mSimOceanConfig.mAnimLoopTime = DEF_SIM_ENV_COMP.mAnimLoopTime;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_ANIM_LOOP_TIME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_OCEANSURFACE_NUM_FRAMES
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_FRAMES, mSimOceanConfig.mNumFrames ) ) )
	{
		mSimOceanConfig.mNumFrames = DEF_SIM_ENV_COMP.mNumFrames;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_NUM_FRAMES << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_FOAM_BOTTOM_HEIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_BOTTOM_HEIGHT, mSimOceanConfig.mFoamBottomHeight ) ) )
	{
		mSimOceanConfig.mFoamBottomHeight = DEF_SIM_ENV_COMP.mFoamBottomHeight;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_BOTTOM_HEIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_FOAM_TOP_HEIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_TOP_HEIGHT, mSimOceanConfig.mFoamTopHeight ) ) )
	{
		mSimOceanConfig.mFoamTopHeight = DEF_SIM_ENV_COMP.mFoamTopHeight;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_FOAM_TOP_HEIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_ENABLE_CREST_FOAM
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_CREST_FOAM, mSimOceanConfig.mEnableCrestFoam ) ) )
	{
		mSimOceanConfig.mEnableCrestFoam = DEF_SIM_ENV_COMP.mEnableCrestFoam;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_CREST_FOAM << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_ENABLE_ENDLESS_OCEAN
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_ENDLESS_OCEAN, mSimOceanConfig.mEnableEndlessOcean ) ) )
	{
		mSimOceanConfig.mEnableEndlessOcean = DEF_SIM_ENV_COMP.mEnableEndlessOcean;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_ENABLE_ENDLESS_OCEAN << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_OCEANSURFACE_OCEAN_HEIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_OCEANSURFACE_OCEAN_HEIGHT, mSimOceanConfig.mOceanHeight ) ) )
	{
		mSimOceanConfig.mOceanHeight = DEF_SIM_ENV_COMP.mOceanHeight;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_OCEANSURFACE_OCEAN_HEIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	return retVal;
}

/* parsing skybox element*/
bool SimEnvironmentXML::ParseSkyboxElement( xercesc::DOMElement *elem )
{
	bool retVal = true;
	
	///////////
	// ATTRIB_SKYBOX_RADIUS
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_RADIUS, mSimOceanConfig.mSkyBoxRadius ) ) )
	{
		mSimOceanConfig.mSkyBoxRadius = DEF_SIM_ENV_COMP.mSkyBoxRadius;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_RADIUS << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_SKYBOX_LONGSTEPS
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_LONGSTEPS, mSimOceanConfig.mSkyBoxLongSteps ) ) )
	{
		mSimOceanConfig.mSkyBoxLongSteps = DEF_SIM_ENV_COMP.mSkyBoxLongSteps;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_LONGSTEPS << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_LATSTEPS
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_LATSTEPS, mSimOceanConfig.mSkyBoxLatSteps ) ) )
	{
		mSimOceanConfig.mSkyBoxLatSteps = DEF_SIM_ENV_COMP.mSkyBoxLatSteps;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_LATSTEPS << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_UP
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_UP, mSimOceanConfig.mTexUp ) ) )
	{
		mSimOceanConfig.mTexUp = DEF_SIM_ENV_COMP.mTexUp;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_UP << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_DOWN
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_DOWN, mSimOceanConfig.mTexDown ) ) )
	{
		mSimOceanConfig.mTexDown = DEF_SIM_ENV_COMP.mTexDown;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_DOWN << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_LEFT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_LEFT, mSimOceanConfig.mTexLeft ) ) )
	{
		mSimOceanConfig.mTexLeft = DEF_SIM_ENV_COMP.mTexLeft;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_LEFT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_RIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_RIGHT, mSimOceanConfig.mTexRight ) ) )
	{
		mSimOceanConfig.mTexRight = DEF_SIM_ENV_COMP.mTexRight;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_RIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_FRONT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_FRONT, mSimOceanConfig.mTexFront ) ) )
	{
		mSimOceanConfig.mTexFront = DEF_SIM_ENV_COMP.mTexFront;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_FRONT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_SKYBOX_TEX_BACK
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_SKYBOX_TEX_BACK, mSimOceanConfig.mTexBack ) ) )
	{
		mSimOceanConfig.mTexBack = DEF_SIM_ENV_COMP.mTexBack;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_SKYBOX_TEX_BACK << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	return retVal;
}


/* parsing skybox element*/
bool SimEnvironmentXML::ParseLightingElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	///////////
	// ATTRIB_LIGHTING_LIGHT_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_LIGHT_COLOR, mSimOceanConfig.mLightColor ) ) )
	{
		mSimOceanConfig.mLightColor = DEF_SIM_ENV_COMP.mLightColor;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_LIGHT_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_LIGHTING_SUN_DIRECTION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIRECTION, mSimOceanConfig.mSunDirection ) ) )
	{
		mSimOceanConfig.mSunDirection = DEF_SIM_ENV_COMP.mSunDirection;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIRECTION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_SUN_DIFFUSE_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIFFUSE_COLOR, mSimOceanConfig.mSunDiffuseColor ) ) )
	{
		mSimOceanConfig.mSunDiffuseColor = DEF_SIM_ENV_COMP.mSunDiffuseColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_SUN_DIFFUSE_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_SUN_AMBIENT_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_SUN_AMBIENT_COLOR, mSimOceanConfig.mSunAmbientColor ) ) )
	{
		mSimOceanConfig.mSunAmbientColor = DEF_SIM_ENV_COMP.mSunAmbientColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_SUN_AMBIENT_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_SUN_SPECULAR_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_SUN_SPECULAR_COLOR, mSimOceanConfig.mSunSpecularColor ) ) )
	{
		mSimOceanConfig.mSunSpecularColor = DEF_SIM_ENV_COMP.mSunSpecularColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_SUN_SPECULAR_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}


	///////////
	//ATTRIB_LIGHTING_UNDERWATER_DIFFUSE_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_DIFFUSE_COLOR, mSimOceanConfig.mUnderWaterDiffuseColor ) ) )
	{
		mSimOceanConfig.mUnderWaterDiffuseColor = DEF_SIM_ENV_COMP.mUnderWaterDiffuseColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_DIFFUSE_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_UNDERWATER_ATTENUATION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_ATTENUATION, mSimOceanConfig.mUnderWaterAttentuation ) ) )
	{
		mSimOceanConfig.mUnderWaterAttentuation = DEF_SIM_ENV_COMP.mUnderWaterAttentuation;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_UNDERWATER_ATTENUATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_ENABLE_UNDERWATER_DOF
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_UNDERWATER_DOF, mSimOceanConfig.mEnableUnderwaterDOF ) ) )
	{
		mSimOceanConfig.mEnableUnderwaterDOF = DEF_SIM_ENV_COMP.mEnableUnderwaterDOF;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_UNDERWATER_DOF << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_ENABLE_REFLECTION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFLECTION, mSimOceanConfig.mEnableReflections ) ) )
	{
		mSimOceanConfig.mEnableReflections = DEF_SIM_ENV_COMP.mEnableReflections;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFLECTION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_REFLECTION_DAMPING
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_REFLECTION_DAMPING, mSimOceanConfig.mReflectionDamping ) ) )
	{
		mSimOceanConfig.mReflectionDamping = DEF_SIM_ENV_COMP.mReflectionDamping;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_REFLECTION_DAMPING << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_ENABLE_REFRACTION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFRACTION, mSimOceanConfig.mEnableRefractions ) ) )
	{
		mSimOceanConfig.mEnableRefractions = DEF_SIM_ENV_COMP.mEnableRefractions;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_REFRACTION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	///////////
	// ATTRIB_LIGHTING_ENABLE_GODRAYS
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GODRAYS, mSimOceanConfig.mEnableGodRays ) ) )
	{
		mSimOceanConfig.mEnableGodRays = DEF_SIM_ENV_COMP.mEnableGodRays;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GODRAYS << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_LIGHTING_ENABLE_SILT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_SILT, mSimOceanConfig.mEnableSilt ) ) )
	{
		mSimOceanConfig.mEnableSilt = DEF_SIM_ENV_COMP.mEnableSilt;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_SILT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_ENABLE_GLARE
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLARE, mSimOceanConfig.mEnableGlare ) ) )
	{
		mSimOceanConfig.mEnableGlare = DEF_SIM_ENV_COMP.mEnableGlare;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLARE << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

    //++ BAWE-20110809: GLOW_SHADER
	///////////
	//ATTRIB_LIGHTING_ENABLE_GLOW
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLOW, mSimOceanConfig.mEnableGlow ) ) )
	{
		mSimOceanConfig.mEnableGlow = DEF_SIM_ENV_COMP.mEnableGlow;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_ENABLE_GLOW << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
    //-- BAWE-20110809: GLOW_SHADER

	///////////
	//ATTRIB_LIGHTING_GLARE_ATTENUATION
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_GLARE_ATTENUATION, mSimOceanConfig.mGlareAttentuation ) ) )
	{
		mSimOceanConfig.mGlareAttentuation = DEF_SIM_ENV_COMP.mGlareAttentuation;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_GLARE_ATTENUATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_LIGHTING_USE_DEFAULT_SCENE_SHADER
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_USE_DEFAULT_SCENE_SHADER, mSimOceanConfig.mUseDefaultSceneShader ) ) )
	{
		mSimOceanConfig.mUseDefaultSceneShader = DEF_SIM_ENV_COMP.mUseDefaultSceneShader;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_USE_DEFAULT_SCENE_SHADER << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

    //++ BAWE-20110606: NIGHT_BODY
    ///////////
    //ATTRIB_LIGHTING_NIGHT_SCENE
    if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_LIGHTING_NIGHT_SCENE, mSimOceanConfig.mIsNightScene ) ) )
    {
        mSimOceanConfig.mIsNightScene = DEF_SIM_ENV_COMP.mIsNightScene;

        std::ostringstream error;
        error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_LIGHTING_NIGHT_SCENE << ". Using default value instead.";

        //throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
        mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
            error.str());
        retVal = false;
    }
    //-- BAWE-20110606: NIGHT_BODY

	return retVal;
}

/* parsing fog element*/
bool SimEnvironmentXML::ParseFogElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	///////////
	// ATTRIB_FOG_ABOVEWATER_HEIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_HEIGHT, mSimOceanConfig.mAboveWaterFogHeight ) ) )
	{
		mSimOceanConfig.mAboveWaterFogHeight = DEF_SIM_ENV_COMP.mAboveWaterFogHeight;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_HEIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	// ATTRIB_FOG_ABOVEWATER_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_COLOR, mSimOceanConfig.mAboveWaterFogColor ) ) )
	{
		mSimOceanConfig.mAboveWaterFogColor = DEF_SIM_ENV_COMP.mAboveWaterFogColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_FOG_ABOVEWATER_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_FOG_UNDERWATER_HEIGHT
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_HEIGHT, mSimOceanConfig.mUnderWaterFogHeight ) ) )
	{
		mSimOceanConfig.mUnderWaterFogHeight = DEF_SIM_ENV_COMP.mUnderWaterFogHeight;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_HEIGHT << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_FOG_UNDERWATER_COLOR
	if ( !(GetAttribute ( *elem, SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_COLOR, mSimOceanConfig.mUnderWaterFogColor ) ) )
	{
		mSimOceanConfig.mUnderWaterFogColor = DEF_SIM_ENV_COMP.mUnderWaterFogColor;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimEnvironmentXML::ATTRIB_FOG_UNDERWATER_COLOR << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	return retVal;
}

//++ BAWE-20110606: NIGHT_BODY
bool SimEnvironmentXML::CheckNightScene()
{
    return mSimOceanConfig.mIsNightScene;
}
//-- BAWE-20110606: NIGHT_BODY.