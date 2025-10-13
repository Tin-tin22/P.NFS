#ifndef RADIOENTITYTYPE_H
#define RADIOENTITYTYPE_H

#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.2.25. Identifies the type of radio

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO RadioEntityType
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
  unsigned char _nomenclatureVersion; 

  unsigned short _nomenclature; 


 public:
    RadioEntityType();
    virtual ~RadioEntityType();

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

    unsigned char getNomenclatureVersion() const; 
    void setNomenclatureVersion(unsigned char pX); 

    unsigned short getNomenclature() const; 
    void setNomenclature(unsigned short pX); 


virtual int getMarshalledSize() const;

     bool operator  ==(const RadioEntityType& rhs) const;
};
}

#endif
