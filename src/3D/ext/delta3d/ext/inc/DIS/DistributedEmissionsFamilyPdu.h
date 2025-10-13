#ifndef DISTRIBUTEDEMISSIONSFAMILYPDU_H
#define DISTRIBUTEDEMISSIONSFAMILYPDU_H

#include <DIS/Pdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7. Electronic Emissions. Abstract superclass for distirubted emissions PDU

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO DistributedEmissionsFamilyPdu : public Pdu
{
protected:

 public:
    DistributedEmissionsFamilyPdu();
    virtual ~DistributedEmissionsFamilyPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);


virtual int getMarshalledSize() const;

     bool operator  ==(const DistributedEmissionsFamilyPdu& rhs) const;
};
}

#endif
