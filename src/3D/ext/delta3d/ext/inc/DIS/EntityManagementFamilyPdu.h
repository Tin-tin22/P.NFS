#ifndef ENTITYMANAGEMENTFAMILYPDU_H
#define ENTITYMANAGEMENTFAMILYPDU_H

#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.9. Common superclass for EntityManagment PDUs, including aggregate state, isGroupOf, TransferControLRequest, and isPartOf

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO EntityManagementFamilyPdu : public Pdu
{
protected:

 public:
    EntityManagementFamilyPdu();
    virtual ~EntityManagementFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);


virtual int getMarshalledSize() const;

     bool operator  ==(const EntityManagementFamilyPdu& rhs) const;
};
}

#endif
