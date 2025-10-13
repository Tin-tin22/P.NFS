#include "../didUtils/simactordefxml.h"
#include "../didCommon/BaseConstant.h"
#include "../didUtils/SimEnvironmentXML.h"
#include "../didActors/ShipActor.h"

#include <dtUtil/xercesutils.h>
#include <dtUtil/exception.h>
#include <sstream>
#include <xercesc/dom/DOM.hpp>
#include <xercesc/dom/DOMDocument.hpp>
#include <xercesc/dom/DOMDocumentType.hpp>
#include <xercesc/dom/DOMImplementation.hpp>
#include <xercesc/dom/DOMImplementationLS.hpp>
#include <xercesc/dom/DOMNodeIterator.hpp>
#include <xercesc/dom/DOMNodeList.hpp>
#include <xercesc/dom/DOMText.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>

#include <dtCore/refptr.h>
#include <dtCore/transform.h>
#include <dtDAL/ActorType.h>
#include <dtDAL/Actorproperty.h>
#include <dtDAL/floatactorproperty.h> // BAWE-20101124: PHYSICS_ATTRIBUTE

//==================================
const std::string SimActorDefXML::SHIPLIST_ELEMENT("ships");

const std::string SimActorDefXML::COMPONENT_ELEMENT("component");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_ID("id");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_TYPE("type");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_NAME("name");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_CATEGORY("category");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_CATEGORY_NAME("catname");
const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_COUNT("count");


const std::string SimActorDefXML::PHYSICS_ELEMENT("physics");

const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_LENGTH("length");
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_WIDTH("width");
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_HEIGHT("height");
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_AHEAD("max_ahead");
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_ASTERN("max_astern");
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_STEER("max_steer");

const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_CONTROL_TYPE("control_type"); 
const std::string SimActorDefXML::PHYSICS_ATTRIBUTE_IS_TARGET("is_target");


const std::string SimActorDefXML::COMPONENT_ATTRIBUTE_TYPE_SHIP(C_TYPE_SHIP);

const std::string SimActorDefXML::MESH_ELEMENT("mesh");
const std::string SimActorDefXML::TRANSLATION_ELEMENT("translation");
const std::string SimActorDefXML::ROTATION_ELEMENT("rotation");

const std::string SimActorDefXML::CAMERA_ELEMENT("camera");
const std::string SimActorDefXML::CAMERA_ATTRIBUTE_USE("use");

const std::string SimActorDefXML::ATTRIBUTE_X("x");
const std::string SimActorDefXML::ATTRIBUTE_Y("y");
const std::string SimActorDefXML::ATTRIBUTE_Z("z");


SimActorDefXML::SimActorDefXML():dtGame::GMComponent("ActorDefXMLComponent")
{
	mVehicleActors.clear();
  try
  {
      xercesc::XMLPlatformUtils::Initialize();
	  IsActorFound = false;
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

SimActorDefXML::~SimActorDefXML() 
{
	mVehicleActors.clear();
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

bool SimActorDefXML::ParseXML(std::string fileName)
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

        error << "Ship XML document \" "<< fileName <<" \" not found.";
        throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
	  }

	  xercesc::DOMElement *shipList = xmlDoc->getDocumentElement();
      if (shipList == NULL)
        throw dtUtil::Exception("Ship XML document is empty.", __FILE__, __LINE__);

      dtUtil::XMLStringConverter strConv(shipList->getTagName());
      if (strConv.ToString() != SimActorDefXML::SHIPLIST_ELEMENT)
        throw dtUtil::Exception("Malformed ships list element tag name.", __FILE__, __LINE__);

      xercesc::DOMNodeList *children = shipList->getChildNodes();
      for (XMLSize_t i=0; i<children->getLength(); i++)
      {
        xercesc::DOMNode *node = children->item(i);

        if (node == NULL)
            continue;
        if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
            continue;

        xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
				//std::cout << "Parsing element \n";
        ParseComponentElem(element, true);
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

SimActorShipDef* SimActorDefXML::ParseComponentElem(xercesc::DOMElement *shipCompElem, bool AddedToManager)
{
	dtUtil::XMLStringConverter strConv(shipCompElem->getTagName());
	if (strConv.ToString() != SimActorDefXML::COMPONENT_ELEMENT)
			throw dtUtil::Exception("Malformed shader group element tag name.", __FILE__, __LINE__);

  // 
	std::string cShipID = GetElementAttribute(*shipCompElem,
		SimActorDefXML::COMPONENT_ATTRIBUTE_ID);
	std::string type = GetElementAttribute(*shipCompElem,
		SimActorDefXML::COMPONENT_ATTRIBUTE_TYPE);
	std::string name = GetElementAttribute(*shipCompElem,
		SimActorDefXML::COMPONENT_ATTRIBUTE_NAME);
	std::string category = GetElementAttribute(*shipCompElem,
		SimActorDefXML::COMPONENT_ATTRIBUTE_CATEGORY);
	std::string catName = GetElementAttribute(*shipCompElem,
		SimActorDefXML::COMPONENT_ATTRIBUTE_CATEGORY_NAME);
	std::string count = GetElementAttribute(*shipCompElem,
	SimActorDefXML::COMPONENT_ATTRIBUTE_COUNT);

	//Armand


	//++ BAWE-20101118: PHYSICS_ATTRIBUTE

	//Armand
	//std::string length = GetElementAttribute(*shipCompElem,
	//	SimActorDefXML::COMPONENT_ATTRIBUTE_LENGTH);
	//std::string width = GetElementAttribute(*shipCompElem,
	//	SimActorDefXML::COMPONENT_ATTRIBUTE_WIDTH);
	//std::string height = GetElementAttribute(*shipCompElem,
	//	SimActorDefXML::COMPONENT_ATTRIBUTE_HEIGHT);
	//-- BAWE-20101118: PHYSICS_ATTRIBUTE

	//std::cout << "Found " << type << " component.\n";

	/* TAMBAHKAN TIPE COMPONENT DISINI JIKA ADA YANG BARU */
    TypeActor tyActor;
	if (type == SimActorDefXML::COMPONENT_ATTRIBUTE_TYPE_SHIP)
		tyActor = SHIP;

	SimActorShipDef* newCompDef = new SimActorShipDef();
	
	newCompDef->Category = category;
	newCompDef->CategoryName = catName;
	newCompDef->SetTypeActor(tyActor);
	newCompDef->Name = name;

	std::istringstream ss;
	if (cShipID != ""){
		ss.str(cShipID);
		ss >> newCompDef->shipID ;
	} 
	else
		newCompDef->shipID = 1;

	if (count != ""){
		ss.str(count);
		ss >> newCompDef->idCount ;
	} 
	else
		newCompDef->idCount = 1;
	

	xercesc::DOMNodeList *children = shipCompElem->getChildNodes();
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
			if (elemName.ToString() == SimActorDefXML::CAMERA_ELEMENT)
				// parse camera
				ParseCameraElem(element,*newCompDef);
			else if (elemName.ToString() == SimActorDefXML::COMPONENT_ELEMENT)
				// recurse the element
				newCompDef->AddCompDefChild(ParseComponentElem(element, false));
			else if (elemName.ToString() == SimActorDefXML::MESH_ELEMENT)
				// parse mesh
				ParseMeshElem(element,*newCompDef);
			else if (elemName.ToString() == SimActorDefXML::TRANSLATION_ELEMENT)
				//parse translation
				ParseTranslationElem(element,*newCompDef);
			else if (elemName.ToString() == SimActorDefXML::ROTATION_ELEMENT)
				// parse rotation
				ParseRotationElem(element,*newCompDef);
			else if (elemName.ToString() == SimActorDefXML::PHYSICS_ELEMENT)
				// parse rotation
				ParsePhysicsElem(element,*newCompDef);
	  else
		throw dtUtil::Exception("Foreign element found in shader XML source.", __FILE__, __LINE__);
	}

	if (AddedToManager)
		AddCompDef(newCompDef);

	return newCompDef;
}

void SimActorDefXML::ParseCameraElem(xercesc::DOMElement *cameraElem, SimActorShipDef& compDef)
{
  std::string valueString;
  float tempValue;

  SimActorCamera* actCam = new SimActorCamera();
  compDef.mCameras.push_back(actCam);

  // get name
  valueString = GetElementAttribute(*cameraElem,SimActorDefXML::CAMERA_ATTRIBUTE_USE);
  if (!valueString.empty())
  {
    actCam->Name = valueString;
  }
  
  // get x 
	valueString = GetElementAttribute(*cameraElem,SimActorDefXML::ATTRIBUTE_X);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> tempValue;
    actCam->camtranslation.x() = tempValue;
  }

	// get y 
	valueString = GetElementAttribute(*cameraElem,SimActorDefXML::ATTRIBUTE_Y);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> tempValue;
    actCam->camtranslation.y() = tempValue;
  }

	// get z 
	valueString = GetElementAttribute(*cameraElem,SimActorDefXML::ATTRIBUTE_Z);
  if (!valueString.empty())
  {
    std::istringstream ss;
    ss.str(valueString);
    ss >> tempValue;
    actCam->camtranslation.z() = tempValue;
  }
}

void SimActorDefXML::ParsePhysicsElem(xercesc::DOMElement *physicsElem, SimActorShipDef& compDef)
{
	std::string valueString;
	float tempValue;

	// get length 
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_LENGTH);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.length = tempValue;
	}

	// get width
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_WIDTH);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.width = tempValue;
	}

	// get height 
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_HEIGHT);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.height = tempValue;
	}

	// get max_ahead 
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_AHEAD);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.max_ahead = tempValue;
	}

	// get max_astern
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_ASTERN);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.max_astern = tempValue;
	}

	// get max_steer 
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_MAX_STEER);
	if (!valueString.empty())
	{
		std::istringstream ss;
		ss.str(valueString);
		ss >> tempValue;
		compDef.max_steer = tempValue;
	}

	// get the controller type
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_CONTROL_TYPE);

	std::transform(valueString.begin(), valueString.end(), valueString.begin(), toupper);

	if (valueString == "STEER") // If steering wheel
	{
		//compDef.control_type = didJoystickComponent::eJoystickType::STEER;
	}
	else // else = rudder
	{
		//compDef.control_type = didJoystickComponent::eJoystickType::RUDDER;
	}

	// get is target
	valueString = GetElementAttribute(*physicsElem, SimActorDefXML::PHYSICS_ATTRIBUTE_IS_TARGET);

	std::transform(valueString.begin(), valueString.end(), valueString.begin(), toupper);

	if (valueString == "TRUE") // If steering wheel
	{
		compDef.isTargetActor = true;
	}
	else  
	{
		compDef.isTargetActor = false;
	}
}


 

void SimActorDefXML::ParseMeshElem(xercesc::DOMElement *meshElem, SimActorShipDef& compDef)
{
	//The source element has one child:  The text specifing the source file.
	xercesc::DOMNodeList *children = meshElem->getChildNodes();
	if (children->getLength() != 1 || children->item(0)->getNodeType() != xercesc::DOMNode::TEXT_NODE)
			throw dtUtil::Exception("Mesh source should only have one child text element.", __FILE__, __LINE__);

	xercesc::DOMText *file = static_cast<xercesc::DOMText *>(children->item(0));

	dtUtil::XMLStringConverter fileConverter(file->getNodeValue());
	compDef.MeshName = fileConverter.ToString();
}

void SimActorDefXML::ParseTranslationElem(xercesc::DOMElement *transElem, SimActorShipDef& compDef)
{
  std::string valueString;
  float tempValue;

	// get x 
	valueString = GetElementAttribute(*transElem,SimActorDefXML::ATTRIBUTE_X);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.translation.x() = tempValue;
  }

	// get y 
	valueString = GetElementAttribute(*transElem,SimActorDefXML::ATTRIBUTE_Y);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.translation.y() = tempValue;
  }

	// get z 
	valueString = GetElementAttribute(*transElem,SimActorDefXML::ATTRIBUTE_Z);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.translation.z() = tempValue;
  }
}

void SimActorDefXML::ParseRotationElem(xercesc::DOMElement *rotElem, SimActorShipDef& compDef)
{
  std::string valueString;
  float tempValue;

	// get x 
	valueString = GetElementAttribute(*rotElem,SimActorDefXML::ATTRIBUTE_X);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.rotation.x() = tempValue;
  }

	// get y 
	valueString = GetElementAttribute(*rotElem,SimActorDefXML::ATTRIBUTE_Y);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.rotation.y() = tempValue;
  }

	// get z 
	valueString = GetElementAttribute(*rotElem,SimActorDefXML::ATTRIBUTE_Z);
  if (!valueString.empty())
  {
      std::istringstream ss;
      ss.str(valueString);
      ss >> tempValue;
			compDef.rotation.z() = tempValue;
  }
}

std::string SimActorDefXML::GetElementAttribute(xercesc::DOMElement &element, const std::string &attribName)
{
  XMLCh *xmlChar = xercesc::XMLString::transcode(attribName.c_str());
  dtUtil::XMLStringConverter converter(element.getAttribute(xmlChar));
  xercesc::XMLString::release(&xmlChar);

  return converter.ToString();
}

bool SimActorDefXML::LoadXML(std::string fileName)
{
	bool success = true;

	// parse XML
	if(!ParseXML(fileName)){
		success = false;
	}

	return success;
};

SimActorShipDef* SimActorDefXML::GetActorCompDef(std::string actName)
{
	return NULL;
};

void SimActorDefXML::ProcessMessage(const dtGame::Message& msg)
{

}

dtCore::RefPtr<dtGame::GameActorProxy> SimActorDefXML::CreateComponent(SimActorShipDef* actDef, std::string name, bool isChild )
{
	dtCore::RefPtr<const dtDAL::ActorType> atype;
	dtCore::RefPtr<dtDAL::ActorProxy> ap;
	dtCore::RefPtr<dtGame::GameActorProxy> gap;
	dtCore::RefPtr<dtGame::GameActor> ga;
	dtCore::RefPtr<dtGame::GameActorProxy> prChild;

    SimEnvironmentXML* simEnviXML = dynamic_cast <SimEnvironmentXML*>(GetGameManager()->GetComponentByName("SimEnvironmentXML"));

	if (actDef != NULL) {
		// std::cout << "create : " << actDef->Category << " name : " << actDef->CategoryName << "\n";
		atype =  GetGameManager()->FindActorType(actDef->Category,actDef->CategoryName);
		ap  = GetGameManager()->CreateActor(*atype);
		gap = dynamic_cast<dtGame::GameActorProxy*>(ap.get());
		ga   = dynamic_cast<dtGame::GameActor*>(gap->GetActor());

		std::ostringstream ost;
		if ( actDef->CategoryName == C_CN_SHIP || actDef->CategoryName == C_CN_SUBMARINE || actDef->CategoryName == C_CN_HELICOPTER
			|| actDef->CategoryName == C_CN_AIRCRAFT)
		{
			
			VehicleActor* actor = dynamic_cast<VehicleActor*> (ga.get());
			actor->SetName(actDef->Name);
			actor->SetVehicleID(actDef->shipID);
			actor->SetNight(simEnviXML->CheckNightScene());
			actor->SetIsTarget(actDef->isTargetActor);
			actor->SetMaxAheadSpeed(actDef->max_ahead);
			std::cout<<"max_ahead"<<actDef->max_ahead<<std::endl;

			if ( actor->GetIsTarget() )  
				std::cout<<GetName()<<" "<<actor->GetName()<<" is target "<<std::endl;

			dtCore::Transform tx;	
			tx.SetTranslation(actDef->translation.x(),actDef->translation.y(),actDef->translation.z());
			tx.SetRotation(360- actDef->rotation.x(), 360- actDef->rotation.y(), 360- actDef->rotation.z());
			ga->SetTransform(tx);
		}

		//else
		//if ( actDef->CategoryName == C_CN_ASROCKB || actDef->CategoryName == C_CN_ASROCKS )
		//{
		//	// todo
		//}
		////set property here
		gap->GetProperty(C_SET_MODEL)->FromString(actDef->MeshName);

		//if ((name != "") && (!isChild)) 
		//	gap->GetActor()->SetName(name);
		//else 
		//if ((name != "") && (isChild)) 
		//{
		//	// gap->GetActor()->SetName(actDef->Name + " " + name);
		//	gap->GetActor()->SetName(name+" "+ actDef->Name);
		//}
		//else 
		//	gap->GetActor()->SetName(actDef->Name);

		std::cout<<" Creating Actor XML :: "<<gap->GetActor()->GetName()<<std::endl;
		
		GetGameManager()->AddActor(*gap, false, false);
		
		/*for(std::vector<SimActorShipDef*>::iterator iter=actDef->mCompDefChilds.begin(); 
			iter!=actDef->mCompDefChilds.end(); iter++ )
		{
			prChild =  CreateComponent((*iter),name,true); 
			if ( prChild->GetGameActor().GetParent() != NULL ) 
				prChild->GetGameActor().GetParent()->RemoveChild(&(prChild->GetGameActor()));
			gap->GetActor()->AddChild(prChild->GetActor());
		}*/
	}
	return gap; 
}

SimActorShipDef* SimActorDefXML::FindActorCompDef(SimActorShipDef* actComp, std::string type)
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

dtCore::RefPtr<dtGame::GameActorProxy> SimActorDefXML::CreateActor( std::string name )
{
	SimActorShipDef* act = FindActorCompDefByName(name);

	if (act != NULL){
		return CreateComponent(act,name,false);
	}

	return NULL;
}


SimActorShipDef* SimActorDefXML::FindActorCompDefByName(std::string name)
{
	IsActorFound = false;
	SimActorShipDef* actComp;

	for(std::vector<SimActorShipDef*>::iterator iter=mVehicleActors.begin(); 
		iter!=mVehicleActors.end(); iter++ )
	{
		//std::cout << "Find " << name << " in " << (*iter)->Name << "\n";
		actComp = FindActorCompDef(*iter,name);
		if (IsActorFound) {
			//std::cout << name << " found in " << (*iter)->Name << "\n";
			break;
		}
	}
	return actComp;
}
