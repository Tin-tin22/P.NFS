#ifndef ELECTRONICEMISSIONSYSTEMDATA_H
#define ELECTRONICEMISSIONSYSTEMDATA_H

#include <DIS/EmitterSystem.h>
#include <DIS/Vector3Float.h>
#include <DIS/ElectronicEmissionBeamData.h>
#include <vector>
#include <DIS/DataStream.h>
#include <DIS/msLibMacro.h>


namespace DIS
{
// Data about one electronic system

// Copyright (c) 2007, MOVES Institute, Naval Postgraduate School. All rights reserved. 
//
// This work is licensed under the BSD open source license, available at https://www.movesinstitute.org/licenses/bsd.html
//
// @author DMcG, jkg

class EXPORT_MACRO ElectronicEmissionSystemData
{
protected:
  // This field shall specify the length of this emitter system?s data (including beam data and its track/jam information) in 32-bit words. The length shall include the System Data Length field. 
  unsigned char _systemDataLength; 

  // This field shall specify the number of beams being described in the current PDU for the system being described. 
  unsigned char _numberOfBeams; 

  // padding.
  unsigned short _emissionsPadding2; 

  // This field shall specify information about a particular emitter system
  EmitterSystem _emitterSystem; 

  // Location with respect to the entity
  Vector3Float _location; 

  // variable length list of beam data records
  std::vector<ElectronicEmissionBeamData> _beamDataRecords; 


 public:
    ElectronicEmissionSystemData();
    virtual ~ElectronicEmissionSystemData();

    virtual void marshal(DataStream& dataStream) const;
    virtual void unmarshal(DataStream& dataStream);

    unsigned char getSystemDataLength() const; 
    void setSystemDataLength(unsigned char pX); 

    unsigned char getNumberOfBeams() const; 

    unsigned short getEmissionsPadding2() const; 
    void setEmissionsPadding2(unsigned short pX); 

    EmitterSystem& getEmitterSystem(); 
    const EmitterSystem&  getEmitterSystem() const; 
    void setEmitterSystem(const EmitterSystem    &pX);

    Vector3Float& getLocation(); 
    const Vector3Float&  getLocation() const; 
    void setLocation(const Vector3Float    &pX);

    std::vector<ElectronicEmissionBeamData>& getBeamDataRecords(); 
    const std::vector<ElectronicEmissionBeamData>& getBeamDataRecords() const; 
    void setBeamDataRecords(const std::vector<ElectronicEmissionBeamData>&    pX);


virtual int getMarshalledSize() const;

     bool operator  ==(const ElectronicEmissionSystemData& rhs) const;
};
}

#endif
