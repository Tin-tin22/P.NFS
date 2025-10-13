#include "../didCommon/const.h"

#include <vector>
#include <dtCore/Transform.h>
#include <xercesc/dom/DOMElement.hpp>
#include <dtGame/gameactor.h>
#include <dtGame/GMComponent.h>

class SimScenarioComponent;

/**
	class scenario XML
**/
class SimScenarioXML :
		public dtGame::GMComponent
{
	public :
		bool LoadXML(std::string fileName);

		/*scenario name*/
		std::string Name;
		/*map center position*/
		osg::Vec3 mapCenter;

		SimScenarioXML() ;

		/**
		* Function called by a GameManager to process Messages. This function forwards the connection related
		* messages to the functions processing these messages.
		* @param The Message to be process
		*/        
		void ProcessMessage(const dtGame::Message& msg); 

		// ini untuk parent saja
		std::vector<SimScenarioComponent*> mComponents;

		/* get element attribute */
		std::string GetModelTypeFromName(std::string name);
private :

		//XML element and attributes found in SCENARIO.XML
		static const std::string SCENARIO_ELEMENT;
		static const std::string SCENARIO_ATTRIBUTE_NAME;

		static const std::string MAP_ELEMENT;
		static const std::string COMPONENT_ELEMENT;

		static const std::string PLATFORM_ELEMENT;
		static const std::string LIOD_ELEMENT;
		static const std::string RADAR_ELEMENT;
		static const std::string CANNON_ELEMENT;

		static const std::string HEADING_ELEMENT;
		static const std::string HEADING_ATTRIBUTE_ELEMENT;
		
		static const std::string OWNER_ELEMENT;
		static const std::string OWNER_ATTRIBUTE_ID;
		static const std::string OWNER_ATTRIBUTE_TYPE;

		static const std::string POSITION_ELEMENT;
		static const std::string POSITION_ATTRIBUTE_X;
		static const std::string POSITION_ATTRIBUTE_Y;
		static const std::string POSITION_ATTRIBUTE_Z;

		static const std::string MODEL_ELEMENT;
		static const std::string MODEL_ATTRIBUTE_ID;
		static const std::string MODEL_ATTRIBUTE_CATEGORY;
		static const std::string MODEL_ATTRIBUTE_TYPE;
		static const std::string MODEL_ATTRIBUTE_NAME;
		static const std::string MODEL_ATTRIBUTE_TYPENAME;
		static const std::string MODEL_ATTRIBUTE_LOGIN;

	protected : 
		virtual ~SimScenarioXML() ;

	private :
		/* add component*/
		void AddComponents(SimScenarioComponent* comp)
		{
			mComponents.push_back(comp);
		};

		/* parsing XML file */
		bool ParseXML(std::string fileName);

		/* parsing component element*/
		void ParseComponentElem(xercesc::DOMElement *compElem);

		/* parsing component model element*/
		void ParseModelElement(xercesc::DOMElement *modelElem, SimScenarioComponent& comp );

		/* parsing component model position element*/
		void ParsePositionElement(xercesc::DOMElement *positionElem, SimScenarioComponent& comp );

		/* parsing owner element*/
		void ParseOwnerElement(xercesc::DOMElement *ownerElem, SimScenarioComponent& comp );

		/* parsing headin element*/
		void ParseHeadingElement(xercesc::DOMElement *headingElem, SimScenarioComponent& comp );

		/* parsing map element*/
		void ParseMapElement(xercesc::DOMElement *mapElem);

		/* get element attribute */
		std::string GetElementAttribute(xercesc::DOMElement &element, const std::string &attribName);

};

/**
**/

class SimScenarioOwnerModel
{
public :
	std::string OwnerLogin;
	std::string OwnerPassword;
	std::string OwnerType;
};

/**
	class component dari scenario
**/
class SimScenarioComponent
{
	public :
		/*model category*/
		std::string Category;
		/*model type*/
		std::string mType;
		/*model name*/
		std::string Name;
		/*model id*/
		int ComponentID;
		/*model position on Map*/
		osg::Vec3 compPosition;
		/*model heading*/
		float Heading;
	
		SimScenarioComponent() 
		{
			mModelType = MODE_SHIP;
		};

		void AddRole(std::string Login, std::string Pass, std::string role )
		{
			SimScenarioOwnerModel* mod;
			mod = new SimScenarioOwnerModel();

			mod->OwnerLogin = Login;
			mod->OwnerPassword = Pass;
			mod->OwnerType = role;

			mOwners.push_back(mod);
		};

		/**/
		SimScenarioOwnerModel* GetOwners(std::string role){
			for(std::vector<SimScenarioOwnerModel*>::iterator iter=mOwners.begin(); 
				iter!=mOwners.end(); iter++ ){
					if((*iter)->OwnerType == role)
					{
						return *iter;
					}
				}
			return NULL;
		};

	private :
		ModelType mModelType;
		std::vector<SimScenarioOwnerModel*> mOwners;
		
};
