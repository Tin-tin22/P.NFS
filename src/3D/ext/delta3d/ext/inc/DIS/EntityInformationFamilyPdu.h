#ifndef ENTITYINFORMATIONFAMILYPDU_H
#define ENTITYINFORMATIONFAMILYPDU_H

#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.3. Common superclass for EntityState, Collision, collision-elastic, and entity state update PDUs. This should be abstract. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityInformationFamilyPdu : public Pdu
{
protected:

 public:
    EntityInformationFamilyPdu();
    virtual ~EntityInformationFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityInformationFamilyPdu& rhs) const;
};
}

#endif
