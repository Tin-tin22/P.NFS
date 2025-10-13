#ifndef WARFAREFAMILYPDU_H
#define WARFAREFAMILYPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.4. abstract superclass for fire and detonation pdus that have shared information. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO WarfareFamilyPdu : public Pdu
{
protected:
  // ID of the entity that shot
  EntityID _firingEntityID; 

  // ID of the entity that is being shot at
  EntityID _targetEntityID; 


 public:
    WarfareFamilyPdu();
    virtual ~WarfareFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getFiringEntityID(); 
    const EntityID&  getFiringEntityID() const; 
    void setFiringEntityID(const EntityID    &pX);

    EntityID& getTargetEntityID(); 
    const EntityID&  getTargetEntityID() const; 
    void setTargetEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const WarfareFamilyPdu& rhs) const;
};
}

#endif
