#ifndef ENTITYTYPE_H
#define ENTITYTYPE_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.16. Identifies the type of entity, including kind of entity, domain (surface, subsurface, air, etc) country, category, etc.

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityType
{
protected:
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


 public:
    EntityType();
    virtual ~EntityType();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

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


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityType& rhs) const;
};
}

#endif
