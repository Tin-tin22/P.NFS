#ifndef ENTITYID_H
#define ENTITYID_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Each entity in a given DIS simulation application shall be given an entity identifier number unique to all  other entities in that application. This identifier number is valid for the duration of the exercise; however,  entity identifier numbers may be reused when all possible numbers have been exhausted. No entity shall  have an entity identifier number of NO_ENTITY, ALL_ENTITIES, or RQST_ASSIGN_ID. The entity iden-  tifier number need not be registered or retained for future exercises. The entity identifier number shall be  specified by a 16-bit unsigned integer.  An entity identifier number equal to zero with valid site and application identification shall address a  simulation application. An entity identifier number equal to ALL_ENTITIES shall mean all entities within  the specified site and application. An entity identifier number equal to RQST_ASSIGN_ID allows the  receiver of the create entity to define the entity identifier number of the new entity.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityID
{
protected:
  // The site ID
  unsigned short _site; 

  // The application ID
  unsigned short _application; 

  // the entity ID
  unsigned short _entity; 


 public:
    EntityID();
    virtual ~EntityID();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned short getSite() const; 
    void setSite(unsigned short pX); 

    unsigned short getApplication() const; 
    void setApplication(unsigned short pX); 

    unsigned short getEntity() const; 
    void setEntity(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityID& rhs) const;
};
}

#endif
