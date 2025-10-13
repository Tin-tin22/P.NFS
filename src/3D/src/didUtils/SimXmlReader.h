#include <string>
#include <xercesc/dom/DOMElement.hpp>
#include <osg/Vec2>
#include <osg/Vec3>
#include <osg/Vec4>
#include <dtUtil/Log.h>
#include <dtGame/GMComponent.h>

#include <xercesc/dom/DOM.hpp>
#include <xercesc/dom/DOMDocument.hpp>
#include <xercesc/dom/DOMDocumentType.hpp>
#include <xercesc/dom/DOMImplementation.hpp>
#include <xercesc/dom/DOMImplementationLS.hpp>
#include <xercesc/dom/DOMNodeIterator.hpp>
#include <xercesc/dom/DOMNodeList.hpp>
#include <xercesc/dom/DOMText.hpp>
#include <xercesc/parsers/XercesDOMParser.hpp>

#include "../didActors/oceanconfigactor.h"

//FORWARD DECLARATION
class SimXmlReader;

/**
 * @todo: add doxygen comments
 *
 */
class SimXmlAttribute  
{
	public:
	////////////////////////////////////////////////////////////////////
	// ENUM
		/** 
		 * @todo: add doxygen comments
		 */
		enum SimXmlAttributeType
		{
			XML_ATTRIB_STRING,
			XML_ATTRIB_BOOL,
			XML_ATTRIB_INT,
			XML_ATTRIB_FLOAT,
			XML_ATTRIB_VEC2F,
			XML_ATTRIB_VEC3F,
			XML_ATTRIB_VEC4F
		};

	////////////////////////////////////////////////////////////////////
	// METHODS
		/** 
		 * Get the Element Attribute
		 * @todo: add more explanation
		 */
		std::string GetElementAttribute( xercesc::DOMElement& element
										  , const std::string& attribName
										  );

		/** 
		 * Get the Element Attribute as a string 
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , std::string& result
						 , const std::string& defValue = ""
						 );

		/** 
		 * Get the Element Attribute as a boolean 
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , bool& result
						 , bool defValue = false
						 );

		/** 
		 * Get the Element Attribute as a float 
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , float& result
						 , float defValue = 0.0f
						 );

		/** 
		 * Get the Element Attribute as an integer
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , int& result
						 , int defValue = 0
						 );

		/** 
		 * Get the Element Attribute as a vector 2f
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec2f& result
						 , const osg::Vec2f& defValue = osg::Vec2f()
						 );


		/** 
		 * Get the Element Attribute as a vector 3f
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec3f& result
						 , const osg::Vec3f& defValue = osg::Vec3f()
						 );


		/** 
		 * Get the Element Attribute as a vector 4f
		 * @todo: add more explanation
		 */
		bool GetAttribute( xercesc::DOMElement& element
						 , const std::string& attribName
						 , osg::Vec4f& result
						 , const osg::Vec4f& defValue = osg::Vec4f()
						 );
	private:

};

/**
 * @todo: add doxygen comments
 *
 */
class SimXmlTag 
{

	public:
		friend class SimXmlReader;

	////////////////////////////////////////////////////////////////////
	// STRUCTS
		/** 
		 * @todo: add doxygen comments
		 */
		struct sSimAttribIdentifier
		{
			std::string								name;			///< The name of the attribute
			SimXmlAttribute::SimXmlAttributeType	type;			///< The type of the attribute
		};


	////////////////////////////////////////////////////////////////////
	// METHODS
	
		////////////////////////////////////////////////////////////////
		// Constructor / Destructor
		/** 
		 * @todo: add doxygen comments
		 */
		SimXmlTag(): mTagName("")
		{
			mAttribIdentifiers.clear();
			mChildTags.clear();
			mMemberAttribs.clear();
		}

		/** 
		 * @todo: add doxygen comments
		 */
		SimXmlTag(const std::string& tagName): mTagName(tagName)
		{
			mAttribIdentifiers.clear();
			mChildTags.clear();
			mMemberAttribs.clear();
		}

		/** 
		 * @todo: add doxygen comments
		 */
		~SimXmlTag()
		{
			mAttribIdentifiers.clear();
			mChildTags.clear();
			mMemberAttribs.clear();
		}

		////////////////////////////////////////////////////////////////
		// Generic Methods
		/** 
		 * @todo: add doxygen comments
		 */
		bool ParseTagElement(xercesc::DOMElement *elem);

		/** 
		 * @todo: add doxygen comments
		 */
		void AppendAttribIdentifier(sSimAttribIdentifier attribIdent);

		/** 
		 * @todo: add doxygen comments
		 */
		void SetTagName(const std::string& tagName);
		/** 
		 * @todo: add doxygen comments
		 */
		const std::string GetTagName() const;

	private:


	////////////////////////////////////////////////////////////////////
	// VARIABLES
	protected:

		std::string										mTagName;				///< The name / label of the tag
		std::vector<sSimAttribIdentifier>				mAttribIdentifiers;		///< The vector that holds the type and name of the attributes that will be extracted from this tag. This should be unique.

		std::vector<SimXmlTag>							mChildTags;				///< The vector that holds the other tags that has become this tag's children
		std::map<sSimAttribIdentifier, SimXmlAttribute>	mAttributes;			///< The vector that holds the attributes data of this tag
};

/**
 * @todo: add doxygen comments
 *
 */
class SimXmlReader
{
	//CONSTANTS & METHODS
	public:
		////////////////////////////////////////////////////////////////
		//Constants

		////////////////////////////////////////////////////////////////
		// Constructor / Destructor
		/** 
		 * @todo: add doxygen comments
		 */
		SimXmlReader();

		/** 
		 * @todo: add doxygen comments
		 */
		~SimXmlReader();

		////////////////////////////////////////////////////////////////
		// Generic methods
		/** 
		 * @todo: add doxygen comments
		 */
		bool LoadXML( const std::string& fileName
					, const std::string& rootTagName = ""
					, bool isCriticalError = false
					);


	//METHODS
	private:
		/** 
		 * Parsing XML file 
		 * @todo: add doxygen comments
		 */
		virtual bool ParseXML( const std::string& fileName
							 , const std::string& rootTagName
							 , bool isCriticalError 
							 );

	//VARIABLES
	// Protected Members
	protected:
		dtUtil::Log&					mLogger;				///< The logger object

		////////////////////////////////////////////////////////////////
		//Vars
		std::string						mXmlFilePathName;		///< Full path filename of the xml file
		std::string						mRootTagName;			///< The tag name (or label?) of the root (default: root)

		bool							mIsCriticalError;		///< Is the XML critical or not? If true, throw critical exception on error. If not, just log the error.

		xercesc::XercesDOMParser		mXmlParser;				///< Xerces parser
		xercesc::DOMDocument			*mXmlDoc;				///< Xerces DOM document
		xercesc::DOMElement				*mXmlRootDomElement;	///< The first Xerces DOM element (root element)

		SimXmlTag						mRootXmlTagData;		///< The root data extracted from the XML. 

};
