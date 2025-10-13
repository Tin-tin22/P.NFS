#include "SimLevelXML.h"
#include "../didUtils/SimEnvironmentXML.h"

#include <sstream>
#include <iostream>

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
const SimLevelComp SimLevelXML::DEF_SIM_LEVEL_COMP = SimLevelComp();		///<default sim level component

const std::string SimLevelXML::TAG_LEVEL			= "level";				///<level tag 

const std::string SimLevelXML::TAG_TERRAIN			= "terrain";			///<terrain tag
const std::string SimLevelXML::TAG_STATIC_BUILDINGS	= "static_buildings";	///<static_buildings tag
const std::string SimLevelXML::TAG_BUILDING			= "building";			///<building tag
const std::string SimLevelXML::TAG_STATIC_SHIPS		= "static_ships";		///<static_ships tag
const std::string SimLevelXML::TAG_SHIP				= "ship";				///<ship tag
const std::string SimLevelXML::TAG_STATIC_BUOYS		= "static_buoys";		///<static_buoys tag
const std::string SimLevelXML::TAG_BUOY				= "buoy";				///<buoy tag
//++ BAWE-20111003: PEPOHONAN
const std::string SimLevelXML::TAG_STATIC_TREES		= "static_trees";		///<static_trees tag
const std::string SimLevelXML::TAG_TREE 			= "tree";				///<tree tag
//-- BAWE-20111003: PEPOHONAN

const std::string SimLevelXML::ATTRIB_NAME			= "name";				///<name attribute
const std::string SimLevelXML::ATTRIB_MESH			= "mesh";				///<mesh attribute
const std::string SimLevelXML::ATTRIB_TRANSLATION	= "translation";		///<translation attribute
const std::string SimLevelXML::ATTRIB_ROTATION		= "rotation";			///<rotation attribute

////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimLevelObject::SimLevelObject()
				: mType(TYPE_UNKNOWN)
				, mName("")
				, mMesh("")
				, mTranslationXYZ()
				, mRotationHPR()
{
}

SimLevelObject::~SimLevelObject()
{
}


////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimLevelComp::SimLevelComp()
				: mTerrain()
{
	mStaticBuildings.clear();
	mStaticShips.clear();
	mStaticBuoys.clear();
    mStaticTrees.clear(); // BAWE-20111003: PEPOHONAN
}

SimLevelComp::~SimLevelComp()
{
	mStaticBuildings.clear();
	mStaticShips.clear();
	mStaticBuoys.clear();
}


////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimLevelXML::SimLevelXML()
						: dtGame::GMComponent("SimLevelXML")
						, mLogger(dtUtil::Log::GetInstance("SimLevelXML.cpp"))
						, mIsSuccessful(false)
						, mSimLevelComp()
{
}

SimLevelXML::~SimLevelXML()
{
}

////////////////////////////////////////////////////////////////
// Generic methods
bool SimLevelXML::LoadXML(const std::string& fileName)
{
	mIsSuccessful = true;

	// parse XML
	if(!ParseXML(fileName)){
		mIsSuccessful = false;
	}

	return mIsSuccessful;
}

bool SimLevelXML::ParseXML( std::string fileName )
{
	bool success = true;

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

			error << "XML document \" "<< fileName <<" \" not found.";
			throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		}

		xercesc::DOMElement *scenario = xmlDoc->getDocumentElement();
		if (scenario == NULL)
			throw dtUtil::Exception("Level XML document is empty.", __FILE__, __LINE__);

		dtUtil::XMLStringConverter strConv(scenario->getTagName());
		if (strConv.ToString() != SimLevelXML::TAG_LEVEL)
			throw dtUtil::Exception("Malformed <level> element tag name.", __FILE__, __LINE__);

		xercesc::DOMNodeList *children = scenario->getChildNodes();
		for (XMLSize_t i=0; i<children->getLength(); i++)
		{
			xercesc::DOMNode *node = children->item(i);

			if (node == NULL)
				continue;
			if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
				continue;
			if (!success)
				break;

			xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
			dtUtil::XMLStringConverter strConv(element->getTagName());

			/* parse terrain element */
			if (strConv.ToString() == SimLevelXML::TAG_TERRAIN )
			{
				if (!ParseTerrainElement(element))
					success = false;
			}
			/* parse static_buildings element */
			else if (strConv.ToString() == SimLevelXML::TAG_STATIC_BUILDINGS )
			{
				if (!ParseStaticBuildingsElement(element))
					success = false;
			}
			/* parse static_ships element */
			else if (strConv.ToString() == SimLevelXML::TAG_STATIC_SHIPS )
			{
				if (!ParseStaticShipsElement(element))
					success = false;
			}	
			/* parse static_buoys element */
			else if (strConv.ToString() == SimLevelXML::TAG_STATIC_BUOYS )
			{
				if (!ParseStaticBuoysElement(element))
					success = false;
			}		
            //++ BAWE-20111003: PEPOHONAN
            /* parse trees element */
            else if (strConv.ToString() == SimLevelXML::TAG_STATIC_TREES )
			{
				if (!ParseStaticTreesElement(element))
					success = false;
			}
            //-- BAWE-20111003: PEPOHONAN

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

std::string SimLevelXML::GetElementAttribute( xercesc::DOMElement& element
													  , const std::string& attribName
													  )
{
  XMLCh *xmlChar = xercesc::XMLString::transcode(attribName.c_str());
  dtUtil::XMLStringConverter converter(element.getAttribute(xmlChar));
  xercesc::XMLString::release(&xmlChar);

  return converter.ToString();
}

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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

bool SimLevelXML::GetAttribute( xercesc::DOMElement& element
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


/* parsing terrain element*/
bool SimLevelXML::ParseTerrainElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_TERRAIN	<< "> tag..." <<std::endl;

    //++ BAWE-20110607: NIGHT_BODY
    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
    //-- BAWE-20110607: NIGHT_BODY

	mSimLevelComp.mTerrain.mType = SimLevelObject::eObjectType::TYPE_TERRAIN;

	///////////
	// ATTRIB_NAME
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_NAME, mSimLevelComp.mTerrain.mName ) ) )
	{
		mSimLevelComp.mTerrain.mName = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_NAME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else
	{
		mSimLevelComp.mTerrain.mName = "TERRAIN::" + mSimLevelComp.mTerrain.mName;
	}

	///////////
	// ATTRIB_MESH
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_MESH, mSimLevelComp.mTerrain.mMesh ) ) )
	{
		mSimLevelComp.mTerrain.mMesh = DEF_SIM_LEVEL_COMP.mTerrain.mMesh;

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_MESH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
    else if (simEnviXML->CheckNightScene())
    {
        std::size_t found = mSimLevelComp.mTerrain.mMesh.find_last_of("/\\");
        mSimLevelComp.mTerrain.mMesh.insert(found+1, "Night/");
    }    

	///////////
	// ATTRIB_TRANSLATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_TRANSLATION, mSimLevelComp.mTerrain.mTranslationXYZ ) ) )
	{
		mSimLevelComp.mTerrain.mTranslationXYZ = DEF_SIM_LEVEL_COMP.mTerrain.mTranslationXYZ;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_TRANSLATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_ROTATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_ROTATION, mSimLevelComp.mTerrain.mRotationHPR ) ) )
	{
		mSimLevelComp.mTerrain.mRotationHPR = DEF_SIM_LEVEL_COMP.mTerrain.mRotationHPR;

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_ROTATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_TERRAIN	<< "> tag." <<std::endl;

	return retVal;
}

/* parsing static_ships element*/
bool SimLevelXML::ParseStaticBuildingsElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_STATIC_BUILDINGS << "> tag..." <<std::endl;

	xercesc::DOMNodeList *children = elem->getChildNodes();
	for (XMLSize_t i=0; i<children->getLength(); i++)
	{
		xercesc::DOMNode *node = children->item(i);

		if (node == NULL)
			continue;
		if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
			continue;

		xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
		dtUtil::XMLStringConverter strConv(element->getTagName());

		if (strConv.ToString() == SimLevelXML::TAG_BUILDING)
			ParseBuildingElement(element);						
	}

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_STATIC_BUILDINGS << "> tag." <<std::endl;

	return retVal;
}
/* parsing building element*/
bool SimLevelXML::ParseBuildingElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_BUILDING << "> tag..." <<std::endl;

    //++ BAWE-20110607: NIGHT_BODY
    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
    //-- BAWE-20110607: NIGHT_BODY

	SimLevelObject building;

	building.mType = SimLevelObject::eObjectType::TYPE_BUILDING;

	///////////
	// ATTRIB_NAME
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_NAME, building.mName ) ) )
	{
		building.mName = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_NAME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else
	{
		building.mName = "BUILDING::" + building.mName;
	}

	///////////
	// ATTRIB_MESH
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_MESH, building.mMesh ) ) )
	{
		building.mMesh = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_MESH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

    else if (simEnviXML->CheckNightScene())
    {
        std::size_t found = building.mMesh.find_last_of("/\\");
        building.mMesh.insert(found+1, "Night/");
    }    

	///////////
	// ATTRIB_TRANSLATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_TRANSLATION, building.mTranslationXYZ ) ) )
	{
		building.mTranslationXYZ = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_TRANSLATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_ROTATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_ROTATION, building.mRotationHPR ) ) )
	{
		building.mRotationHPR = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_ROTATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	mSimLevelComp.mStaticBuildings.push_back(building);

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_BUILDING << "> tag." <<std::endl;

	return retVal;

}


/* parsing static_ships element*/
bool SimLevelXML::ParseStaticShipsElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_STATIC_SHIPS << "> tag..." <<std::endl;

	xercesc::DOMNodeList *children = elem->getChildNodes();
	for (XMLSize_t i=0; i<children->getLength(); i++)
	{
		xercesc::DOMNode *node = children->item(i);

		if (node == NULL)
			continue;
		if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
			continue;

		xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
		dtUtil::XMLStringConverter strConv(element->getTagName());

		if (strConv.ToString() == SimLevelXML::TAG_SHIP)
			ParseShipElement(element);						
	}

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_STATIC_SHIPS << "> tag." <<std::endl;

	return retVal;
}

/* parsing ship element*/
bool SimLevelXML::ParseShipElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_SHIP << "> tag..." <<std::endl;

	SimLevelObject ship;

	ship.mType = SimLevelObject::eObjectType::TYPE_SHIP;

    //++ BAWE-20110607: NIGHT_BODY
    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
    //-- BAWE-20110607: NIGHT_BODY

	///////////
	// ATTRIB_NAME
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_NAME, ship.mName ) ) )
	{
		ship.mName = "";

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_NAME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else
	{
		ship.mName = "SHIP::" + ship.mName;
	}

	///////////
	// ATTRIB_MESH
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_MESH, ship.mMesh ) ) )
	{
		ship.mMesh = "";

		std::ostringstream error;

		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_MESH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else if (simEnviXML->CheckNightScene())
	{
		std::size_t found = ship.mMesh.find_last_of("/\\");
		ship.mMesh.insert(found+1, "Night/");
	}     

	///////////
	// ATTRIB_TRANSLATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_TRANSLATION, ship.mTranslationXYZ ) ) )
	{
		ship.mTranslationXYZ = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_TRANSLATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_ROTATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_ROTATION, ship.mRotationHPR ) ) )
	{
		ship.mRotationHPR = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribut: "<< SimLevelXML::ATTRIB_ROTATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	mSimLevelComp.mStaticShips.push_back(ship);

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_SHIP << "> tag." <<std::endl;

	return retVal;
}



/* parsing static_buoys element*/
bool SimLevelXML::ParseStaticBuoysElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_STATIC_BUOYS << "> tag..." <<std::endl;

	xercesc::DOMNodeList *children = elem->getChildNodes();
	for (XMLSize_t i=0; i<children->getLength(); i++)
	{
		xercesc::DOMNode *node = children->item(i);

		if (node == NULL)
			continue;
		if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
			continue;

		xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
		dtUtil::XMLStringConverter strConv(element->getTagName());

		if (strConv.ToString() == SimLevelXML::TAG_BUOY)
			ParseBuoyElement(element);						
	}

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_STATIC_BUOYS << "> tag." <<std::endl;

	return retVal;
}
/* parsing buoy element*/
bool SimLevelXML::ParseBuoyElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_BUOY << "> tag..." <<std::endl;

	SimLevelObject buoy;

	buoy.mType = SimLevelObject::eObjectType::TYPE_BUOY;

    //++ BAWE-20110607: NIGHT_BODY
    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
    //-- BAWE-20110607: NIGHT_BODY

	///////////
	// ATTRIB_NAME
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_NAME, buoy.mName ) ) )
	{
		buoy.mName = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_NAME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else
	{
		buoy.mName = "BUOY::" + buoy.mName;
	}

	///////////
	// ATTRIB_MESH
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_MESH, buoy.mMesh ) ) )
	{
		buoy.mMesh = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_MESH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
    else if (simEnviXML->CheckNightScene())
    {
        std::size_t found = buoy.mMesh.find_last_of("/\\");
        buoy.mMesh.insert(found+1, "Night/");
    }    

	///////////
	// ATTRIB_TRANSLATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_TRANSLATION, buoy.mTranslationXYZ ) ) )
	{
		buoy.mTranslationXYZ = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_TRANSLATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_ROTATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_ROTATION, buoy.mRotationHPR ) ) )
	{
		buoy.mRotationHPR = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_ROTATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	mSimLevelComp.mStaticBuoys.push_back(buoy);

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_BUOY << "> tag." <<std::endl;

	return retVal;

}



/* parsing static_trees element*/
bool SimLevelXML::ParseStaticTreesElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_STATIC_TREES << "> tag..." <<std::endl;

	xercesc::DOMNodeList *children = elem->getChildNodes();
	for (XMLSize_t i=0; i<children->getLength(); i++)
	{
		xercesc::DOMNode *node = children->item(i);

		if (node == NULL)
			continue;
		if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
			continue;

		xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
		dtUtil::XMLStringConverter strConv(element->getTagName());

		if (strConv.ToString() == SimLevelXML::TAG_TREE)
			ParseTreeElement(element);						
	}

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_STATIC_TREES << "> tag." <<std::endl;

	return retVal;
}

/* parsing tree element*/
bool SimLevelXML::ParseTreeElement( xercesc::DOMElement *elem )
{
	bool retVal = true;

	//std::cout<< "Now parsing <" << SimLevelXML::TAG_TREE << "> tag..." <<std::endl;

	SimLevelObject tree;

	tree.mType = SimLevelObject::eObjectType::TYPE_TREE;

    //++ BAWE-20110607: NIGHT_BODY
    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));
    //-- BAWE-20110607: NIGHT_BODY

	///////////
	// ATTRIB_NAME
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_NAME, tree.mName ) ) )
	{
		tree.mName = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_NAME << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
	else
	{
		tree.mName = "TREE::" + tree.mName;
	}

	///////////
	// ATTRIB_MESH
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_MESH, tree.mMesh ) ) )
	{
		tree.mMesh = "";

		std::ostringstream error;

		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_MESH << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		//std::cout << error.str() <<  <<std::endl;
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}
    else if (simEnviXML->CheckNightScene())
    {
        std::size_t found = tree.mMesh.find_last_of("/\\");
        tree.mMesh.insert(found+1, "Night/");
    }    

	///////////
	// ATTRIB_TRANSLATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_TRANSLATION, tree.mTranslationXYZ ) ) )
	{
		tree.mTranslationXYZ = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_TRANSLATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	///////////
	//ATTRIB_ROTATION
	if ( !(GetAttribute ( *elem, SimLevelXML::ATTRIB_ROTATION, tree.mRotationHPR ) ) )
	{
		tree.mRotationHPR = osg::Vec3f();

		std::ostringstream error;
		error << "Error parsing attribute: "<< SimLevelXML::ATTRIB_ROTATION << ". Using default value instead.";

		//throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		mLogger.LogMessage(dtUtil::Log::LOG_WARNING, __FUNCTION__, __LINE__, \
                             error.str());
		retVal = false;
	}

	mSimLevelComp.mStaticTrees.push_back(tree);

	//std::cout<< "... done parsing <" << SimLevelXML::TAG_TREE << "> tag." <<std::endl;

	return retVal;

}


