#ifndef _SIM_LEVEL_XML_H_
#define _SIM_LEVEL_XML_H_

//++ BAWE-20101025: LEAK DETECTION
#ifdef USE_VLD

#include <vld.h>

#endif
//++ BAWE-20101025: LEAK DETECTION

#include <string>
#include <xercesc/dom/DOMElement.hpp>
#include <osg/Vec2>
#include <osg/Vec3>
#include <osg/Vec4>
#include <dtUtil/Log.h>
#include <dtGame/GMComponent.h>

#include "../didActors/oceanconfigactor.h"

/**
 *
 *
 */
struct SimLevelObject
{
	enum eObjectType 
	{
		TYPE_UNKNOWN,
		TYPE_TERRAIN,
		TYPE_BUILDING,
		TYPE_SHIP,
		TYPE_BUOY,
        TYPE_TREE// BAWE-20111003: PEPOHONAN
	}				mType;
	std::string		mName;
	std::string		mMesh;
	osg::Vec3f		mTranslationXYZ;
	osg::Vec3f		mRotationHPR;

	////////////////////////////////////////////////////////////////
	// Constructor / Destructor
	SimLevelObject();

	~SimLevelObject();
};
/**
 *
 *
 */
struct SimLevelComp
{
	////////////////////////////////////////////////////////////////////
	// VARIABLES
		SimLevelObject mTerrain;
		std::vector<SimLevelObject> mStaticBuildings;
		std::vector<SimLevelObject> mStaticShips;
		std::vector<SimLevelObject> mStaticBuoys;
        std::vector<SimLevelObject> mStaticTrees; // BAWE-20111003: PEPOHONAN
        


	////////////////////////////////////////////////////////////////////
	// METHODS

		////////////////////////////////////////////////////////////////
		// Constructor / Destructor
		SimLevelComp();

		~SimLevelComp();

};

/**
 *
 *
 */
class SimLevelXML :
		public dtGame::GMComponent
{
	//CONSTANTS & METHODS
	public:
		////////////////////////////////////////////////////////////////
		//Constants
		static const SimLevelComp DEF_SIM_LEVEL_COMP;		///<default sim level component

		static const std::string TAG_LEVEL;					///<level tag

		static const std::string TAG_TERRAIN;				///<terrain tag
		static const std::string TAG_STATIC_BUILDINGS;		///<static_buildings tag
		static const std::string TAG_BUILDING;				///<building tag
		static const std::string TAG_STATIC_SHIPS;			///<static_ships tag
		static const std::string TAG_SHIP;					///<ship tag
		static const std::string TAG_STATIC_BUOYS;			///<static_buoys tag
		static const std::string TAG_BUOY;					///<buoy tag
        //++ BAWE-20111003: PEPOHONAN
        static const std::string TAG_STATIC_TREES;			///<static_trees tag
        static const std::string TAG_TREE;	        		///<tree tag
        //-- BAWE-20111003: PEPOHONAN

		static const std::string ATTRIB_NAME;				///<name attribute
		static const std::string ATTRIB_MESH;				///<mesh attribute
		static const std::string ATTRIB_TRANSLATION;		///<translation attribute
		static const std::string ATTRIB_ROTATION;			///<rotation attribute
        //++ BAWE-20111003: PEPOHONAN
        //static const std::string ATTRIB_TEXTURE;			///<texture attribute. NULL = check 
        //-- BAWE-20111003: PEPOHONAN

		////////////////////////////////////////////////////////////////
		// Constructor / Destructor
		SimLevelXML();
		~SimLevelXML();

		////////////////////////////////////////////////////////////////
		// Generic methods
		/** 
		 * 
		 */
		bool LoadXML( const std::string& fileName );

		/** 
		 * 
		 */
		SimLevelComp GetLevelComponent( ) const
		{
			return mSimLevelComp;
		}

		/** 
		 * 
		 */
		bool IsSuccessful( ) const
		{
			return mIsSuccessful;
		}

	//METHODS
	private:
		/** 
		 * Parsing XML file 
		 */
		bool ParseXML(std::string fileName);

		/** 
		 * Get the Element Attribute
		 */
		std::string GetElementAttribute( xercesc::DOMElement& element
										  , const std::string& attribName
										  );

		/** 
		 * Get the a string Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , std::string& result
						 );

		/** 
		 * Get the a boolean Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , bool& result
						 );

		/** 
		 * Get the a float Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , float& result
						 );

		/** 
		 * Get the an integer Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , int& result
						 );

		/** 
		 * Get the an vector 2f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec2f& result
						 );


		/** 
		 * Get the an vector 3f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec3f& result
						 );


		/** 
		 * Get the an vector 4f Element Attribute
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec4f& result
						 );

		/**
		 * Parsing terrain element
		 */
		bool ParseTerrainElement( xercesc::DOMElement *elem );

		/**
		 * Parsing static_ buildings element
		 */
		bool ParseStaticBuildingsElement( xercesc::DOMElement *elem );

		/**
		 * Parsing building element
		 */
		bool ParseBuildingElement( xercesc::DOMElement *elem );

		/**
		 * Parsing static_ships element
		 */
		bool ParseStaticShipsElement( xercesc::DOMElement *elem );

		/**
		 * Parsing ship element
		 */
		bool ParseShipElement( xercesc::DOMElement *elem );

		/**
		 * Parsing static_buoys element
		 */
		bool ParseStaticBuoysElement( xercesc::DOMElement *elem );

		/**
		 * Parsing buoy element
		 */
		bool ParseBuoyElement( xercesc::DOMElement *elem );

        //++ BAWE-20111003: PEPOHONAN
        /**
        * Parsing static_trees element
        */
        bool ParseStaticTreesElement( xercesc::DOMElement *elem );

        /**
        * Parsing tree element
        */
        bool ParseTreeElement( xercesc::DOMElement *elem );
        //-- BAWE-20111003: PEPOHONAN

	//VARIABLES
	// Protected Members
	protected:
		dtUtil::Log& mLogger;

	private:
		////////////////////////////////////////////////////////////////
		//Vars
		bool		 mIsSuccessful;
		SimLevelComp mSimLevelComp;

		

};

#endif