#include "SimXmlReader.h"

#include <sstream>

#include <dtUtil/xercesutils.h>
#include <dtUtil/exception.h>

#include <dtUtil/stringutils.h>


////////////////////////////////////////////////////////////////
// Constructor / Destructor
SimXmlReader::SimXmlReader()
						: mLogger(dtUtil::Log::GetInstance("SimXmlReader.cpp"))
						, mXmlFilePathName("")
						, mRootTagName("root")
						, mIsCriticalError(false)
						, mXmlDoc(NULL)
						, mXmlRootDomElement(NULL)
{
}

SimXmlReader::~SimXmlReader()
{
}

////////////////////////////////////////////////////////////////
// Generic methods
bool SimXmlReader::LoadXML( const std::string& fileName, const std::string& rootTagName, bool isCriticalError )
{
	bool success = true;

	// parse XML
	if(!ParseXML(fileName, rootTagName, isCriticalError)){
		success = false;
	}

	return success;
}

bool SimXmlReader::ParseXML( const std::string& fileName,  const std::string& rootTagName, bool isCriticalError )
{
	bool success = true;

	mXmlFilePathName = fileName;
	mRootTagName = rootTagName;

	mIsCriticalError = isCriticalError;

	mXmlParser.setValidationScheme(xercesc::XercesDOMParser::Val_Never);
	mXmlParser.setDoNamespaces(false);
	mXmlParser.setDoSchema(false);
	mXmlParser.setLoadExternalDTD(false);

	try
	{
		mXmlParser.parse(mXmlFilePathName.c_str());

		mXmlDoc = mXmlParser.getDocument();
		if (mXmlDoc == NULL)
		{
			std::ostringstream error;
			error << "XML document \" "<< mXmlFilePathName <<" \" not found.";

			if (mIsCriticalError)
				throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
			else
				mLogger.LogMessage(dtUtil::Log::LOG_ERROR \
								  , __FUNCTION__, __LINE__ \
								  ,	error.str());

			success = false;
		}

		mXmlRootDomElement = mXmlDoc->getDocumentElement();
		if (mXmlRootDomElement == NULL)
		{
			std::ostringstream error;
			error << "XML document \" "<< mXmlFilePathName <<" \" is empty.";

			if (mIsCriticalError)
				throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
			else
				mLogger.LogMessage(dtUtil::Log::LOG_ERROR \
								  , __FUNCTION__, __LINE__ \
								  ,	error.str());

			success = false;
		}

		dtUtil::XMLStringConverter strConv(mXmlRootDomElement->getTagName());
		if (strConv.ToString() != rootTagName)
		{
			std::ostringstream error;
			error << "Malformed <" << rootTagName << "> element tag name.";

			if (mIsCriticalError)
				throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
			else
				mLogger.LogMessage(dtUtil::Log::LOG_ERROR \
								  , __FUNCTION__, __LINE__ \
								  ,	error.str());

			success = false;
		}

		//xercesc::DOMNodeList *children = scenario->getChildNodes();
		//for (XMLSize_t i=0; i<children->getLength(); i++)
		//{
		//	xercesc::DOMNode *node = children->item(i);

		//	if (node == NULL)
		//		continue;
		//	if (node->getNodeType() != xercesc::DOMNode::ELEMENT_NODE)
		//		continue;

		//	xercesc::DOMElement *element = static_cast<xercesc::DOMElement *>(node);
		//	dtUtil::XMLStringConverter strConv(element->getTagName());

		//	/* parse oceansurface element */
		//	if (strConv.ToString() == SimXmlReader::TAG_OCEANSURFACE )
		//		___ParseOceansurfaceElement(element);	
		//	/* parse skybox element */
		//	else if (strConv.ToString() == SimXmlReader::TAG_SKYBOX )
		//		___ParseSkyboxElement(element);						
		//	/* parse lighting element */
		//	else if (strConv.ToString() == SimXmlReader::TAG_LIGHTING )
		//		___ParseLightingElement(element);						
		//	/* parse fog element */
		//	else if (strConv.ToString() == SimXmlReader::TAG_FOG )
		//		___ParseFogElement(element);
		//}
	}
	catch (const xercesc::XMLException &e)
	{
		char *message = xercesc::XMLString::transcode(e.getMessage());
		std::ostringstream error;

		error << "Error parsing XML document: " << fileName << ".  Reason: " << message;

		xercesc::XMLString::release(&message);
		
		if (mIsCriticalError)
			throw dtUtil::Exception(error.str(), __FILE__, __LINE__);
		else
			mLogger.LogMessage(dtUtil::Log::LOG_ERROR \
							  , __FUNCTION__, __LINE__ \
							  ,	error.str());

		success = false;
	}
	catch (const xercesc::DOMException &e)
	{

	}

	return success;
}

std::string SimXmlReader::GetElementAttribute( xercesc::DOMElement& element
											  , const std::string& attribName
											  )
{
  XMLCh *xmlChar = xercesc::XMLString::transcode(attribName.c_str());
  dtUtil::XMLStringConverter converter(element.getAttribute(xmlChar));
  xercesc::XMLString::release(&xmlChar);

  return converter.ToString();
}

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , std::string& result
							   , const std::string& defValue 
							   )
{
	bool retVal = false;

	result = GetElementAttribute(element, attribName);
	if (result.size() > 0)
		retVal = true;

	return retVal;
}

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , bool& result
							   , const bool& defValue
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

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , float& result
							   , const float& defValue
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

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , int& result
							   , const int& defValue
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

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , osg::Vec2f& result
							   , const osg::Vec2f& defValue
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

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , osg::Vec3f& result
							   , const osg::Vec3f& defValue
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

bool SimXmlReader::GetAttribute( xercesc::DOMElement& element
							   , const std::string& attribName
							   , osg::Vec4f& result
							   , const osg::Vec4f& defValue
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
