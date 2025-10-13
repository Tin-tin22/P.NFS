#ifndef WARFARE_H
#define WARFARE_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// abstract superclass for fire and detonation pdus that have shared information
class EXPORT_MACRO Warfare : public Pdu
{
protected:
  // ID of the entity that shot
  EntityID _firingEntityID; 

  // ID of the entity that is being shot at
  EntityID _targetEntityID; 


 public:
    Warfare();
    virtual ~Warfare();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getFiringEntityID(); 
    const EntityID&  getFiringEntityID() const; 
    void setFiringEntityID(const EntityID    &pX);

    EntityID& getTargetEntityID(); 
    const EntityID&  getTargetEntityID() const; 
    void setTargetEntityID(const EntityID    &pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const Warfare& rhs) const;
};
}

#endif
