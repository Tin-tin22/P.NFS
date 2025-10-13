#pragma once

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include <vector>
#include "../didCommon/BaseConstant.h"
#include "../didUtils/SimActorDefinitions.h"
#include "../didSimUnit/didJoystickComponent.h"
#include <dtCore/Transform.h>
#include <xercesc/dom/DOMElement.hpp>
#include <dtGame/GMComponent.h>
#include <dtGame/gameactor.h>

#include <iostream>



/**
	class manager component actor dari xml
**/
class SimActorDefXML :
		public dtGame::GMComponent
{
	public:
		SimActorDefXML();

		bool LoadXML(std::string fileName);

		// ini untuk parent saja
		std::vector<SimActorShipDef*> mVehicleActors;

		// dtCore::RefPtr<dtGame::GameActorProxy> CreateActor(std::string shipID, std::string name);
		dtCore::RefPtr<dtGame::GameActorProxy> CreateActor( std::string name);

		/**
		* Function called by a GameManager to process Messages. This function forwards the connection related
		* messages to the functions processing these messages.
		* @param The Message to be process
		*/        
		void ProcessMessage(const dtGame::Message& msg); 

		SimActorShipDef* FindActorCompDefByName(std::string name);
		
	protected : 
		virtual ~SimActorDefXML() ;

	private :

		bool IsActorFound;

  	//XML element and attributes found in SHIPLIST.XML
		static const std::string SHIPLIST_ELEMENT;

		static const std::string COMPONENT_ELEMENT;
		static const std::string COMPONENT_ATTRIBUTE_ID;
		static const std::string COMPONENT_ATTRIBUTE_TYPE;
		static const std::string COMPONENT_ATTRIBUTE_NAME;
		static const std::string COMPONENT_ATTRIBUTE_CATEGORY;
		static const std::string COMPONENT_ATTRIBUTE_CATEGORY_NAME;
		static const std::string COMPONENT_ATTRIBUTE_COUNT;

		//++ BAWE-20101118: PHYSICS_ATTRIBUTE
		static const std::string PHYSICS_ELEMENT;

		//Armand
		//static const std::string COMPONENT_ATTRIBUTE_LENGTH;
		//static const std::string COMPONENT_ATTRIBUTE_WIDTH;
		//static const std::string COMPONENT_ATTRIBUTE_HEIGHT;

 		static const std::string PHYSICS_ATTRIBUTE_LENGTH;
		static const std::string PHYSICS_ATTRIBUTE_WIDTH;
		static const std::string PHYSICS_ATTRIBUTE_HEIGHT;
		static const std::string PHYSICS_ATTRIBUTE_MAX_AHEAD;
		static const std::string PHYSICS_ATTRIBUTE_MAX_ASTERN;
		static const std::string PHYSICS_ATTRIBUTE_MAX_STEER;

		static const std::string PHYSICS_ATTRIBUTE_CONTROL_TYPE;  

		static const std::string PHYSICS_ATTRIBUTE_IS_TARGET;  

		static const std::string COMPONENT_ATTRIBUTE_TYPE_SHIP;

		static const std::string CAMERA_ELEMENT;
		static const std::string MESH_ELEMENT;
		static const std::string TRANSLATION_ELEMENT;
		static const std::string ROTATION_ELEMENT;

		static const std::string CAMERA_ATTRIBUTE_USE;

		static const std::string ATTRIBUTE_X;
		static const std::string ATTRIBUTE_Y;
		static const std::string ATTRIBUTE_Z;


		void AddCompDef(SimActorShipDef* actDef)
		{
			mVehicleActors.push_back(actDef);
		};

		bool ParseXML(std::string fileName);
		SimActorShipDef* ParseComponentElem(xercesc::DOMElement *compElem, bool AddedToManager);
		void ParseCameraElem(xercesc::DOMElement *cameraElem, SimActorShipDef& compDef);
		void ParseMeshElem(xercesc::DOMElement *meshElem, SimActorShipDef& compDef);
		void ParsePhysicsElem(xercesc::DOMElement *physicsElem, SimActorShipDef& compDef);
		void ParseTranslationElem(xercesc::DOMElement *transElem, SimActorShipDef& compDef);
		void ParseRotationElem(xercesc::DOMElement *rotElem, SimActorShipDef& compDef);

		dtCore::RefPtr<dtGame::GameActorProxy> CreateComponent(SimActorShipDef* actDef,  std::string name, 
			bool isChild = false );
		SimActorShipDef* FindActorCompDef(SimActorShipDef* actComp, std::string type);

		SimActorShipDef* GetActorCompDef(std::string actName);
		std::string GetElementAttribute(xercesc::DOMElement &element, const std::string &attribName);
};
