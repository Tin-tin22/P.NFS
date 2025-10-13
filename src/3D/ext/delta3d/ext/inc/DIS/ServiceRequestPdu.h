#ifndef SERVICEREQUESTPDU_H
#define SERVICEREQUESTPDU_H

#include <DIS/EntityID.h>
#include <DIS/EntityID.h>
#include <DIS/SupplyQuantity.h>
#include <vector>
#include <DIS/LogisticsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.5.1. Information about a request for supplies. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ServiceRequestPdu : public LogisticsFamilyPdu
{
protected:
  // Entity that is requesting service
  EntityID _requestingEntityID; 

  // Entity that is providing the service
  EntityID _servicingEntityID; 

  // type of service requested
  unsigned char _serviceTypeRequested; 

  // How many requested
  unsigned char _numberOfSupplyTypes; 

  // padding
  short _serviceRequestPadding; 

  std::vector<SupplyQuantity> _supplies; 


 public:
    ServiceRequestPdu();
    virtual ~ServiceRequestPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getRequestingEntityID(); 
    const EntityID&  getRequestingEntityID() const; 
    void setRequestingEntityID(const EntityID    &pX);

    EntityID& getServicingEntityID(); 
    const EntityID&  getServicingEntityID() const; 
    void setServicingEntityID(const EntityID    &pX);

    unsigned char getServiceTypeRequested() const; 
    void setServiceTypeRequested(unsigned char pX); 

    unsigned char getNumberOfSupplyTypes() const; 

    short getServiceRequestPadding() const; 
    void setServiceRequestPadding(short pX); 

    std::vector<SupplyQuantity>& getSupplies(); 
    const std::vector<SupplyQuantity>& getSupplies() const; 
    void setSupplies(const std::vector<SupplyQuantity>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ServiceRequestPdu& rhs) const;
};
}

#endif
