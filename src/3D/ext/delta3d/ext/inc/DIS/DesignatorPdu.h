#ifndef DESIGNATORPDU_H
#define DESIGNATORPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Vector3Float.h>
#include <DIS/Vector3Double.h>
#include <DIS/Vector3Float.h>
#include <DIS/DistributedEmissionsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7.2. Handles designating operations. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO DesignatorPdu : public DistributedEmissionsFamilyPdu
{
protected:
  // ID of the entity designating
  EntityID _designatingEntityID; 

  // This field shall specify a unique emitter database number assigned to  differentiate between otherwise similar or identical emitter beams within an emitter system.
  unsigned short _codeName; 

  // ID of the entity being designated
  EntityID _designatedEntityID; 

  // This field shall identify the designator code being used by the designating entity 
  unsigned short _designatorCode; 

  // This field shall identify the designator output power in watts
  float _designatorPower; 

  // This field shall identify the designator wavelength in units of microns
  float _designatorWavelength; 

  // designtor spot wrt the designated entity
  Vector3Float _designatorSpotWrtDesignated; 

  // designtor spot wrt the designated entity
  Vector3Double _designatorSpotLocation; 

  // Dead reckoning algorithm
  char _deadReckoningAlgorithm; 

  // padding
  unsigned short _padding1; 

  // padding
  char _padding2; 

  // linear accelleration of entity
  Vector3Float _entityLinearAcceleration; 


 public:
    DesignatorPdu();
    virtual ~DesignatorPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getDesignatingEntityID(); 
    const EntityID&  getDesignatingEntityID() const; 
    void setDesignatingEntityID(const EntityID    &pX);

    unsigned short getCodeName() const; 
    void setCodeName(unsigned short pX); 

    EntityID& getDesignatedEntityID(); 
    const EntityID&  getDesignatedEntityID() const; 
    void setDesignatedEntityID(const EntityID    &pX);

    unsigned short getDesignatorCode() const; 
    void setDesignatorCode(unsigned short pX); 

    float getDesignatorPower() const; 
    void setDesignatorPower(float pX); 

    float getDesignatorWavelength() const; 
    void setDesignatorWavelength(float pX); 

    Vector3Float& getDesignatorSpotWrtDesignated(); 
    const Vector3Float&  getDesignatorSpotWrtDesignated() const; 
    void setDesignatorSpotWrtDesignated(const Vector3Float    &pX);

    Vector3Double& getDesignatorSpotLocation(); 
    const Vector3Double&  getDesignatorSpotLocation() const; 
    void setDesignatorSpotLocation(const Vector3Double    &pX);

    char getDeadReckoningAlgorithm() const; 
    void setDeadReckoningAlgorithm(char pX); 

    unsigned short getPadding1() const; 
    void setPadding1(unsigned short pX); 

    char getPadding2() const; 
    void setPadding2(char pX); 

    Vector3Float& getEntityLinearAcceleration(); 
    const Vector3Float&  getEntityLinearAcceleration() const; 
    void setEntityLinearAcceleration(const Vector3Float    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const DesignatorPdu& rhs) const;
};
}

#endif
