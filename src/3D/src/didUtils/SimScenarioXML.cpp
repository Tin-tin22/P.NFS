#include "SimScenarioXML.h"
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

#include <sstream>


/**
	class scenario XML definition
**/

/* definisi string XML */
const std::string SimScenarioXML::SCENARIO_ELEMENT("scenario");
const std::string SimScenarioXML::SCENARIO_ATTRIBUTE_NAME("name");

const std::string SimScenarioXML::MAP_ELEMENT("map");
const std::string SimScenarioXML::COMPONENT_ELEMENT("component");

const std::string SimScenarioXML::PLATFORM_ELEMENT("platform");
const std::string SimScenarioXML::LIOD_ELEMENT("liod");
const std::string SimScenarioXML::RADAR_ELEMENT("radar");
const std::string SimScenarioXML::CANNON_ELEMENT("cannon");

const std::string SimScenarioXML::HEADING_ELEMENT("heading");
const std::string SimScenarioXML::HEADING_ATTRIBUTE_ELEMENT("val");

const std::string SimScenarioXML::OWNER_ELEMENT("owner");
const std::string SimScenarioXML::OWNER_ATTRIBUTE_ID("ID");
const std::string SimScenarioXML::OWNER_ATTRIBUTE_TYPE("type");

const std::string SimScenarioXML::POSITION_ELEMENT("position");
const std::string SimScenarioXML::POSITION_ATTRIBUTE_X("x");
const std::string SimScenarioXML::POSITION_ATTRIBUTE_Y("y");
const std::string SimScenarioXML::POSITION_ATTRIBUTE_Z("z");

const std::string SimScenarioXML::MODEL_ELEMENT("model");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_ID("id");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_CATEGORY("category");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_TYPE("type");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_NAME("name");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_TYPENAME("typename");
const std::string SimScenarioXML::MODEL_ATTRIBUTE_LOGIN("login");


SimScenarioXML::SimScenarioXML():dtGame::GMComponent("ScenarioXMLComponent")
{	
	mComponents.clear();
  try
  {
      xercesc::XMLPlatformUtils::Initialize();
  }
  catch(const xercesc::XMLException &e)
  {
      char *message = xercesc::XMLString::transcode(e.getMessage());

      std::ostringstream error;
      error << "Error initializing XML toolkit: " << message;
      xercesc::XMLString::release(&message);
      throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
  }
};

SimScenarioXML::~SimScenarioXML() 
{
	mComponents.clear();
  try
  {
      xercesc::XMLPlatformUtils::Terminate();
  }
  catch(const xercesc::XMLException &e)
  {
      char *message = xercesc::XMLString::transcode(e.getMessage());

      std::ostringstream error;
      error << "Error shutting down XML toolkit: " << message;
      xercesc::XMLString::release(&message);
      throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
  }
};

bool SimScenarioXML::LoadXML(std::string fileName)
{
	bool success = true;

	// parse XML
	if(!ParseXML(fileName)){
		success = false;
	}

	return success;
};

std::string SimScenarioXML::GetModelTypeFromName(std::string name)
{
	for (std::vector<SimScenarioComponent*>::iterator iter = mComponents.begin(); iter != mComponents.end(); iter++)
	{
		/*
		if ((*iter)->Name == name){
		 	return (*iter)->mType;
		} modify by sam for login with related ship id*/ 

		if ((*iter)->Name == name)
		{
			std::ostringstream ost;
			ost << (*iter)->ComponentID;
			std::string shipId ;
			shipId = ost.str();
			return shipId;
		}

	}

	return "";
}

std::string SimScenarioXML::GetElementAttribute(xercesc::DOMElement &element, const std::string &attribName)
{
  XMLCh *xmlChar = xercesc::XMLString::transcode(attribName.c_str());
  dtUtil::XMLStringConverter converter(element.getAttribute(xmlChar));
  xercesc::XMLString::release(&xmlChar);

  return converter.ToString();
}

bool SimScenarioXML::ParseXML(std::string fileName)
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

        error << "Scenario XML document \" "<< fileName <<" \" not found.";
        throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
	  }

      xercesc::DOMElement *scenario = xmlDoc->getDocumentElement();
      if (scenario == NULL)
        throw dtUtil::Exception("Scenario XML document is empty.", __FILE__, __LINE__);

      dtUtil::XMLStringConverter strConv(scenario->getTagName());
			if (strConv.ToString() != SimScenarioXML::SCENARIO_ELEMENT)
        throw dtUtil::Exception("Malformed scenario element tag name.", __FILE__, __LINE__);

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

				/* parse map element */
				if (strConv.ToString() == SimScenarioXML::MAP_ELEMENT)
					ParseMapElement(element);						
				/* parse component element */
				else if (strConv.ToString() == SimScenarioXML::COMPONENT_ELEMENT)
	        ParseComponentElem(element);
      }
  }
  catch (const xercesc::XMLException &e)
  {
      char *message = xercesc::XMLString::transcode(e.getMessage());
      std::ostringstream error;

      error << "Error parsing ships file: " << fileName << ".  Reason: " <<
        message;

      xercesc::XMLString::release(&message);
      throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
			success = false;
  }
  catch (const xercesc::DOMException &e)
  {
      char *message = xercesc::XMLString::transcode(e.getMessage());
      std::ostringstream error;

      error << "Error processing DOM:  Reason: " << message;

      xercesc::XMLString::release(&message);
      throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
			success = false;
  }
	return success;
}

/* parsing component element*/
void SimScenarioXML::ParseComponentElem(xercesc::DOMElement *compElem)
{
  xercesc::DOMNodeList *children = compElem->getChildNodes();
  for (XMLSize_t i=0; i<children->getLength(); i++)
	{
      xercesc::DOMNode *node = children->item(i);

			if (node == NULL)
        continue;
      if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
        continue;

			//If we got here, we have either a uniform element or a source element.
      xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
      dtUtil::XMLStringConverter elemName(element->getTagName());

			if (elemName.ToString() == SimScenarioXML::MODEL_ELEMENT){
				SimScenarioComponent* newComp = new SimScenarioComponent();
        ParseModelElement(element,*newComp);
				AddComponents(newComp);
			}
	}
}

/* parsing component model element*/
void SimScenarioXML::ParseModelElement(xercesc::DOMElement *modelElem, SimScenarioComponent& comp )
{
	std::string valueString;
	int intValue = 0;

	// get id
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_ID);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> intValue;
		comp.ComponentID = intValue;
  }

	// get category 
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_CATEGORY);
  if (!valueString.empty())
	{
		comp.Category = valueString;
	}

	// get name
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_NAME);
  if (!valueString.empty())
  {
		comp.Name = valueString;
  }

	// get type
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_TYPE);
  if (!valueString.empty())
  {
		comp.mType = valueString;
  }

  // get typename
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_TYPENAME);
  if (!valueString.empty())
  {
		//TODO: assign to object typename
		//comp.TypeName = valueString;
  }

  // get login
	valueString = GetElementAttribute(*modelElem,SimScenarioXML::MODEL_ATTRIBUTE_LOGIN);
  if (!valueString.empty())
  {
		//TODO: assign to object login, for ?
		//comp.Login = valueString;
  }

  xercesc::DOMNodeList *children = modelElem->getChildNodes();
  for (XMLSize_t i=0; i<children->getLength(); i++)
	{
      xercesc::DOMNode *node = children->item(i);

			if (node == NULL)
        continue;
      if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
        continue;

			//If we got here, we have either a uniform element or a source element.
      xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
      dtUtil::XMLStringConverter elemName(element->getTagName());

			// parse position
			if (elemName.ToString() == SimScenarioXML::POSITION_ELEMENT)
        ParsePositionElement(element,comp);
			// parse owner
			else if (elemName.ToString() == SimScenarioXML::OWNER_ELEMENT)
				ParseOwnerElement(element,comp);
			// parse heading
			else if (elemName.ToString() == SimScenarioXML::HEADING_ELEMENT)
				ParseHeadingElement(element,comp);
	}
}

void SimScenarioXML::ParseHeadingElement(xercesc::DOMElement *headingElem, SimScenarioComponent& comp )
{
	std::string valueString;
	float floatValue = 0.0f;

	valueString = GetElementAttribute(*headingElem,SimScenarioXML::HEADING_ATTRIBUTE_ELEMENT);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
		comp.Heading = floatValue;
  }
}

void SimScenarioXML::ParseOwnerElement(xercesc::DOMElement *ownerElem, SimScenarioComponent& comp )
{
  xercesc::DOMNodeList *children = ownerElem->getChildNodes();
  for (XMLSize_t i=0; i<children->getLength(); i++)
	{
      xercesc::DOMNode *node = children->item(i);

			if (node == NULL)
        continue;
      if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
        continue;

			//If we got here, we have either a uniform element or a source element.
      xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
      dtUtil::XMLStringConverter elemName(element->getTagName());

			std::string loginString,passString,roleString;

			if (elemName.ToString() == SimScenarioXML::PLATFORM_ELEMENT)
			{
				loginString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_ID);
				passString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_TYPE);

				comp.AddRole(loginString,passString,C_ROLE_PLATFORM);
				//std::cout << "Login add : " << loginString << ":" << passString << ":platform" << std::endl;

				//AddRole
			}
			else if (elemName.ToString() == SimScenarioXML::LIOD_ELEMENT)
			{
				loginString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_ID);
				passString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_TYPE);

				comp.AddRole(loginString,passString,C_ROLE_LIOD);
				//std::cout << "Login add : " << loginString << ":" << passString << ":cannon" << std::endl;
			}
			else if (elemName.ToString() == SimScenarioXML::CANNON_ELEMENT)
			{
				loginString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_ID);
				passString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_TYPE);

				comp.AddRole(loginString,passString,C_ROLE_CANNON);
				//std::cout << "Login add : " << loginString << ":" << passString << ":cannon" << std::endl;
			}
			else if (elemName.ToString() == SimScenarioXML::RADAR_ELEMENT)
			{
				loginString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_ID);
				passString = GetElementAttribute(*element,SimScenarioXML::OWNER_ATTRIBUTE_TYPE);

				comp.AddRole(loginString,passString,C_ROLE_RADAR);
				//std::cout << "Login add : " << loginString << ":" << passString << ":radar" << std::endl;
			}
	}
}

/* parsing component model position element*/
void SimScenarioXML::ParsePositionElement(xercesc::DOMElement *positionElem, SimScenarioComponent& comp )
{
	std::string valueString;
	float floatValue = 0;
	float floatValueM = 0;

	// get id
	valueString = GetElementAttribute(*positionElem,SimScenarioXML::POSITION_ATTRIBUTE_X);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
	//floatValueM = (floatValue - C_RELATIVE_X)*DEF_DEGREE_TO_METRE; 
	comp.compPosition.x() = floatValue;
  }

	valueString = GetElementAttribute(*positionElem,SimScenarioXML::POSITION_ATTRIBUTE_Y);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
	//floatValueM = (floatValue - C_RELATIVE_Y)*DEF_DEGREE_TO_METRE; 
	comp.compPosition.y() = floatValue;
  }

	valueString = GetElementAttribute(*positionElem,SimScenarioXML::POSITION_ATTRIBUTE_Z);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
	comp.compPosition.z() = floatValue;//*DEF_DEGREE_TO_METRE;
  }
}

/* parsing map element*/
void SimScenarioXML::ParseMapElement(xercesc::DOMElement *mapElem)
{
	std::string valueString;
	float floatValue = 0;


	valueString = GetElementAttribute(*mapElem,SimScenarioXML::POSITION_ATTRIBUTE_X);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
		//TODO: assign to initial center of the camera as Long/lat
	//C_RELATIVE_X = floatValue; // disable, dianggap relative x adalah 0, penyesuaian peta di lakukan instruktur
  }

	valueString = GetElementAttribute(*mapElem,SimScenarioXML::POSITION_ATTRIBUTE_Y);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> floatValue;
		//TODO: assign to initial center of the camera as Long/lat
	 //C_RELATIVE_Y = floatValue;disable, dianggap relative x adalah 0, penyesuaian peta di lakukan instruktur
  }
}

void SimScenarioXML::ProcessMessage(const dtGame::Message& msg)
{
}
