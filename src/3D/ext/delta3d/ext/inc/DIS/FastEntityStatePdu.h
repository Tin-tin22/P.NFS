#ifndef FASTENTITYSTATEPDU_H
#define FASTENTITYSTATEPDU_H

#include <DIS/ArticulationParameter.h>
#include <vector>
#include <DIS/EntityInformationFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.3.1. Represents the postion and state of one entity in the world. This is identical in function to entity state pdu, but generates less garbage to collect in the Java world. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO FastEntityStatePdu : public EntityInformationFamilyPdu
{
protected:
  // The site ID
  unsigned short _site; 

  // The application ID
  unsigned short _application; 

  // the entity ID
  unsigned short _entity; 

  // what force this entity is affiliated with, eg red, blue, neutral, etc
  unsigned char _forceId; 

  // How many articulation parameters are in the variable length list
  char _numberOfArticulationParameters; 

  // Kind of entity
  unsigned char _entityKind; 

  // Domain of entity (air, surface, subsurface, space, etc)
  unsigned char _domain; 

  // country to which the design of the entity is attributed
  unsigned short _country; 

  // category of entity
  unsigned char _category; 

  // subcategory of entity
  unsigned char _subcategory; 

  // specific info based on subcategory field
  unsigned char _specific; 

  unsigned char _extra; 

  // Kind of entity
  unsigned char _altEntityKind; 

  // Domain of entity (air, surface, subsurface, space, etc)
  unsigned char _altDomain; 

  // country to which the design of the entity is attributed
  unsigned short _altCountry; 

  // category of entity
  unsigned char _altCategory; 

  // subcategory of entity
  unsigned char _altSubcategory; 

  // specific info based on subcategory field
  unsigned char _altSpecific; 

  unsigned char _altExtra; 

  // X velo
  float _xVelocity; 

  // y Value
  float _yVelocity; 

  // Z value
  float _zVelocity; 

  // X value
  float _xLocation; 

  // y Value
  float _yLocation; 

  // Z value
  float _zLocation; 

  float _psi; 

  float _theta; 

  float _phi; 

  // a series of bit flags that are used to help draw the entity, such as smoking, on fire, etc.
  int _entityAppearance; 

  // enumeration of what dead reckoning algorighm to use
  unsigned char _deadReckoningAlgorithm; 

  // other parameters to use in the dead reckoning algorithm
  char _otherParameters[15]; 

  // X value
  float _xAcceleration; 

  // y Value
  float _yAcceleration; 

  // Z value
  float _zAcceleration; 

  // X value
  float _xAngularVelocity; 

  // y Value
  float _yAngularVelocity; 

  // Z value
  float _zAngularVelocity; 

  // characters that can be used for debugging, or to draw unique strings on the side of entities in the world
  char _marking[12]; 

  // a series of bit flags
  int _capabilities; 

  // variable length list of articulation parameters
  std::vector<ArticulationParameter> _articulationParameters; 


 public:
    FastEntityStatePdu();
    virtual ~FastEntityStatePdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSite() const; 
    void setSite(unsigned short pX); 

    unsigned short getApplication() const; 
    void setApplication(unsigned short pX); 

    unsigned short getEntity() const; 
    void setEntity(unsigned short pX); 

    unsigned char getForceId() const; 
    void setForceId(unsigned char pX); 

    char getNumberOfArticulationParameters() const; 

    unsigned char getEntityKind() const; 
    void setEntityKind(unsigned char pX); 

    unsigned char getDomain() const; 
    void setDomain(unsigned char pX); 

    unsigned short getCountry() const; 
    void setCountry(unsigned short pX); 

    unsigned char getCategory() const; 
    void setCategory(unsigned char pX); 

    unsigned char getSubcategory() const; 
    void setSubcategory(unsigned char pX); 

    unsigned char getSpecific() const; 
    void setSpecific(unsigned char pX); 

    unsigned char getExtra() const; 
    void setExtra(unsigned char pX); 

    unsigned char getAltEntityKind() const; 
    void setAltEntityKind(unsigned char pX); 

    unsigned char getAltDomain() const; 
    void setAltDomain(unsigned char pX); 

    unsigned short getAltCountry() const; 
    void setAltCountry(unsigned short pX); 

    unsigned char getAltCategory() const; 
    void setAltCategory(unsigned char pX); 

    unsigned char getAltSubcategory() const; 
    void setAltSubcategory(unsigned char pX); 

    unsigned char getAltSpecific() const; 
    void setAltSpecific(unsigned char pX); 

    unsigned char getAltExtra() const; 
    void setAltExtra(unsigned char pX); 

    float getXVelocity() const; 
    void setXVelocity(float pX); 

    float getYVelocity() const; 
    void setYVelocity(float pX); 

    float getZVelocity() const; 
    void setZVelocity(float pX); 

    float getXLocation() const; 
    void setXLocation(float pX); 

    float getYLocation() const; 
    void setYLocation(float pX); 

    float getZLocation() const; 
    void setZLocation(float pX); 

    float getPsi() const; 
    void setPsi(float pX); 

    float getTheta() const; 
    void setTheta(float pX); 

    float getPhi() const; 
    void setPhi(float pX); 

    int getEntityAppearance() const; 
    void setEntityAppearance(int pX); 

    unsigned char getDeadReckoningAlgorithm() const; 
    void setDeadReckoningAlgorithm(unsigned char pX); 

    char*  getOtherParameters(); 
    const char*  getOtherParameters() const; 
    void setOtherParameters( const char*    pX);

    float getXAcceleration() const; 
    void setXAcceleration(float pX); 

    float getYAcceleration() const; 
    void setYAcceleration(float pX); 

    float getZAcceleration() const; 
    void setZAcceleration(float pX); 

    float getXAngularVelocity() const; 
    void setXAngularVelocity(float pX); 

    float getYAngularVelocity() const; 
    void setYAngularVelocity(float pX); 

    float getZAngularVelocity() const; 
    void setZAngularVelocity(float pX); 

    char*  getMarking(); 
    const char*  getMarking() const; 
    void setMarking( const char*    pX);

    int getCapabilities() const; 
    void setCapabilities(int pX); 

    std::vector<ArticulationParameter>& getArticulationParameters(); 
    const std::vector<ArticulationParameter>& getArticulationParameters() const; 
    void setArticulationParameters(const std::vector<ArticulationParameter>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const FastEntityStatePdu& rhs) const;
};
}

#endif
