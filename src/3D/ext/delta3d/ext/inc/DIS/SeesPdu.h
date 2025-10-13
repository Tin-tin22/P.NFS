#ifndef SEESPDU_H
#define SEESPDU_H

#include <DIS/EntityID.h>
#include <DIS/PropulsionSystemData.h>
#include <DIS/VectoringNozzleSystemData.h>
#include <vector>
#include <DIS/DistributedEmissionsFamilyPdu.h>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Section 5.3.7.5. SEES PDU, supplemental emissions entity state information. COMPLETE

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO SeesPdu : public DistributedEmissionsFamilyPdu
{
protected:
  // Originating entity ID
  EntityID _orginatingEntityID; 

  // IR Signature representation index
  unsigned short _infraredSignatureRepresentationIndex; 

  // acoustic Signature representation index
  unsigned short _acousticSignatureRepresentationIndex; 

  // radar cross section representation index
  unsigned short _radarCrossSectionSignatureRepresentationIndex; 

  // how many propulsion systems
  unsigned short _numberOfPropulsionSystems; 

  // how many vectoring nozzle systems
  unsigned short _numberOfVectoringNozzleSystems; 

  // variable length list of propulsion system data
  std::vector<PropulsionSystemData> _propulsionSystemData; 

  // variable length list of vectoring system data
  std::vector<VectoringNozzleSystemData> _vectoringSystemData; 


 public:
    SeesPdu();
    virtual ~SeesPdu();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    EntityID& getOrginatingEntityID(); 
    const EntityID&  getOrginatingEntityID() const; 
    void setOrginatingEntityID(const EntityID    &pX);

    unsigned short getInfraredSignatureRepresentationIndex() const; 
    void setInfraredSignatureRepresentationIndex(unsigned short pX); 

    unsigned short getAcousticSignatureRepresentationIndex() const; 
    void setAcousticSignatureRepresentationIndex(unsigned short pX); 

    unsigned short getRadarCrossSectionSignatureRepresentationIndex() const; 
    void setRadarCrossSectionSignatureRepresentationIndex(unsigned short pX); 

    unsigned short getNumberOfPropulsionSystems() const; 

    unsigned short getNumberOfVectoringNozzleSystems() const; 

    std::vector<PropulsionSystemData>& getPropulsionSystemData(); 
    const std::vector<PropulsionSystemData>& getPropulsionSystemData() const; 
    void setPropulsionSystemData(const std::vector<PropulsionSystemData>&    pX);

    std::vector<VectoringNozzleSystemData>& getVectoringSystemData(); 
    const std::vector<VectoringNozzleSystemData>& getVectoringSystemData() const; 
    void setVectoringSystemData(const std::vector<VectoringNozzleSystemData>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const SeesPdu& rhs) const;
};
}

#endif
